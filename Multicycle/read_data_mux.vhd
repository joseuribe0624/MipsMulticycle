library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Enrealidad podriamos usar la plantilla que Carlos ya hizo llamada mux,
-- es exactamente lo mismo solo es cambiarle los nombres.

entity read_data_mux is -- Selecciona datos a leer entre la memoria y el teclado (I/O)
  port (
    mem,
    -- Los registros de los disp I/0 son de 32 bits.
    -- Para los leds solo nos importan los bits [15-0] y el registro del keyboard
    -- si lo leemos por completo, los full 32 bits.

    -- Por otra parte, los valores que retornaría el teclado serían
    -- 0 (no está presionado nada), 1, 2, 4, 8 cuando se presionen algunas de las teclas
    -- (es como un shift register)
    -- de esa forma, al cargar el dato no tenemos que pasarlo por un sign_extend
    kb: in std_logic_vector (32 downto 0);
    s:  in std_logic;
    c:  out std_logic_vector (32 downto 0)
  );
end entity;

architecture arch of read_data_mux is
begin
  c <= mem when (s = '0') else kb;
end architecture;
