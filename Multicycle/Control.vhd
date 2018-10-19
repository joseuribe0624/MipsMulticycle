	library ieee;
use ieee.std_logic_1164.all;

entity Control is
	port(
		opcode: in std_logic_vector (5 downto 0);
		clk, reset: in std_logic;
		Branch, PCwrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst: out std_logic;
		PCSrc, ALUOp, ALUSrcB: out std_logic_vector (1 downto 0);
	);
end Control;

-- LW: 100011
-- SW: 101011
-- R: 000000
-- BEQ: 000100
-- J: 000010

architecture behavior of Control is
	signal state: std_logic_vector (3 downto 0);
	signal next_state: std_logic_vector (3 downto 0);
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
				if (state = "000000") then
					IorD <= '0';
					MemRead <= '1';
					ALUSrcA <= '0';
					ALUSrcB <= "01";
					ALUOp <= "00";
					PCSrc <= "00";
					IRWrite <= '1';
					PCWrite <= '1';
					next_state <= "0001";
					--
				elsif (state = "000001") then
					ALUSrcA <= '0';
					ALuSrcB <= "11";
					ALUOp <= "00";
					--
					case opcode is 
						when "100011"|"101011" => next_state <= "000010";
						when "000000" => next_state <= "000110";
						when "000100" => next_state <= "000100";
						when others => next_state <= "001001";
					end case;
				
				elsif (state = "000010") then
					ALUSrcA <= '1';
					ALUSrcB <= "10";
					ALUOp <= "00";
					--
					case opcode is
						when "100011"  => next_state <= "000011";
						when others => next_state <= "000101";
					end case;
				elsif (state = "000110") then
					ALUSrcA <= '1';
					ALUSrcB <= "00";
					ALuOp <= "10";
					-- 
					next_state <= "000111";
				elsif (state = "001000") then
					ALUSrcA <= '1';
					ALUSrcB <= "00";
					ALUOp <= "01";
					PCSrc <= "01";
					Branch <= '1';
					---
					next_state <= "000000";
				elsif (state = "001001") then
					PCSrc <= "10";
					PCWrite <= '1';
					--
					next_state <= "000000";
				elsif (state = "000011") then
					IorD <= '1';
					MemRead <= '1';
					--
					next_state <= "000100";
				elsif (state = "000101") then
					IorD <= '1';
					MemWrite <= '1';
					next_state <= "000000";
				else
					RegDst <= '0';
					MemtoReg <= '1';
					RegWrite <= '1';
				end if;
		end process;
end behavior;
