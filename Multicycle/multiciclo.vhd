library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity multiciclo is
	port(
		CLK, RESET: in std_logic
	);
end multiciclo;

architecture behavior of multiciclo is
	---agregue alu_out  address data
	signal pc_current, alu_out,address, mdr, data: std_logic_vector (31 downto 0);
	signal pc_next, pc_add, pc_jump, pc_branch: std_logic_vector (31 downto 0);
	signal instruction: std_logic_vector (31 downto 0);

	signal after_address: std_logic_vector (25 downto 0);
	signal RS, RD, RT: std_logic_vector(4 downto 0);
	signal funct: std_logic_vector (2 downto 0);
	signal imm: std_logic_vector(15 downto 0);
	-- Decode
	signal writeRegister: std_logic_vector (4 downto 0);
	signal Branch, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst: std_logic;
	signal PCSrc, ALUOp, ALUSrcB: std_logic_vector (1 downto 0);
	signal next_state: std_logic_vector (3 downto 0);
	signal opcode: std_logic_vector (5 downto 0);

	signal imm_extend_left, imm_extend, extend_final, shiftleft2, address_jump: std_logic_vector (31 downto 0);
	signal extend: std_logic_vector (31 downto 0);

	signal and_1: std_logic;
	-- Register, ALU
	signal registerWriteData: std_logic_vector(31 downto 0);
	signal data_A, data_B, A, A1, B, B1, result, final: std_logic_vector(31 downto 0);
	signal zero: std_logic;
	signal alu_operation: std_logic_vector(2 downto 0);
	-- Data
	signal jump_signal: std_logic_vector(13 downto 0);

	component Control port(
		opcode: in std_logic_vector (5 downto 0);
		clk, reset: in std_logic;
		Branch, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst: out std_logic;
		PCSrc, ALUOp, ALUSrcB: out std_logic_vector (1 downto 0)
	);
	end component;

	component RegisterFile port (
		registerWrite: in std_logic;
		registerRead1: in std_logic_vector(4 downto 0);
		registerRead2: in std_logic_vector(4 downto 0);
		writeRegister: in std_logic_vector(4 downto 0);
		registerWriteData: in std_logic_vector(31 downto 0);
		registerReadData1: out std_logic_vector(31 downto 0);
		registerReadData2: out std_logic_vector(31 downto 0)
	);
	end component;

	component sign_extend is
	port (
		a: in std_logic_vector(15 downto 0);
		b: out std_logic_vector(31 downto 0)
	);
	end component;


	component shift is
	port (
		a: in std_logic_vector(31 downto 0);
		b: out std_logic_vector(31 downto 0)
	);
	end component;


	component sign_extend_jump is
	port(
		a : in std_logic_vector(25 downto 0);
		b : out std_logic_vector(31 downto 0)
	);
	end component;

	component controlAlu  port (
		functions: in std_logic_vector(2 downto 0);
		ALUOp: in std_logic_vector(1 downto 0);
		alu_operation: out std_logic_vector(2 downto 0)
	);
	end component;

	---identica
	component alu port (
		A, B : in std_logic_vector (31 downto 0);
		alu_control : in std_logic_vector (2 downto 0);
		zero : out std_logic;
		result : out std_logic_vector (31 downto 0)
	);
	end component;

	component Memory port (
		MemWrite: in std_logic;
		MemRead: in std_logic;
		address: in std_logic_vector(31 downto 0);
		writeData: in std_logic_vector(31 downto 0);
		readData: out std_logic_vector(31 downto 0)
	);
	end component;

	component Reg
		generic (n: natural:= 31);
		port (
			data: in std_logic_vector(n downto 0);
			clk: in std_logic;
			q: out std_logic_vector(n downto 0)
		);
	end component;

	component Instruction_Register
		port (
			IRWrite: in  std_logic;
			instrucInput: in  std_logic_vector(31 downto 0);
			opCode: out std_logic_vector(5 downto 0);
			regRs: out std_logic_vector(4 downto 0);
			regRt: out std_logic_vector(4 downto 0);
			regRd: out std_logic_vector(4 downto 0);
			imm: out std_logic_vector(15 downto 0);
			jumpAddr: out std_logic_vector(25 downto 0);
			funcCode: out std_logic_vector(2 downto 0)
      );
	end component;

	component mux
		generic (n: natural:= 31);
		port (
			a, b: in std_logic_vector (n downto 0);
			s: std_logic;
			c: out std_logic_vector(n downto 0)
		);
	end component;

	component mux_4_to_1
		generic (n: natural:= 31);
		port(
			A,B,C: in std_logic_vector (n downto 0);
			S: in std_logic_vector(1 downto 0);
			Z: out std_logic_vector (n downto 0)
		);
	end component;

	begin

	process(CLK, RESET)
		begin
			if(RESET = '1') then
				-- La primera dirección que lee el PC tiene que estar más adelante.
				pc_current <= "00000000000000000000001000000000";
			elsif(CLK'event and CLK='1') then
				if ( (zero='1' and Branch='1') or PCWrite='1') then
					pc_current <= pc_next;
				end if;
			end if;
	end process;

	MUXPC: mux generic map(31) port map(
		a => pc_current,
		b => alu_out,
		c => address,
		s => IorD
	);

	RAM:  Memory port map (
		MemWrite => MemWrite,
		MemRead => MemRead,
		address => address,
		writeData => B,
		readData => data
	);

	RegMemData: Reg port map(
		clk => CLK,
		data => data,
		q => mdr
	);

	IR: Instruction_Register port map(
		IRWrite => IRWrite,
		instrucInput => data,
		opCode => opcode,
		regRs => RS,
		regRt => RT,
		regRd => RD,
		imm => imm,
		jumpAddr => after_address,
		funcCode => funct
	);

	Unit_Control: Control port map(
		opcode => opcode,
		clk => CLK,
		reset => RESET,
		Branch => Branch,
		PCWrite => PCWrite,
		IorD => IorD,
		MemRead => MemRead,
		MemWrite => MemWrite,
		MemtoReg => MemtoReg,
		IRWrite => IRWrite,
		ALUSrcA => ALUSrcA,
		RegWrite => RegWrite,
		RegDst => RegDst,
		PCSrc => PCSrc,
		ALUOp => ALUOp,
		ALUSrcB => ALUSrcB
	);

	MUXREG: mux generic map(4) port map(
		a => RT,
		b => RD,
		s => RegDst,
		c => writeRegister
	);

	MUXREGDATA: mux generic map(31) port map(
		a => alu_out,
		b => mdr,
		s => MemToReg,
		c => registerWriteData
	);

	Registers: RegisterFile port map(
		registerWrite => RegWrite,
		registerRead1 => RS,
		registerRead2 => RT,
		writeRegister => writeRegister,
		registerWriteData => registerWriteData,
		registerReadData1 => data_A,
		registerReadData2 => data_B
	);

	REGA: Reg port map(
		clk => CLK,
		data => data_A,
		q => A
	);

	REGB: Reg port map(
		clk => CLK,
		data => data_B,
		q => B
	);

	-- Sign extend
	EXTEND1: sign_extend port map(
		a => imm,
		b => imm_extend
	);

	MUXALUA: mux generic map(31) port map(
		a => pc_current,
		b => A,
		s => ALUSrcA,
		c => A1 -- ALU IN
	);

	MUXALUB: mux_4_to_1 generic map(31) port map(
		A => B,
		B => "00000000000000000000000000000001",
		C => imm_extend,
		S => ALUSrcB,
		Z => B1 -- ALU IN
	);

	-- ALU
	ALU_INS: alu port map(
		A => A1,
		B => B1,
		alu_control => alu_operation,
		zero => zero,
		result => result
	);

	REGALUOUT: Reg port map(
		clk => CLK,
		data => result,
		q => alu_out
	);

	ALUCONTROL: controlAlu port map(
		functions => funct,
		ALUOp => ALUOp,
		alu_operation => alu_operation
	);

	EXTEND2: sign_extend_jump port map(
		a => after_address,
		b => address_jump
	);

	MUXNEXTPC: mux_4_to_1 generic map(31) port map(
		A => result,
		B => alu_out,
		C => address_jump,
		S => PCSrc,
		Z => pc_next
	);

end behavior;
