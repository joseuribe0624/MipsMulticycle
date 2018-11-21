library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Memory is
  port(
    clk:			 in std_logic;
    MemWrite:   in std_logic;
    MemRead:    in std_logic;
    address:    in std_logic_vector(31 downto 0);
    writeData:  in std_logic_vector(31 downto 0);
    readData:   out std_logic_vector(31 downto 0)
  );
end Memory;

architecture behavior of Memory is
	type MEM is array (integer range<>) of std_logic_vector (31 downto 0);
	signal ram : MEM(0 to 31) := (
		0 => "00000101010000000000000000000111", -- addi r10 r0 7 (r0 <= r10 + 7)
		1 => "00000101010000010000000000010011", -- addi r10 r1 19 (r1 <= r10 + 19)
		2 => "00001100110000000110000000000000", -- sw r6 r0 1    (mem[r6 + s_seg_reg_0] <= r0)
		3 => "00001100110000010110000000000001", -- sw r6 r1 1    (mem[r6 + s_seg_reg_1] <= r1)
     others => (others => '0')
	);

	signal data_out1: std_logic_vector (31 downto 0);

	begin
		readData <= data_out1;
		
		process ( clk, address, writeData, MemWrite, ram )
			begin
				if(rising_edge(clk) and MemWrite='1') then
					ram(to_integer(unsigned(address))) <= writeData;
				end if;
		end process;

		process ( clk, address, MemRead, ram, data_out1 )
			begin
				if(rising_edge(clk) and MemRead='1') then
					data_out1 <= ram(to_integer(unsigned(address)));
				end if;
		end process;
end behavior;
