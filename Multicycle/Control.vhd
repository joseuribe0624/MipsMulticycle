library ieee;
use ieee.std_logic_1164.all;

entity Control is
	port(
		opcode: 		in std_logic_vector (3 downto 0);
		clk, reset: in std_logic;

		Branch,
		PCWrite,
		IorD,
		MemRead,
		MemWrite,
		MemtoReg,
		IRWrite,
		ALUSrcA,
		RegWrite,
		RegDst: 	out std_logic;

		PCSrc,
		ALUOp,
		ALUSrcB: 	out std_logic_vector (1 downto 0)
	);
end Control;

-- (OPCODES)
-- TIPO R	: 0000
--				(campo function)
-- 			ADD		: 000
-- 			SUB		: 001 (por si acaso)
-- 			AND		: 010 (por si acaso)
-- 			OR		: 011 (por si acaso)
--
-- ADDI 	: 0001
-- LW 		: 0010
-- SW 		: 0011
--
-- BEQ		: 0100
-- J			: 0101

architecture behavior of Control is
	-- FALTAN POSIBLES NUEVOS ESTADOS PARA LUI & ORI
	--type state_type is (s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11);
	--signal state:      state_type;
	--signal next_state: state_type;
	signal state:      std_logic_vector (3 downto 0);      
	signal next_state: std_logic_vector (3 downto 0);
	-- Los estados est�n numerados con respecto al recorrido por niveles (bfs)
	-- del arbol de estados en la pag 28 del pdf MipsMulticycle.
	begin
		process ( clk, reset )
			begin
				if (reset = '1') then
					--state <= s1;
						state <= "0001";
				elsif (clk'event and clk='1') then
					state <= next_state;
				end if;
		end process;
		
	process ( opcode, state )
		begin
		-- if ( state = s1 ) then -- Fetch
		if ( state = "0001" ) then -- Fetch
				--next_state 	<= s2;
				next_state 	<= "0010";
				--
				IorD 			<= '0';
				MemRead 	<= '1';
				ALUSrcA 	<= '0';
				ALUSrcB 	<= "01";
				ALUOp			<= "00";
				PCSrc 		<= "00";
				IRWrite 	<= '1';
				PCWrite 	<= '1';
				--
				MemWrite 	<= '0';
				MemtoReg 	<= '0';
				Branch 		<= '0';
				RegWrite 	<= '0';
				RegDst 		<= 'X';

		--elsif ( state = s2 ) then -- Decode
		  elsif ( state = "0010" ) then -- Decode
				if ( opcode = "0000" ) then
					--next_state <= s4; -- tipo R
					next_state <= "0100"; -- tipo R
				elsif ( opcode = "0000" or opcode =  "0001" or opcode =  "0010" or opcode = "0011" ) then
					--next_state <= s3; -- addi | lw | sw ) then
					next_state <= "0011"; -- addi | lw | sw ) then
				elsif ( opcode = "0100" ) then
					--next_state <= s5; -- beq
					next_state <= "0101"; -- beq
				elsif ( opcode = "0101" ) then
					--next_state <= s6; -- jump
					next_state <= "0110"; -- jump
				else
					--next_state <= s1; -- Inicio
					next_state <= "0001"; -- Inicio
				end if;
				--
				ALUSrcA 	<= '0';
				ALUSrcB 	<= "11";
				ALUOp 		<= "00";
				--
				PCSrc 		<= "00";
				IRWrite 	<= '0';
				PCWrite 	<= '0';
				MemWrite 	<= '0';
				MemRead 	<= '0';
				RegWrite 	<= '0';
				Branch 		<= '0';
				RegDst	 	<= 'X';
				IorD 			<= 'X';
				MemtoReg 	<= 'X';

		--elsif ( state = s3 ) then -- MemAddr
		elsif ( state = "0011" ) then -- MemAddr
				ALUSrcA 	<= '1';
				ALUSrcB 	<= "10";
				ALUOp    <= "00";
				--
				if ( opcode = "0010" ) then
					--next_state <= s7; -- lw
					next_state <= "0111"; -- lw
				elsif ( opcode = "0011" ) then
					--next_state <= s8; -- sw
					next_state <= "1000"; -- sw
				elsif ( opcode = "0001" ) then
					--next_state <= s9; -- addi
					next_state <= "1001"; -- addi
				else
					--next_state <= s1; -- Inicio
					next_state <= "0001"; -- Inicio
				end if;
				--
				PCSrc 		<= "00";
				IRWrite 	   <= '0';
				PCWrite 	   <= '0';
				MemWrite 	<= '0';
				MemRead 	   <= '0';
				RegWrite 	<= '0';
				Branch 		<= '0';
				RegDst 		<= 'X';
				IorD 			<= 'X';
				MemtoReg 	<= 'X';

		--elsif ( state = s4 ) then -- Execute
		elsif ( state = "0100" ) then -- Execute
				--next_state	<= s10;
				next_state	<= "1010";
				--
				ALUSrcA 	   <= '1';
				ALUSrcB 	   <= "00";
				ALUOp 		<= "10";
				--
				PCSrc 		<= "00";
				IRWrite 	   <= '0';
				PCWrite 	   <= '0';
				MemWrite 	<= '0';
				MemRead 	   <= '0';
				RegWrite 	<= '0';
				Branch 		<= '0';
				RegDst 		<= 'X';
				IorD 			<= 'X';
				MemtoReg 	<= 'X';

		--elsif ( state = s5 ) then -- Branch
		elsif ( state = "0101" ) then -- Branch
				--next_state  <= s1;
				next_state  <= "0001";
				--
				ALUSrcA 	  <= '1';
				ALUSrcB 	  <= "00";
				ALUOp      <= "01";
				PCSrc      <= "01";
				Branch     <= '1';
				--
				IRWrite    <= '0';
				PCWrite    <= '0';
				MemWrite   <= '0';
				MemRead    <= '0';
				RegWrite 	<= '0';
				RegDst 		<= 'X';
				IorD 			<= 'X';
				MemtoReg 	<= 'X';

		--elsif ( state = s6 ) then -- Jump
		elsif ( state = "0110" ) then -- Jump
				--next_state <= s1;
				next_state <= "0001";
				--
				PCSrc 		<= "10";
				ALUOp 		<= "00";
				PCWrite 	<= '1';
				--
				ALUSrcA 	<= '1';
				ALUSrcB 	<= "00";
				IRWrite 	<= '0';
				MemWrite 	<= '0';
				MemRead 	<= '0';
				RegWrite 	<= '0';
				RegDst 		<= 'X';
				IorD 			<= 'X';
				MemtoReg 	<= 'X';
				Branch 		<= 'X';

		--elsif ( state = s7 ) then -- MemRead
		elsif ( state = "0111" ) then -- MemRead
				--next_state 	<= s11;
				next_state 	<= "1011";
				--
				IorD 			<= '1';
				MemRead 	<= '1';
				--
				ALUSrcA 	<= '1';
				ALUSrcB 	<= "00";
				ALUOp 		<= "00";
				IRWrite 	<= '0';
				MemWrite 	<= '0';
				RegWrite 	<= '0';
				PCWrite 	<= '0';
				RegDst 		<= 'X';
				MemtoReg 	<= 'X';
				Branch 		<= 'X';
				PCSrc 		<= "00";

		--elsif ( state = s8 ) then -- MemWrite
		elsif ( state = "1000" ) then -- MemWrite
				--next_state 	<= s1;
				next_state 	<= "0001";
				--
				IorD 			<= '1';
				MemWrite 	<= '1';
				--
				ALUSrcA 	<= '1';
				ALUSrcB 	<= "00";
				ALUOp 		<= "00";
				PCSrc 		<= "00";
				IRWrite 	<= '0';
				MemRead 	<= '0';
				RegWrite 	<= '0';
				PCWrite 	<= '0';
				RegDst 		<= 'X';
				MemtoReg 	<= 'X';
				Branch 		<= 'X';

		--elsif ( state = s9 ) then -- ADDI Writeback (nuevo estado)
		elsif ( state = "1001" ) then -- ADDI Writeback (nuevo estado)
				--next_state 	<= s1;
				next_state 	<= "0001";
				--
				RegDst 		<= '0';
				MemtoReg 	<= '0';
				RegWrite 	<= '1';
				--
				ALUSrcA 	<= '1';
				ALUSrcB 	<= "00";
				ALUOp 		<= "00";
				PCSrc 		<= "00";
				IRWrite 	<= '0';
				MemRead 	<= '0';
				PCWrite 	<= '0';
				IorD 			<= '0';
				MemWrite 	<= '0';
				Branch 		<= 'X';

		--elsif ( state = s10 ) then -- ALU Writeback
		elsif ( state = "1010" ) then -- ALU Writeback
				--next_state 	<= s1;
				next_state 	<= "0001";
				--
				RegDst 		<= '1';
				MemtoReg 	<= '0';
				RegWrite 	<= '1';
				--
				ALUSrcA 	<= '1';
				ALUSrcB 	<= "00";
				ALUOp 		<= "00";
				PCSrc 		<= "00";
				IRWrite 	<= '0';
				MemRead 	<= '0';
				PCWrite 	<= '0';
				IorD 			<= '0';
				MemWrite 	<= '0';
				Branch 		<= 'X';

		--elsif ( state = s11 ) then -- Mem Writeback (s11)
		else -- elseif ( state = "1011" ) then -- Mem Writeback (s11)
				--next_state 	<= s1;
				next_state 	<= "0001";
				--
				RegDst 		<= '0';
				MemtoReg 	<= '1';
				RegWrite 	<= '1';
				--
				ALUSrcA 	<= '1';
				ALUSrcB 	<= "00";
				ALUOp 		<= "00";
				PCSrc 		<= "00";
				IRWrite 	<= '0';
				MemRead 	<= '0';
				PCWrite 	<= '0';
				IorD 			<= '0';
				MemWrite 	<= '0';
				Branch 		<= 'X';
	end if;
	end process;
end behavior;
