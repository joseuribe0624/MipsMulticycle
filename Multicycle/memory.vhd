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
	signal ram : MEM(0 to 31) := (
		0 => "00000000001000100001100000000001", -- sub r1 r2 r3 (r3 <= r1 - r2)
		1 => "00010001010010110000000000000100", -- beq r10 r11 4 (if r10 == r11 then pc <= 4)
		2 => "00010100000000000000000000001000", -- jump 6 (pc <= 6)
		3 => "00000100000000010000000000000101", -- addi r0 r1 5  (r1 <= r0 + 5)
		4 => "00000100001000100000000000010100", -- addi r1 r2 20 (r2 <= r1 + 20)
		5 => "00001000100001010000000000000000", -- lw r4 r5 0    (r5 <= mem[r4 + 0])
		6 => "00001100110001010000000000000001", -- sw r6 r5 1    (mem[r6 + 1] <= r5)
		7 => "00000100000010100000000000001010", -- addi r0 r10 10 (r10 <= r0 + 10)
		8 => "00000100000010110000000000001001", -- addi r0 r11 9  (r11 <= r0 + 9)
		9 => "00000000001000100001100000000000", -- add r1 r2 r3  (r3 <= r1 (5) + r2 (17))
	  10 => "00010000000000010000000000000011", -- beq r0 r1 3   (if r0 == r1 then pc <= 3)
	  11 => "00000001010010110110000000000000", -- add r10 r11 r12 (r12 <= r10 (10) + r11 (9))
	  12 => "00010100000000000000000000000000", -- jump 0 (pc <= 0)
		others => (others => '0')
	);

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
