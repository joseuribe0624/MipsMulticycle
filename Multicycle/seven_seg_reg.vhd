library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity seven_seg_reg is
	generic (n: natural := 31; t: natural := 5);
	port (
		data:			in std_logic_vector (n downto 0);
		w_en:			in std_logic;
		data_out: 	out std_logic_vector (t downto 0)
	);
end entity;

architecture behavior of seven_seg_reg is
begin
	process ( w_en, data ) begin
		if (w_en = '1') then
			data_out <= data(t downto 0);
		end if;
	end process;
end architecture;
