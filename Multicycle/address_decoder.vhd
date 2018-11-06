library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Nota: "w_en" significa write enable

-- Determina que dispositivo se comunica con el procesador (Memory or I/O)
-- para lectura o escritura
entity address_decoder is
  port (
  -- clk : in std_logic; AL ADDRESS DECODER LE TIENE QUE ENTRAR UN CLOCK?? ASK

  -- Dirección de memoria
    address     : in std_logic_vector (31 downto 0);
    -- Señal de la unidad de control.
    mem_write   : in std_logic;

    -- Señales de escritura para cada registro de cada 7 segmentos
    w_en_reg_0, -- Reg numero de sesión
    w_en_reg_1_0, -- Reg duración de sesión 0
    w_en_reg_1_1, -- Reg duración de sesión 0
    w_en_reg_2, -- Reg numero de circuitos
    w_en_reg_3, -- Reg numero de descansos

    w_en_reg_4, -- Numero de circuito o descanso
    w_en_reg_5_0, -- Duración de circuito o descanso 0
    w_en_reg_5_1, -- Duración de circuito o descanso 1
    w_en_reg_6, -- 7 Seg_3 FPGA (estado del sistema)
    w_en_reg_7, -- 7 Seg_2 FPGA (estado del sistema)
    w_en_reg_8, -- 7 Seg_1 FPGA (estado del sistema)
    w_en_reg_9, --7 Seg_0 FPGA (estado del sistema)

    -- Al parecer hay que cambiar el cableado en el main para reemplazar este cable en la memoria
    w_en_mem,

    -- Señal para leer entre kb (keyboard) y mem en el read_data_mux.
    rdsel : out std_logic

    -- No nos interesa leer lo que esté en los 7 segmentos
  );
end entity;

architecture arch of address_decoder is
  -- La idea basica de esto es: si los bits [14-13] del address son 1 ambos,
  -- entonces es una dirección de un dispositivo I/O. 2^14 nos cabe perfectamente
  -- en un valor inmediato de 16 bits.

  -- Si entra un write memory, entonces se activa el enable del registro
  -- que diga el address.

  -- Si no se está escribiendo, entonces se está leyendo. Dependiendo
  -- de la condicion mencionada arriba, seleccionar 0, 1, 2, ... no se cuantos
  -- diferentes números, para mandarselos al mux read_data_mux

  -- Eso es todo, creo.

  signal ad_output_0   : std_logic;
  signal ad_output_1_0 : std_logic;
  signal ad_output_1_1 : std_logic;
  signal ad_output_2   : std_logic;
  signal ad_output_3   : std_logic;
  signal ad_output_4   : std_logic;
  signal ad_output_5_0 : std_logic;
  signal ad_output_5_1 : std_logic;
  signal ad_output_6   : std_logic;
  signal ad_output_7   : std_logic;
  signal ad_output_8   : std_logic;
  signal ad_output_9   : std_logic;
  signal ad_output_10  : std_logic;
  signal ad_output_11  : std_logic;

begin
  w_en_reg_0     <= ad_output_0;
  w_en_reg_1_0   <= ad_output_1_0;
  w_en_reg_1_1   <= ad_output_1_1;
  w_en_reg_2     <= ad_output_2;
  w_en_reg_3     <= ad_output_3;
  w_en_reg_4     <= ad_output_4;
  w_en_reg_5_0   <= ad_output_5_0;
  w_en_reg_5_1   <= ad_output_5_1;
  w_en_reg_6     <= ad_output_6;
  w_en_reg_7     <= ad_output_7;
  w_en_reg_8     <= ad_output_8;
  w_en_reg_9     <= ad_output_9;
  w_en_mem       <= ad_output_10;
  rdsel          <= ad_output_11;

  process ( address, mem_write ) begin
    -- Queremos escribir o leer de un dispositivo I/O
    if ( address(14) = '1' and address(13) = '1' ) then
      if ( mem_write = '1' ) then
        -- Miramos en cual dispositivo se quiere escribir especificamente
        if address    = "00000000000000000110000000000000" then
          ad_output_0   <= '1';
        elsif address = "00000000000000000110000000000001" then
          ad_output_1_0 <= '1';
        elsif address = "00000000000000000110000000000010" then
          ad_output_1_1 <= '1';
        elsif address = "00000000000000000110000000000011" then
          ad_output_2   <= '1';
        elsif address = "00000000000000000110000000000100" then
          ad_output_3   <= '1';
        elsif address = "00000000000000000110000000000101" then
          ad_output_4   <= '1';
        elsif address = "00000000000000000110000000000110" then
          ad_output_5_0 <= '1';
        elsif address = "00000000000000000110000000000111" then
          ad_output_5_1 <= '1';
        elsif address = "00000000000000000110000000001000" then
          ad_output_6   <= '1';
        elsif address = "00000000000000000110000000001001" then
          ad_output_7   <= '1';
        elsif address = "00000000000000000110000000001010" then
          ad_output_8   <= '1';
        elsif address = "00000000000000000110000000001011" then
          ad_output_9   <= '1';
        end if;
      else -- mem_write = '0'. Se escoge para que se lea desde el teclado
        ad_output_11    <= '1'
      end if;

    -- Queremos escribir o leer en la memoria
    else
      if ( mem_write = '1') then
        ad_output_10 <= '1'; -- Activamos el enable para la memoria
      else
        ad_output_11 <= '0'; -- Escogemos a la memoria en el multiplexor
      end if;
    end if;

end architecture;
