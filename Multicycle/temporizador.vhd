library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity temporizador is
	port(
		Clk,
    Reset:   in std_logic;
    Seconds,
    Minutes: inout integer range -32767 to 32767
    -- Enrealidad solo necesitamos -59 to 59, pero en ese caso las entradas serían
    -- de 6 bits. -32767 to 32767 nos debería garantizar (en teoría) 16 bits para cada entrada.
    -- Así cuando le vayamos a pasar datos a este módulo desde procesador,
    -- Cargarmos 16 bits en Seconds y Minutes. (cada dato está en una posición diferente)
	);
end temporizador;

architecture arch of temporizador is
  -- 50 Hz (Lo que nos da la FPGA)
  constant ClockFrequencyHz : integer := 50e6;
  -- Para general clock desde Quartus. Solo sirve en simulaciones
  constant ClockPeriod      : time    := 1000 ms / ClockFrequencyHz;
  -- Para contar cada periodo del clock
  signal Ticks : integer;
  begin
      process(Clk) is
      begin
          if rising_edge(Clk) then

              -- If the negative reset signal is active
              if Reset = '1' then
                  Ticks   <= 0;
                  Seconds <= 0;
                  Minutes <= 0;
              else

                  -- True once every second
                  if Ticks = ClockFrequencyHz - 1 then
                      Ticks <= 0;

                      -- True once every minute
                      if Seconds = 59 then
                          Seconds <= 0;

                          -- True once every hour
                          if Minutes = 59 then
                              Minutes <= 0;
                          else
                              Minutes <= Minutes + 1;
                          end if;

                      else
                          Seconds <= Seconds + 1;
                      end if;

                  else
                      Ticks <= Ticks + 1;
                  end if;

              end if;
          end if;
      end process;
end architecture;
