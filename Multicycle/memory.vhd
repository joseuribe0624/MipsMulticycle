library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Memory is
  port(
    MemWrite:   in std_logic;
    MemRead:    in std_logic;
    address:    in std_logic_vector(31 downto 0);
    writeData:  in std_logic_vector(31 downto 0);
    readData:   out std_logic_vector(31 downto 0)
  );
end Memory;

architecture behavior of Memory is
	type MEM is array (integer range<>) of std_logic_vector (31 downto 0);
	-- Todos los registros tienen 0 de init value.
	signal ram : MEM(0 to 12);-- := (
	--);
	
	signal data_out1: std_logic_vector (31 downto 0);

	begin
		readData <= data_out1;
		process ( address, writeData, MemWrite, ram )
			begin
				if( MemWrite='1') then
					ram(to_integer(unsigned(address))) <= writeData;
				end if;
		end process;

		process ( address, MemRead, ram, data_out1 )
			begin
				if(MemRead='1') then
					data_out1 <= ram(to_integer(unsigned(address)));
				end if;
		end process;
end behavior;
