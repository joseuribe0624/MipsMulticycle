library ieee;
use ieee.std_logic_1164.all;

entity TB_Control is
end TB_Control;

architecture arch of TB_Control is
  component Control port (
   OPCODE: in std_logic_vector (5 downto 0);
   clk, reset: in std_logic;
	Branch, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst: out std_logic;
	PCSrc, ALUOp, ALUSrcB: out std_logic_vector (1 downto 0)
  );
  end component;
  
-- LW: 100011
-- SW: 101011
-- R: 000000
-- BEQ: 000100
-- J: 000010
  
  signal OP: std_logic_vector (5 downto 0);
  signal clk, reset: std_logic;
  signal Branch, PCWrite, IorD, MemRead, MemWrite, MemtoReg, IRWrite, ALUSrcA, RegWrite, RegDst: std_logic;
  signal PCSrc, ALUOp, ALUSrcB: std_logic_vector (1 downto 0);
  
  begin
    test_control: Control port map(
		 clk => clk,
		 reset => reset,
		 OPCODE => OP,
		 Branch => Branch, 
		 PCWrite => PCWrite, 
		 IorD => IorD, 
		 MemRead => MemRead, 
		 MemWrite => MemWrite, 
		 MemtoReg => MemtoReg, 
		 IRWrite => IRWrite, 
		 ALUSrcA => ALUSrcA, 
		 RegWrite => RegWrite, 
		 RegDst => RegDst,
		 PCSrc => PCSrc, 
		 ALUOp => ALUOp, 
		 ALUSrcB => ALUSrcB
    );


end arch;
