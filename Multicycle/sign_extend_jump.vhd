library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend_jump is
	port(
		a : in std_logic_vector( 11 downto 0 );
		b: out std_logic_vector ( 15  downto 0 )
	);
end sign_extend_jump;

architecture beh of sign_extend_jump is
	begin
	b <= std_logic_vector(resize(unsigned(a), b'length));
end beh;
