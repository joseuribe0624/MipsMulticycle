-- TODO: Creo que si ponemos todas las signals en 0 antes de entrar a los if's
-- podriamos ahorrarnos tener que poner los 0's de cada una. Pero tengo que probarlo.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity address_decoder is
  port (
    address   : in std_logic_vector (31 downto 0);
    mem_write,
    mem_read  : in std_logic;

    -- Write enables para cada registro de cada 7 segmentos + direcciones de memoria
    w_en_reg_0,   -- Reg numero de sesión,                  DIR: (00000000000000000110000000000000)
    w_en_reg_1_0, -- Reg duración de sesión 0,              DIR: (00000000000000000110000000000001)
    w_en_reg_1_1, -- Reg duración de sesión 1,              DIR: (00000000000000000110000000000010)
    w_en_reg_2,   -- Reg numero de circuitos,               DIR: (00000000000000000110000000000011)
    w_en_reg_3,   -- Reg numero de descansos,               DIR: (00000000000000000110000000000100)

    w_en_reg_4,   -- Reg numero de circuito o descanso,     DIR: (00000000000000000110000000000101)
    w_en_reg_5_0, -- Reg duración de circuito o descanso 0, DIR: (00000000000000000110000000000110)
    w_en_reg_5_1, -- Reg duración de circuito o descanso 1, DIR: (00000000000000000110000000000111)
    w_en_reg_6,   -- 4 x 7 seg FPGA (estado del sistema),   DIR: (00000000000000000110000000001000)

    r_en_mem, -- Read enable memoria
    r_en_kb,  -- Read enable keyboard, DIR: (00000000000000000110000000001001)
    w_en_mem, -- Write enable de la memoria

    -- Señal para leer entre kb (keyboard) y mem en el read_data_mux.
    rdsel : out std_logic

    -- No nos interesa leer lo que esté en los 7 segmentos, solo escribir.
  );
end entity;

architecture arch of address_decoder is
  -- La idea basica de esto es: si los bits [14-13] del address son 1 ambos,
  -- entonces es una dirección de un dispositivo I/O. 2^14 nos cabe perfectamente
  -- en un valor inmediato de 16 bits.

  -- Si entra un write memory, entonces se activa el enable del registro
  -- que diga el address.

  -- Si entra un read memory, se activa el read enable o del kb o de la memoria,
  -- y se escoje de donde proviene el dato por medio del read_data_mux

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
  -- Sí, no hay output_9. Luego de modificar algo no es necesario.
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
  r_en_mem       <= ad_output_7;
  r_en_kb        <= ad_output_8;
  w_en_mem       <= ad_output_10;
  rdsel          <= ad_output_11;

  process ( address, mem_write, mem_read ) begin
    if    (mem_write = '1') then
      -- Se quiere escribir en un registro para un 7 segmentos
      if ( address(14) = '1' and address(13) = '1' ) then
        -- Miramos en cual dispositivo se quiere escribir especificamente
        if address    = "00000000000000000110000000000000" then
          ad_output_0   <= '1';
          --
          ad_output_1_0 <= '0';
          ad_output_1_1 <= '0';
          ad_output_2   <= '0';
          ad_output_3   <= '0';
          ad_output_4   <= '0';
          ad_output_5_0 <= '0';
          ad_output_5_1 <= '0';
          ad_output_6   <= '0';
          ad_output_7   <= '0';
          ad_output_8   <= '0';
          ad_output_10  <= '0';
          ad_output_11  <= '0';

        elsif address = "00000000000000000110000000000001" then
          ad_output_1_0 <= '1';
          --
          ad_output_0   <= '0';
          ad_output_1_1 <= '0';
          ad_output_2   <= '0';
          ad_output_3   <= '0';
          ad_output_4   <= '0';
          ad_output_5_0 <= '0';
          ad_output_5_1 <= '0';
          ad_output_6   <= '0';
          ad_output_7   <= '0';
          ad_output_8   <= '0';
          ad_output_10  <= '0';
          ad_output_11  <= '0';

        elsif address = "00000000000000000110000000000010" then
          ad_output_1_1 <= '1';
          --
          ad_output_0   <= '0';
          ad_output_1_0 <= '0';
          ad_output_2   <= '0';
          ad_output_3   <= '0';
          ad_output_4   <= '0';
          ad_output_5_0 <= '0';
          ad_output_5_1 <= '0';
          ad_output_6   <= '0';
          ad_output_7   <= '0';
          ad_output_8   <= '0';
          ad_output_10  <= '0';
          ad_output_11  <= '0';

        elsif address = "00000000000000000110000000000011" then
          ad_output_2   <= '1';
          --
          ad_output_0   <= '0';
          ad_output_1_0 <= '0';
          ad_output_1_1 <= '0';
          ad_output_3   <= '0';
          ad_output_4   <= '0';
          ad_output_5_0 <= '0';
          ad_output_5_1 <= '0';
          ad_output_6   <= '0';
          ad_output_7   <= '0';
          ad_output_8   <= '0';
          ad_output_10  <= '0';
          ad_output_11  <= '0';

        elsif address = "00000000000000000110000000000100" then
          ad_output_3   <= '1';
          --
          ad_output_0   <= '0';
          ad_output_1_0 <= '0';
          ad_output_1_1 <= '0';
          ad_output_2   <= '0';
          ad_output_4   <= '0';
          ad_output_5_0 <= '0';
          ad_output_5_1 <= '0';
          ad_output_6   <= '0';
          ad_output_7   <= '0';
          ad_output_8   <= '0';
          ad_output_10  <= '0';
          ad_output_11  <= '0';

        elsif address = "00000000000000000110000000000101" then
          ad_output_4   <= '1';
          --
          ad_output_0   <= '0';
          ad_output_1_0 <= '0';
          ad_output_1_1 <= '0';
          ad_output_2   <= '0';
          ad_output_3   <= '0';
          ad_output_5_0 <= '0';
          ad_output_5_1 <= '0';
          ad_output_6   <= '0';
          ad_output_7   <= '0';
          ad_output_8   <= '0';
          ad_output_10  <= '0';
          ad_output_11  <= '0';

        elsif address = "00000000000000000110000000000110" then
          ad_output_5_0 <= '1';
          --
          ad_output_0   <= '0';
          ad_output_1_0 <= '0';
          ad_output_1_1 <= '0';
          ad_output_2   <= '0';
          ad_output_3   <= '0';
          ad_output_4   <= '0';
          ad_output_5_1 <= '0';
          ad_output_6   <= '0';
          ad_output_7   <= '0';
          ad_output_8   <= '0';
          ad_output_10  <= '0';
          ad_output_11  <= '0';

        elsif address = "00000000000000000110000000000111" then
          ad_output_5_1 <= '1';
          --
          ad_output_0   <= '0';
          ad_output_1_0 <= '0';
          ad_output_1_1 <= '0';
          ad_output_2   <= '0';
          ad_output_3   <= '0';
          ad_output_4   <= '0';
          ad_output_5_0 <= '0';
          ad_output_6   <= '0';
          ad_output_7   <= '0';
          ad_output_8   <= '0';
          ad_output_10  <= '0';
          ad_output_11  <= '0';

        elsif address = "00000000000000000110000000001000" then
          ad_output_6   <= '1';
          --
          ad_output_0   <= '0';
          ad_output_1_0 <= '0';
          ad_output_1_1 <= '0';
          ad_output_2   <= '0';
          ad_output_3   <= '0';
          ad_output_4   <= '0';
          ad_output_5_0 <= '0';
          ad_output_5_1 <= '0';
          ad_output_7   <= '0';
          ad_output_8   <= '0';
          ad_output_10  <= '0';
          ad_output_11  <= '0';
        end if;
      -- Se quiere escribir en la memoria
      else
        ad_output_10  <= '1';
        --
        ad_output_0   <= '0';
        ad_output_1_0 <= '0';
        ad_output_1_1 <= '0';
        ad_output_2   <= '0';
        ad_output_3   <= '0';
        ad_output_4   <= '0';
        ad_output_5_0 <= '0';
        ad_output_5_1 <= '0';
        ad_output_6   <= '0';
        ad_output_7   <= '0';
        ad_output_8   <= '0';
        ad_output_11  <= '0';
      end if;
    elsif (mem_read  = '1') then
      -- Se quiere leer del teclado
      if ( address(14) = '1' and address(13) = '1' ) then
        -- En caso de lectura, esta será siempre la del kb (... 11 ... 1001)
        ad_output_8   <= '1';
        ad_output_11  <= '1'; -- Escogemos el kb en el read_data_mux
        --
        ad_output_0   <= '0';
        ad_output_1_0 <= '0';
        ad_output_1_1 <= '0';
        ad_output_2   <= '0';
        ad_output_3   <= '0';
        ad_output_4   <= '0';
        ad_output_5_0 <= '0';
        ad_output_5_1 <= '0';
        ad_output_6   <= '0';
        ad_output_7   <= '0';
        ad_output_10  <= '0';
      -- Se quiere leer de la memoria
      else
        ad_output_7   <= '1';
        ad_output_11  <= '0'; -- Escogemos la memoria en el read_data_mux
        --
        ad_output_0   <= '0';
        ad_output_1_0 <= '0';
        ad_output_1_1 <= '0';
        ad_output_2   <= '0';
        ad_output_3   <= '0';
        ad_output_4   <= '0';
        ad_output_5_0 <= '0';
        ad_output_5_1 <= '0';
        ad_output_6   <= '0';
        ad_output_8   <= '0';
        ad_output_10  <= '0';
      end if;
    else
      ad_output_0   <= '0';
      ad_output_1_0 <= '0';
      ad_output_1_1 <= '0';
      ad_output_2   <= '0';
      ad_output_3   <= '0';
      ad_output_4   <= '0';
      ad_output_5_0 <= '0';
      ad_output_5_1 <= '0';
      ad_output_6   <= '0';
      ad_output_7   <= '0';
      ad_output_8   <= '0';
      ad_output_10  <= '0';
      ad_output_11  <= '0';
    end if;
  end process;
end architecture;
