library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity RegisterFile is
port (
	registerWrite: in std_logic;
	registerRead1: in std_logic_vector(4 downto 0);
	registerRead2: in std_logic_vector(4 downto 0);
	writeRegister: in std_logic_vector(4 downto 0);
	registerWriteData: in std_logic_vector(31 downto 0);
	registerReadData1: out std_logic_vector(31 downto 0);
	registerReadData2: out std_logic_vector(31 downto 0)
);
end RegisterFile;

architecture behavior of RegisterFile is  
	type reg_type is array (0 to 31) of std_logic_vector (31 downto 0);
		--- llena la matriz de 0
	signal reg_mem: reg_type:=((others => (others => '0')));
	signal data_out1: std_logic_vector(31 downto 0);
   signal data_out2: std_logic_vector(31 downto 0);
	
	begin
	
	registerReadData1 <= data_out1;
	registerReadData2 <= data_out2;
	
	process (registerRead1, registerRead2)
		begin
			data_out1 <= reg_mem(to_integer(unsigned(registerRead1)));
			data_out2 <= reg_mem(to_integer(unsigned(registerRead2)));
	end process;
	
	process (registerWriteData, writeRegister)
		begin
			if registerWrite = '1' then
          reg_mem(to_integer(unsigned(writeRegister))) <= registerWriteData;
        end if;
	end process;

end behavior;

