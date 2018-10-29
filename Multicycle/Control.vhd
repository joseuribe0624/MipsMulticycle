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
--				(campo function) -- Podriamos cambiarlos para que funcionen con Alucontrol y la Alu
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
	type state_type is (s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11);
	signal state: state_type;
	-- Los estados están numerados con respecto al recorrido por niveles (bfs)
	-- del arbol de estados en la pag 28 del pdf MipsMulticycle.
	begin
		process (clk, reset)
			begin
				if (reset = '1') then
					state <= s1;
				elsif (clk'event and clk='1') then
					case ( state ) is
						when s1 => -- Fetch
								state 		<= s2;
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

						when s2 => -- Decode
								ALUSrcA 	<= '0';
								ALUSrcB 	<= "11";
								ALUOp 		<= "00";
								--
								case ( opcode ) is
									when "0000" => state <= s4; -- tipo R
									when "0001" | "0010" | "0011" => state <= s3; -- addi | lw | sw
									when "0100" => state <= s5; -- beq
									when others => state <= s6; -- jump
								end case;
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

						when s3 => -- MemAddr
								ALUSrcA 	<= '1';
								ALUSrcB 	<= "10";
								ALUOp 		<= "00";
								--
								case ( opcode ) is
									when "0010" => state <= s7; -- lw
									when "0011" => state <= s8; -- sw
									when others => state <= s9; -- addi
								end case;
								--
								PCSrc 		<= "00";
								IRWrite 	<= '0';
								PCWrite 	<= '0';
								MemWrite 	<= '0';
								MemRead 	<= '0';
								RegWrite 	<= '0';
								Branch 		<= '0';
								RegDst 		<= 'X';
								IorD 			<= 'X';
								MemtoReg 	<= 'X';

						when s4 => -- Execute
								state			<= s10;
								--
								ALUSrcA 	<= '1';
								ALUSrcB 	<= "00";
								ALUOp 		<= "10";
								--
								PCSrc 		<= "00";
								IRWrite 	<= '0';
								PCWrite 	<= '0';
								MemWrite 	<= '0';
								MemRead 	<= '0';
								RegWrite 	<= '0';
								Branch 		<= '0';
								RegDst 		<= 'X';
								IorD 			<= 'X';
								MemtoReg 	<= 'X';

						when s5 => -- Branch
								state 		<= s1;
								--
								ALUSrcA 	<= '1';
								ALUSrcB 	<= "00";
								ALUOp 		<= "01";
								PCSrc 		<= "01";
								Branch 		<= '1';
								--
								IRWrite 	<= '0';
								PCWrite		<= '0';
								MemWrite 	<= '0';
								MemRead 	<= '0';
								RegWrite 	<= '0';
								RegDst 		<= 'X';
								IorD 			<= 'X';
								MemtoReg 	<= 'X';

						when s6 => -- Jump
								state 		<= s1;
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

						when s7 => -- MemRead
								state 		<= s11;
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

						when s8 => -- MemWrite
								state 		<= s1;
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

						when s9 => -- ADDI Writeback (nuevo estado)
								state 		<= s1;
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

						when s10 => -- ALU Writeback
								state 		<= s1;
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

						when others => -- Mem Writeback (s11)
								state 		<= s1;
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

					end case;
				end if;
		end process;
end behavior;
