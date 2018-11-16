-- CAMBIO DE PLANES: Ahora los estados son un solo caracter
-- HOLA ahora es H (de hi)
-- SELC ahora es C (de choose)
-- OPER ahora es o (de operating)
-- NEXT ahora es n
-- SET0 ahora es 0
-- SET1 ahora es 1
-- 'G' se mantiene como el de prueba

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bcd_state_decoder is
  port (
    bcd_num : in std_logic_vector(2 downto 0);  -- Numero en bcd
    state   : out std_logic_vector(6 downto 0) -- Caracter del estado (7 señales, un solo 7-seg)
  );
end entity;

architecture arch of bcd_state_decoder is
  signal output_0 : std_logic_vector (6 downto 0);
begin
  state <= output_0;
  process ( bcd_num ) begin
    case bcd_num is
      when "000"  => output_0 <= not ("0000001"); -- dashline ('-')
      when "001"  => output_0 <= not ("0110111"); -- H
      when "010"  => output_0 <= not ("1001110"); -- C
      when "011"  => output_0 <= not ("0011101"); -- o
      when "100"  => output_0 <= not ("0010101"); -- n
      when "101"  => output_0 <= not ("1111110"); -- 0
      when "110"  => output_0 <= not ("0000110"); -- 1
      when others => output_0 <= not ("1011110"); -- G
    end case;
  end process;
end architecture;


-- when "000"  => output_0 <= not ("0000001" & "0000001" & "0000001" & "0000001"); -- (Cuatro '-' (dashlines))
-- when "001"  => output_0 <= not ("0110111" & "0011101" & "0110000" & "1110111"); -- HOLA
-- when "010"  => output_0 <= not ("1011011" & "1001111" & "0110000" & "1001110"); -- SELC
-- when "011"  => output_0 <= not ("0011101" & "1100111" & "1001111" & "0000101"); -- OPER
-- when "011"  => output_0 <= not ("1110110" & "1001111" & "0110111" & "0001111"); -- NEXT
-- when "011"  => output_0 <= not ("1011011" & "1001111" & "0001111" & "1111110"); -- SET0
-- when "011"  => output_0 <= not ("1011011" & "1001111" & "0001111" & "0000110"); -- SET1
-- when others => output_0 <= not ("1011110" & "1011110" & "1011110" & "1011110"); -- GGGG
