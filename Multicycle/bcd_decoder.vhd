library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bcd_decoder is
  port (
	 bcd_num       : in  std_logic_vector(5  downto 0);
   seven_seg_num : out std_logic_vector(13 downto 0)
  );
end entity;

architecture arch of bcd_decoder is
begin
  process ( bcd_num ) begin
	case bcd_num is
   when "000000" => seven_seg_num <= not ("1111110" & "1111110"); -- 00
   when "000001" => seven_seg_num <= not ("1111110" & "0000110"); -- 01
   when "000010" => seven_seg_num <= not ("1111110" & "1101101"); -- 02
   when "000011" => seven_seg_num <= not ("1111110" & "1111001"); -- 03
   when "000100" => seven_seg_num <= not ("1111110" & "0110011"); -- 04
   when "000101" => seven_seg_num <= not ("1111110" & "1011011"); -- 05
   when "000110" => seven_seg_num <= not ("1111110" & "1011111"); -- 06
   when "000111" => seven_seg_num <= not ("1111110" & "1110000"); -- 07
   when "001000" => seven_seg_num <= not ("1111110" & "1111111"); -- 08
   when "001001" => seven_seg_num <= not ("1111110" & "1111011"); -- 09

   when "001010" => seven_seg_num <= not ("0000110" & "1111110"); -- 10
   when "001011" => seven_seg_num <= not ("0000110" & "0000110"); -- 11
   when "001100" => seven_seg_num <= not ("0000110" & "1101101"); -- 12
   when "001101" => seven_seg_num <= not ("0000110" & "1111001"); -- 13
   when "001110" => seven_seg_num <= not ("0000110" & "0110011"); -- 14
   when "001111" => seven_seg_num <= not ("0000110" & "1011011"); -- 15
   when "010000" => seven_seg_num <= not ("0000110" & "1011111"); -- 16
   when "010001" => seven_seg_num <= not ("0000110" & "1110000"); -- 17
   when "010010" => seven_seg_num <= not ("0000110" & "1111111"); -- 18
   when "010011" => seven_seg_num <= not ("0000110" & "1111011"); -- 19

   when "010100" => seven_seg_num <= not ("1101101" & "1111110"); -- 20
   when "010101" => seven_seg_num <= not ("1101101" & "0000110"); -- 21
   when "010110" => seven_seg_num <= not ("1101101" & "1101101"); -- 22
   when "010111" => seven_seg_num <= not ("1101101" & "1111001"); -- 23
   when "011000" => seven_seg_num <= not ("1101101" & "0110011"); -- 24
   when "011001" => seven_seg_num <= not ("1101101" & "1011011"); -- 25
   when "011010" => seven_seg_num <= not ("1101101" & "1011111"); -- 26
   when "011011" => seven_seg_num <= not ("1101101" & "1110000"); -- 27
   when "011100" => seven_seg_num <= not ("1101101" & "1111111"); -- 28
   when "011101" => seven_seg_num <= not ("1101101" & "1111011"); -- 29

   when "011110" => seven_seg_num <= not ("1111001" & "1111110"); -- 30
   when "011111" => seven_seg_num <= not ("1111001" & "0000110"); -- 31
   when "100000" => seven_seg_num <= not ("1111001" & "1101101"); -- 32
   when "100001" => seven_seg_num <= not ("1111001" & "1111001"); -- 33
   when "100010" => seven_seg_num <= not ("1111001" & "0110011"); -- 34
   when "100011" => seven_seg_num <= not ("1111001" & "1011011"); -- 35
   when "100100" => seven_seg_num <= not ("1111001" & "1011111"); -- 36
   when "100101" => seven_seg_num <= not ("1111001" & "1110000"); -- 37
   when "100110" => seven_seg_num <= not ("1111001" & "1111111"); -- 38
   when "100111" => seven_seg_num <= not ("1111001" & "1111011"); -- 39

   when "101000" => seven_seg_num <= not ("0110011" & "1111110"); -- 40
   when "101001" => seven_seg_num <= not ("0110011" & "0000110"); -- 41
   when "101010" => seven_seg_num <= not ("0110011" & "1101101"); -- 42
   when "101011" => seven_seg_num <= not ("0110011" & "1111001"); -- 43
   when "101100" => seven_seg_num <= not ("0110011" & "0110011"); -- 44
   when "101101" => seven_seg_num <= not ("0110011" & "1011011"); -- 45
   when "101110" => seven_seg_num <= not ("0110011" & "1011111"); -- 46
   when "101111" => seven_seg_num <= not ("0110011" & "1110000"); -- 47
   when "110000" => seven_seg_num <= not ("0110011" & "1111111"); -- 48
   when "110001" => seven_seg_num <= not ("0110011" & "1111011"); -- 49

   when "110010" => seven_seg_num <= not ("1011011" & "1111110"); -- 50
   when "110011" => seven_seg_num <= not ("1011011" & "0000110"); -- 51
   when "110100" => seven_seg_num <= not ("1011011" & "1101101"); -- 52
   when "110101" => seven_seg_num <= not ("1011011" & "1111001"); -- 53
   when "110110" => seven_seg_num <= not ("1011011" & "0110011"); -- 54
   when "110111" => seven_seg_num <= not ("1011011" & "1011011"); -- 55
   when "111000" => seven_seg_num <= not ("1011011" & "1011111"); -- 56
   when "111001" => seven_seg_num <= not ("1011011" & "1110000"); -- 57
   when "111010" => seven_seg_num <= not ("1011011" & "1111111"); -- 58
   when "111011" => seven_seg_num <= not ("1011011" & "1111011"); -- 59
   when others   => seven_seg_num <= not ("1011110" & "1011110"); --  Else muestre "GG"
  end case;
  end process;
end architecture;
