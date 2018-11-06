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
    bcd_num       : in std_logic_vector(15 downto 0); -- Numero en bcd
    seven_seg_num : out std_logic_vector(15 downto 0) -- Numero de dos dígitos
  );
end entity;

architecture arch of bcd_decoder is
  -- La idea basica es hacer puros if statements o cases
  -- de tal forma que por cada numero de 16 bits dado en bcd,
  -- saquemos dos digitos codificados en 7 segmentos (los full 16 bits).
  -- obvio tengo que probar ésto bien, pero es fácil. Aunque un poquito machetero.
  signal bcd_output_0 : std_logic_vector (15 downto 0);
begin
  seven_seg_num <= bcd_output_0;

  process ( bcd_num ) begin
    if ( bcd_num = "000000000000000" ) then
      bcd_output_0 <= "1111110011111100"; -- El digito '0' copiado dos veces para que lo muestre el led
      -- Lo mismo de arriba pero al revés, por si acaso.
      -- bcd_output_0 <= "01111110111111";
    elsif ( bcd_num = "000000000000001" ) then
      bcd_output_0 <= "0000110011111100"; -- Muestre '1' y '0' en los leds.
      -- Lo mismo de arriba pero con los numeros cambiados de orden, por si acaso.
      -- bcd_output_0 <= "1111110000001100";
    else
      bcd_output_0 <= "1011110010111100"; -- Sino pasa nada de lo de arriba, que muestre "GG"
    end if;

    -- Recuerda que al final de cada byte, es siempre un 0,
    -- porque esa señal corresponde a la del punto en
    -- el display de 7 segmentos. Solo para tenerlo en cuenta.

end architecture;
