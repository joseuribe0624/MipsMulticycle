library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bcd_state_decoder is
  port (
    bcd_num : in std_logic_vector(2 downto 0);  -- Numero en bcd
    state   : out std_logic_vector(27 downto 0) -- Caracteres del estado en orden (4 x 7 señales)
  );
end entity;

architecture arch of bcd_state_decoder is
  signal output_0 : std_logic_vector (6 downto 0);
begin
  state <= output_0;
  process ( bcd_num ) begin
    case bcd_num is
      when "000"  => output_0 <= not ("0000001" & "0000001" & "0000001" & "0000001"); -- (Cuatro '-' (dashlines))
      when "001"  => output_0 <= not ("0110111" & "0011101" & "0110000" & "1110111"); -- HOLA
      when "010"  => output_0 <= not ("1011011" & "1001111" & "0110000" & "1001110"); -- SELC
      when "011"  => output_0 <= not ("0011101" & "1100111" & "1001111" & "0000101"); -- OPER
      when "011"  => output_0 <= not ("1110110" & "1001111" & "0110111" & "0001111"); -- NEXT
      when "011"  => output_0 <= not ("1011011" & "1001111" & "0001111" & "1111110"); -- SET0
      when "011"  => output_0 <= not ("1011011" & "1001111" & "0001111" & "0000110"); -- SET1
      when others => output_0 <= not ("1011110" & "1011110" & "1011110" & "1011110"); -- GGGG
    end case;
  end process;
end architecture;
