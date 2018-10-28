library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Instruction_Register is 
    port(
			 IRWrite     : in  std_logic;
          instrucInput : in  std_logic_vector(15 downto 0);
	     	 
			 opCode      : out std_logic_vector(3 downto 0);
          regRs	    : out std_logic_vector(2 downto 0);
		    regRt   	: out std_logic_vector(2 downto 0);
		    regRd   	: out std_logic_vector(2 downto 0); 
			 imm         : out std_logic_vector(5 downto 0);
		    jumpAddr    : out std_logic_vector(11 downto 0);
		    funcCode    : out std_logic_vector(2 downto 0)
	 );
end entity;

architecture behavior of Instruction_Register is
	signal addr_Output1 : std_logic_vector(3 downto 0);
	signal addr_Output2 : std_logic_vector(2 downto 0);
	signal addr_Output3 : std_logic_vector(2 downto 0);
	signal addr_Output4 : std_logic_vector(2 downto 0); 
	signal addr_Output5 : std_logic_vector(5 downto 0);
	signal addr_Output6 : std_logic_vector(11 downto 0);
	signal addr_Output7 : std_logic_vector(2 downto 0);
begin
    
	opCode   <= addr_Output1;
	regRs    <= addr_Output2;
	regRt    <= addr_Output3;
	regRd    <= addr_Output4;
	imm      <= addr_Output5;
	jumpAddr <= addr_Output6;
	funcCode <= addr_Output7;
	
    process (IRWrite , instrucInput) begin
        if( IRWrite  = '1' ) then 
            addr_Output1 <= instrucInput(15 downto 12);
				addr_Output2 <= instrucInput(11 downto 9);
				addr_Output3 <= instrucInput(8 downto 6);
				addr_Output4 <= instrucInput(5 downto 3);
				addr_Output5 <= instrucInput(5 downto 0);
				addr_Output6 <= instrucInput(11 downto 0);
				addr_Output7 <= instrucInput(2 downto 0);
        end if;
	end process;
	
end architecture;
	
