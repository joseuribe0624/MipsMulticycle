library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift is
	port (
		a: in std_logic_vector(15 downto 0);
		b: out std_logic_vector(15 downto 0)
	);
end entity;

architecture beh of shift is
	signal temp: std_logic_vector(15 downto 0);

	begin
	temp <= std_logic_vector(resize(unsigned(a), 16));
	b <= std_logic_vector(shift_left(signed(temp), 2));
end beh;
