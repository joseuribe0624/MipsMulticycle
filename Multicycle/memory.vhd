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
   --signal ram: data_ram(0 to 1023); -- 2^10 posiciones de memoria. Podriamos necesitar más después.
	signal ram : MEM(0 to 13) := (
		0 => std_logic_vector(to_signed(-1, 32)),
		1 => std_logic_vector(to_signed(5, 32)),
		2 => std_logic_vector(to_signed(42, 32)),
		3 => "00000100000000010000000000000101", -- addi r0 r1 5  (r1 <= r0 + 5)
		4 => "00000100001000100000000000010100", -- addi r1 r2 20 (r2 <= r1 + 20)
		5 => "00000000001000100001100000000000", -- add r1 r2 r3  (r3 <= r1 + r2)
		6 => "00001000100001010000000000000000", -- lw r4 r5 0    (r5 <= mem[r4 + 0])
		7 => "00001100110001010000000000000001", -- sw r6 r5 1    (mem[r6 + 1] <= r5)
		--7 => "000100 " -- beq 
		--8 => "000101 " -- jump 3 (pc <= 3)
		--9
		others => (others => '0')
	);
		   
	signal data_out1: std_logic_vector (31 downto 0);

	begin
		readData <= data_out1;

		process ( address, writeData, MemWrite )
			begin
				if( MemWrite='1') then
					ram(to_integer(unsigned(address))) <= writeData;
				end if;
		end process;

		process ( address, MemRead )
			begin
				if(MemRead='1') then
					data_out1 <= ram(to_integer(unsigned(address)));
				end if;
		end process;
end behavior;
