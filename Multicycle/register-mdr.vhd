-- MDR Register VHDL Code


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity MDR is  -- Memory Data Register
    Port ( din : inout  STD_LOGIC_VECTOR (7 downto 0) :="ZZZZZZZZ";
           dout : inout  STD_LOGIC_VECTOR (7 downto 0):="ZZZZZZZZ";
           lein : in  STD_LOGIC;
           leout : in  STD_LOGIC;
           ocin : in  STD_LOGIC;
           ocout : in  STD_LOGIC);
end MDR;

architecture Behavioral of MDR is
	signal inn : STD_LOGIC_VECTOR (7 downto 0) :="ZZZZZZZZ";
	signal outt : STD_LOGIC_VECTOR (7 downto 0) :="ZZZZZZZZ";
begin
process(OCIN,OCOUT,LEIN,LEOUT,DIN,DOUT)
begin
	if(lein='1') then
	inn <= din;
	end if;
	if(leout='1') then
	outt <= dout;
	end if;
	if(ocin='1') then
	din <= outt;
	else
	din<= "ZZZZZZZZ";
	end if;
	if(ocout='1') then
	dout <= inn;
	else
	dout<= "ZZZZZZZZ";
	end if;
	end process;
end Behavioral;

