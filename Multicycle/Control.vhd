	library ieee;
use ieee.std_logic_1164.all;

entity Control is
	port(
		opcode: in std_logic_vector (3 downto 0);
		clk, reset: in std_logic;
		Branch, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst: out std_logic;
		PCSrc, ALUOp, ALUSrcB: out std_logic_vector (1 downto 0)
	);
end Control;

-- LW: 1010
-- SW: 1011
-- R: 0000
-- BEQ: 0100
-- J: 0010

architecture behavior of Control is
	signal state: std_logic_vector (5 downto 0);
	signal next_state: std_logic_vector (5 downto 0);
	begin
		process (clk, reset)
			begin
				if (reset = '1') then
					state <= "000000";
				elsif (clk'event and clk='1') then
					state <= next_state;
				end if;
		end process;

		process (opcode, state)
			begin
				if (state = "0000") then
					IorD <= '0';
					MemRead <= '1';
					ALUSrcA <= '0';
					ALUSrcB <= "01";
					ALUOp <= "00";
					PCSrc <= "00";
					IRWrite <= '1';
					PCWrite <= '1';
					next_state <= "000001";
					--
					MemWrite <= '0';
					MemtoReg <= '0';
					Branch <= '0';
					RegWrite <= '0';
					RegDst <= 'X';
				elsif (state = "000001") then
					ALUSrcA <= '0';
					ALUSrcB <= "11";
					ALUOp <= "00";
					case opcode is 
						when "1010"|"1011" => next_state <= "000010";
						when "0000" => next_state <= "000110";
						when "0100" => next_state <= "000100";
						when others => next_state <= "001001";
					end case;
					IRWrite <= '0';
					PCWrite <= '0';
					MemWrite <= '0';
					MemRead <= '0';
					RegWrite <= '0';
					Branch <= '0';
					RegDst <= 'X';
					IorD <= 'X';
					PCSrc <= "00";
					MemtoReg <= 'X';
				elsif (state = "0010") then
					ALUSrcA <= '1';
					ALUSrcB <= "10";
					ALUOp <= "00";
					case opcode is
						when "1010"  => next_state <= "000011";
						when others => next_state <= "000101";
					end case;
					--
					IRWrite <= '0';
					PCWrite <= '0';
					MemWrite <= '0';
					MemRead <= '0';
					RegWrite <= '0';
					Branch <= '0';
					RegDst <= 'X';
					IorD <= 'X';
					PCSrc <= "00";
					MemtoReg <= 'X';
				elsif (state = "000110") then
					ALUSrcA <= '1';
					ALUSrcB <= "00";
					ALUOp <= "10"; 
					next_state <= "000111";
					--
					IRWrite <= '0';
					PCWrite <= '0';
					MemWrite <= '0';
					MemRead <= '0';
					RegWrite <= '0';
					Branch <= '0';
					RegDst <= 'X';
					IorD <= 'X';
					PCSrc <= "00";
					MemtoReg <= 'X';
				elsif (state = "001000") then
					ALUSrcA <= '1';
					ALUSrcB <= "00";
					ALUOp <= "01";
					PCSrc <= "01";
					Branch <= '1';
					next_state <= "000000";
					--
					IRWrite <= '0';
					PCWrite <= '0';
					MemWrite <= '0';
					MemRead <= '0';
					RegWrite <= '0';
					RegDst <= 'X';
					IorD <= 'X';
					MemtoReg <= 'X';
				elsif (state = "001001") then
					PCSrc <= "10";
					PCWrite <= '1';
					next_state <= "000000";
					--
					ALUSrcA <= '1';
					ALUSrcB <= "00";
					ALUOp <= "00";
					IRWrite <= '0';
					MemWrite <= '0';
					MemRead <= '0';
					RegWrite <= '0';
					RegDst <= 'X';
					IorD <= 'X';
					MemtoReg <= 'X';
					Branch <= 'X';
				elsif (state = "000011") then
					IorD <= '1';
					MemRead <= '1';
					next_state <= "000100";
					--
					ALUSrcA <= '1';
					ALUSrcB <= "00";
					ALUOp <= "00";
					IRWrite <= '0';
					MemWrite <= '0';
					RegWrite <= '0';
					PCWrite <= '0';
					RegDst <= 'X';
					MemtoReg <= 'X';
					Branch <= 'X';
					PCSrc <= "00";
				elsif (state = "000101") then
					IorD <= '1';
					MemWrite <= '1';
					next_state <= "000000";
					--
					ALUSrcA <= '1';
					ALUSrcB <= "00";
					ALUOp <= "00";
					IRWrite <= '0';
					MemRead <= '0';
					RegWrite <= '0';
					PCWrite <= '0';
					RegDst <= 'X';
					MemtoReg <= 'X';
					Branch <= 'X';
					PCSrc <= "00";
				else
					RegDst <= '0';
					MemtoReg <= '1';
					RegWrite <= '1';
					next_state <= "000000";
					--
					ALUSrcA <= '1';
					ALUSrcB <= "00";
					ALUOp <= "00";
					IRWrite <= '0';
					MemRead <= '0';
					PCWrite <= '0';
					IorD <= '0';
					MemWrite <= '0';
					Branch <= 'X';
					PCSrc <= "00";
				end if;
		end process;
end behavior;
