library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity controlAlu is
port (
	functions: 			in std_logic_vector(2 downto 0);
	ALUOp: 					in std_logic_vector(1 downto 0);
	alu_operation: 	out std_logic_vector(2 downto 0)
);
end controlAlu;

architecture behavioral of controlAlu is
	begin
		-- Hay que revisar esto y todo el componente de la ALU también.
		-- Solo tenemos 4 operaciones tipo R (add, sub, etc)
		-- pero no estoy seguro si esto sigue sirviendo.
	 alu_operation(2) <= ( ALUOp(0) or (ALUOp(1) and functions(1)) );
   alu_operation(1) <= ( not(ALUOp(1)) or not(functions(2)) );
   alu_operation(0) <= ( ALUOp(1) and functions(0));
end behavioral;
