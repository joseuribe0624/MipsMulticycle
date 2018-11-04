library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity address_decoder is -- Determina que dispositivo se comunica con el procesador (Memory or I/O)
  port (
    address:        in std_logic_vector (15 downto 0); -- Dirección de memoria
    mem_write:      in std_logic; -- Señal de la unidad de control.
    -- Solo vamos a escribir en los 7 segmentos, puede que necesitemos varias señales de enable
    w_enable_7_seg: out std_logic_vector (15 downto 0);

    -- Al parecer hay que cambiar el cableado en el main para reemplazar este cable en la memoria
    w_enable_mem,
    reg_dst:      out std_logic -- Señal para leer entre kb (keyboard) y mem en el read_data_mux.
    -- No nos interesa leer lo que esté en los 7 segmentos
  );
end entity;

architecture arch of address_decoder is
  signal
begin
end architecture;
