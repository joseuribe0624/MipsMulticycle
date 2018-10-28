library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Memory is
  port(
    MemWrite: in std_logic;
    MemRead: in std_logic;
    address: in std_logic_vector(15 downto 0);
    writeData: in std_logic_vector(15 downto 0);
    readData: out std_logic_vector(15 downto 0)
  );
end Memory;

architecture behavior of Memory is
	type data_ram is array (integer range<>) of std_logic_vector (15 downto 0);
	signal ram : data_ram(0 to 15);
	signal data_out1: std_logic_vector (15 downto 0);
	begin
		readData <= data_out1;
		process (address, writeData, MemWrite)
			begin
				if( MemWrite='1') then 
					ram(to_integer(unsigned(address))) <= writeData;
				end if;
		end process; 
		
		process (address, MemRead)
			begin
				if(MemRead='1') then 
					data_out1 <= ram(to_integer(unsigned(address)));
				end if;
		end process;
 
end behavior;
