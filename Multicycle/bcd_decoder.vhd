-- TODO:
-- Ahora que lo pienso, es mejor hacer un decoder especial para lo de las letras.

-- Así, puedo mapear los numeros del 1 al ... la cantidad de letras que estemos usando para los estados del sistema
-- y podemos devolver la letra esperada para los 7 segmentos. Me parece perfecta idea.
-- Entonces, para todos los leds menos los de los estados, se usa el
-- bcd_decoder, pero para los estados se usaría el char_decoder o algo así.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bcd_decoder is
  port (
  -- En el main le conectamos a este decoder los bits (15 downto 0) de la salida de un registro
    -- Numero en bcd
	 bcd_num       : in std_logic_vector(5 downto 0); 
	 -- Numero de dos dígitos, 14 bits porque no contamos el punto en el display
    seven_seg_num : out std_logic_vector(13 downto 0) 
  );
end entity;

architecture arch of bcd_decoder is
  -- La idea basica es hacer puros if statements o cases
  -- de tal forma que por cada numero de 16 bits dado en bcd,
  -- saquemos dos digitos codificados en 7 segmentos (los full 16 bits).
begin
  process ( bcd_num ) begin
	case bcd_num is
    when "000000" => seven_seg_num <= not "11111101111110"; -- 00
    when "000001" => seven_seg_num <= not "11111100000110"; -- 01
	 when "000010" => seven_seg_num <= not "11111101101101"; -- 02
	 when "000011" => seven_seg_num <= not "11111101111001"; -- 03
	 when "000100" => seven_seg_num <= not "11111100110011"; -- 04
	 when "000101" => seven_seg_num <= not "11111101011011"; -- 05
	 when "000110" => seven_seg_num <= not "11111101011111"; -- 06
	 when "000111" => seven_seg_num <= not "11111101110000"; -- 07
	 -- Añadir hasta el digito "59"
    when others   => seven_seg_num <= not "10111101011110"; -- Sino pasa nada de lo de arriba, que muestre "GG"
   end case;
  end process;
end architecture;
