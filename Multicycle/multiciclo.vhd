library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity CPU is
	port(
		CLK, RESET: in std_logic
	);
end CPU;

architecture behavior of CPU is
	---agregue alu_out  address data
	signal pc_current,alu_out,address,data: std_logic_vector (31 downto 0);
	signal pc_next, pc_add, pc_jump, pc_branch: std_logic_vector (31 downto 0);
	signal instruction: std_logic_vector (31 downto 0);
	-- Decode
	signal writeRegister: std_logic_vector (4 downto 0);
	signal Branch, PCwrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst: std_logic;
	signal PCSrc, ALUOp, ALUSrcB: std_logic_vector (1 downto 0);
	signal next_state: std_logic_vector (3 downto 0);
	signal opcode: std_logic_vector (5 downto 0);
	
	signal extend_final, shiftleft2, addressBranch: std_logic_vector (31 downto 0);
	signal extend: std_logic_vector (15 downto 0);
	
	signal and_1: std_logic;
	-- Register, ALU
	signal A, B, B1, result, final: std_logic_vector(31 downto 0);
	signal zero: std_logic;
	signal ALU_OPERATION: std_logic_vector(3 downto 0);
	-- Data
	signal readData: std_logic_vector(31 downto 0);
	signal jump_signal: std_logic_vector(27 downto 0);

	component Control port(
		opcode: in std_logic_vector (5 downto 0),
		clk, reset: in std_logic,
		Branch, PCwrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst: out std_logic,
		PCSrc, ALUOp, ALUSrcB: out std_logic_vector (1 downto 0),
	);
	end component;
	
	component RegisterFile port (
		clk: in std_logic;
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
	
	
	component shift_2 is
	port (
		a: in std_logic_vector(31 downto 0);
		b: out std_logic_vector(31 downto 0)
	);
	end component;
	
	
	component shift_jump is
	port (
		a: in std_logic_vector(25 downto 0);
		b: out std_logic_vector(27 downto 0)
	);
	end component;
	
	
	---esto es lo mismo
	component controlAlu port (
		functions: in std_logic_vector(5 downto 0);
		operationAlu: in std_logic_vector(1 downto 0);
		alu_control: out std_logic_vector(3 downto 0)
	);
	end component;
	
	---identica
	component alu port (
		A, B : in std_logic_vector (31 downto 0);
		alu_control : in std_logic_vector (3 downto 0);
		zero : out std_logic;
		result : out std_logic_vector (31 downto 0)
	);
	end component;
	

	component Memory port (
		CLK: in std_logic;
		MemWrite: in std_logic;
		MemRead: in std_logic;
		address: in std_logic_vector(31 downto 0);
		writeData: in std_logic_vector(31 downto 0);
		readData: out std_logic_vector(31 downto 0)
	);
	end component;
	
	component instructionRegister
		port (
			IRWrite: in  std_logic;
			instrucInput: in  std_logic_vector(31 downto 0);
			opCode: out std_logic_vector(5 downto 0);
			regRs: out std_logic_vector(4 downto 0);
			regRt: out std_logic_vector(4 downto 0);
			regRd: out std_logic_vector(4 downto 0);
			imm: out std_logic_vector(15 downto 0);
			jumpAddr: out std_logic_vector(25 downto 0);
			funcCode: out std_logic_vector(5 downto 0)
      );
	end component;
	
	component mux
		generic (n: natural:= 31);
		port (
			a, b: in std_logic_vector (n downto 0);
			s: in std_logic;
			c: out std_logic_vector(n downto 0)
		);
	end component;
	
	component mux_4_to_1
		port(
			A,B,C,D : in STD_LOGIC;
			S0,S1: in STD_LOGIC;
			Z: out STD_LOGIC
		);
	end component;

	begin

	process(CLK, RESET)
		begin 
			if(RESET = '1') then
				pc_current <= "00000000000000000000000000000000";
			elsif(rising_edge(CLK)) then
				pc_current <= pc_next;
			end if;
	end process;
	
	MUXPC: mux generic map(31) port map(
		a => pc_current,
		b => alu_out,
		c => address,
		s => IorD
	);
	
	RAM:  Memory port map (
		CLK => CLK,
		MemWrite => MemWrite,
		MemRead => MemRead,
		address => address,
		writeData => B,
		readData => data
	);
	
	IR: instructionRegister port map(
		IRWrite <= IRWrite,
		instrucInput => data,
		opCode <= opcode,
		regRs => RS,
		regRt => RT,
		regRd => RD,
		imm => imm
		--jumpAddr <= ,
		--funcCode <= 
	);
	
	Control port map(
		opcode => opcode,
		clk => CLK,
		reset => RESET,
		Branch => Branch,
		PCwrite => PCwrite,
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
	
	MUXREG: mux generic map(15) port map(
		a => RT,
		b => RD,
		s => RegDst, 
		c => writeRegister
	);
	
	MUXREGDATA: mux generic map(31) port map(
		a => alu_out,
		b => data,   -----------cambiar el data que tambien esta definido en port IR
		s => MemToReg,
		c => registerWriteData
	);
	
	Registers: RegisterFile port map(
		registerWrite => , RegWrite,
		registerRead1 => RS,
		registerRead2 => RT,
		writeRegister => writeRegister,
		registerWriteData => registerWriteData,
		registerReadData1 => A,
		registerReadData2 => B
	);

	-- Sign extend
	EXTEND1: sign_extend port map(
		a => imm,
		b => imm_extend
	);
	
	SHIFT1: shift_2 port map(
		a => imm_extend,
		b => imm_extend_left
	);
	
	MUXALUA: mux generic map(15) port map(
		a => pc_current,
		b => A,
		s => ALUSrcA,
		c => A1 -- ALU IN
	);
	
	MUXALUB: mux_4_to_1 port map(
		A => B,
		B => "00000000000000000000000000000100",
		C => imm_extend,
		D => imm_extend_left,
		S0 => ALUSrcB(0),
		S1 => ALUSrcB(1),
		Z => B1 -- ALU IN
	);

	-- ALU
	ALU_INS: alu port map(
		A => A1,
		B => B1,
		-- alu_control => ALU_OPERATION, Unidad de control
		zero => zero,
		result => alu_result
	);

	alu_out <= alu_result;
	
	-- ALU control
	--ALUCONTROL: controlAlu port map(
	--	functions => instruction(5 downto 0),
	--	operationAlu => ALUOp,
	--	alu_control => ALU_OPERATION
	--);

	
	SHIFT_JUMP: shift_jump port map(
		a => imm,
		b => jump_signal
	);

	
	address_jump <= pc_current(31 downto 28) & jump_signal;
	
	pc_next <=  alu_result when (PCsrc = "00") else
					alu_out when (PCsrc = "01") else
					address_jump when (PCsrc = "10");
	
end behavior;