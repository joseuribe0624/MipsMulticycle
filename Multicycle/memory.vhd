library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Memory is
  port(
    MemWrite: in std_logic;
    MemRead: in std_logic;
    address: in std_logic_vector(31 downto 0);
    writeData: in std_logic_vector(31 downto 0);
    readData: out std_logic_vector(31 downto 0)
  );
end Memory;

architecture behavior of Memory is
	type data_ram is array (0 to 31) of std_logic_vector (31 downto 0);
	signal ram : data_ram := (
		16 => std_logic_vector(to_unsigned(13, 32)),
		18 => std_logic_vector(to_unsigned(150, 32)),
		others => (others => '0'));
	begin

		process (address, writeData, MemWrite)
			begin
				if( MemWrite='1') then 
					ram(to_integer(unsigned(address))) <= writeData;
				end if;
		end process; 
		 
		process (address, MemRead)
			begin
				if(MemRead='1') then 
					readData <= ram(to_integer(unsigned(address)));
				end if;
		end process;
 
end behavior;
