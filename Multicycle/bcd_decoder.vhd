library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bcd_decoder is
  port (
  -- En el main le conectamos a este decoder los bits (15 downto 0) de la salida de un registro
    bcd_num       : in std_logic_vector(15 downto 0);
    two_digit_num : out std_logic_vector(15 downto 0)
  );
end entity;

architecture arch of bcd_decoder is
  -- La idea basica es hacer puros if statements o cases
  -- de tal forma que por cada numero de 16 bits dado en bcd,
  -- saquemos dos digitos codificados en 7 segmentos (los full 16 bits).
  -- obvio tengo que probar ésto bien, pero es fácil. Aunque un poquito machetero.
  signal
begin
end architecture;
