	library ieee;
use ieee.std_logic_1164.all;

entity Control is
	port(
		opcode: in std_logic_vector (5 downto 0);
		state: in std_logic_vector (3 downto 0);
		Branch, PCwrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst: out std_logic;
		PCSrc, ALUOp, ALUSrcB: out std_logic_vector (1 downto 0);
		next_state: out std_logic_vector (3 downto 0);
	);
end Control;

-- LW: 100011
-- SW: 101011
-- R: 000000
-- BEQ: 000100
-- J: 000010

architecture behavior of Control is
	begin
		process (opcode, state)
			begin
				if (state = "0000" or reset = '1') then
					IorD <= '0';
					MemRead <= '1';
					ALUSrcA <= '0';
					ALUSrcB <= "01";
					ALUOp <= "00";
					PCSrc <= "00";
					IRWrite <= '1';
					PCWrite <= '1';
					next_state <= "0001"
					--
				elsif (state = "0001") then
					ALUSrc <= '0';
					ALuSrcB <= "11";
					ALUOp <= "00"
					--
					case next_state is 
						when (opcode = "100011" or opcode = "101011") => "0010";
						when (opcode = "000000") => "0110";
						when (opcode = "000100") => "0100";
						when others => "0101";
					end case;
				elsif (state = "0010") then
					ALUSrcA <= '1';
					ALUSrcB <= "10";
					ALUOp <= "00";
					--
					case next_state is
						when (opcode = "100011")  => "000011";
						when others => "000101";
				-- Hasta estado 6
				elsif (state = "0110") is
					ALUSrcA <= '1';
					ALUSrcB <= "00";
					ALuOp <= "10";
					-- 
					next_state <= "000111";
				end if;
		end process;
		
		aluOp <= "10" when (opcode = "000000") else
					"01" when (opcode = "000100") else
					"00";
		RegDst <= '1' when (opcode = "000000") else
					 '0' when (opcode = "100011") else
					 'X';
		ALUSrc <= '0' when (opcode = "000000" or opcode = "000100") else
					 '1' when (opcode = "100011" or opcode = "101011");
		MemtoReg <= '0' when (opcode = "000000") else
						'1' when (opcode = "100011") else
						'X';
		RegWrite <= '1' when (opcode = "000000" or opcode = "100011") else
		            '0';
		MemRead <= '0' when (opcode = "000000" or opcode = "101011" or opcode = "000100" or opcode = "000010") else
					  '1' when (opcode = "100011") else
					  'X';
		MemWrite <= '0' when (opcode = "000000" or opcode = "100011" or opcode = "000100" or opcode = "000010") else
						'1' when (opcode = "101011") else
						'X';
		Branch <= '0' when (opcode = "000000" or opcode = "100011" or opcode = "101011") else
					 '1';
		jump <= '1' when (opcode = "000010") else '0';
end behavior;
