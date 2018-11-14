library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity kb_register is
  port(
    kb_read   : in  std_logic;
    kb_input  : in  std_logic_vector(3 downto 0);
    kb_output : out std_logic_vector(31 downto 0)
  );
end kb_register;

architecture arch of kb_register is
  signal kb_out_0 : std_logic_vector(31 downto 0)
begin
  kb_output <= kb_out_0;
  process ( kb_input, kb_read ) begin
    if (kb_read = '1') then
      kb_out_0 <= std_logic_vector(resize(unsigned(kb_input), kb_output'length));
    end if;
  end process;
end architecture;
