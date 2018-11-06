library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Determina que dispositivo se comunica con el procesador (Memory or I/O)
entity address_decoder is
  port (
  -- Dirección de memoria
    address:        in std_logic_vector (15 downto 0);
    -- Señal de la unidad de control.
    mem_write:      in std_logic;

    -- Solo vamos a escribir en los 7 segmentos, puede que necesitemos varias señales de enable
    w_enable_7_seg: out std_logic_vector (15 downto 0);

    -- Al parecer hay que cambiar el cableado en el main para reemplazar este cable en la memoria
    w_enable_mem,

    -- Señal para leer entre kb (keyboard) y mem en el read_data_mux.
    reg_dst:      out std_logic

    -- No nos interesa leer lo que esté en los 7 segmentos
  );
end entity;

architecture arch of address_decoder is
  -- La idea basica de esto es: si los bits [14-13] del address son 11,
  -- entonces es una dirección de un dispositivo I/O. 2^14 nos cabe perfectamente
  -- en un valor inmediato de 16 bits.

  -- Si entre un write memory, entonces se activa el enable del registro
  -- que diga el address.

  -- Si no se está escribiendo, entonces se está leyendo. Dependiendo
  -- de la condicion mencionada arriba, seleccionar 0, 1, 2, ... no se cuantos
  -- diferentes números, para mandarselos al mux read_data_mux

  -- Eso es todo, creo.
  signal
begin
end architecture;
