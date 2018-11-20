library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu is
	Port(
		A, B        : in STD_LOGIC_VECTOR (31 downto 0);
		alu_control : in STD_LOGIC_VECTOR (2 downto 0);
		zero        : out STD_LOGIC;
		result      : out STD_LOGIC_VECTOR (31 downto 0)
	);
end alu;

architecture behavioral of alu is
	begin
		-- add    : 010
		-- sub    : 011
		-- and    : 110
		-- or     : 111
		-- branch : 110
		-- slt    : 101 => slt rs rt rd => if (rs < rt) rd = 1 else rd = 0
		process ( A, B, alu_control ) begin
		  result <= "00000000000000000000000000000000";
		  zero   <= '0';
		  
		  if    (alu_control	= "010") then
		    result <= A + B;
			 
		  elsif (alu_control	= "110" or alu_control = "011") then
		    result <= A - B;
			 
		  elsif (alu_control	= "110") then
		    result <= A and B;
			 
		  elsif (alu_control	= "111") then
		    result <= A or B;
			 
		  elsif (alu_control	= "101") then
		    if (A < B) then
			   result <= "00000000000000000000000000000001";
			 else
			   result <= "00000000000000000000000000000000";
			 end if;
		  end if;
		  
		  if   ((alu_control="011" or alu_control= "110") and A = B) then
		    zero <= '1';
		  else
          zero <= '0';
		  end if;

		end process;
end behavioral;
