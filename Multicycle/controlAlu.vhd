library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity controlAlu is
port (
	functions: in std_logic_vector(5 downto 0);
	ALUOp: in std_logic_vector(1 downto 0);
	alu_operation: out std_logic_vector(3 downto 0)
);
end controlAlu;

architecture behavioral of controlAlu is  
	begin
	 alu_operation(2) <= ( ALUOp(0) or ( ALUOp(1)and functions(1)));
    alu_operation(1) <= ( not(ALUOp(1)) or not(functions(2)));
    alu_operation(0) <= (( ALUOp(1) )and( functions(3) or functions(0)));
end behavioral;

