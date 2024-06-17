----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:55:54 06/14/2024 
-- Design Name: 
-- Module Name:    Big_fu - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Big_fu is
Port( EX_MEM_reg_Rd: in STD_LOGIC_VECTOR (4 downto 0);
		ID_EX_reg_Rs: in STD_LOGIC_VECTOR (4 downto 0); 
		ID_EX_reg_Rt: in STD_LOGIC_VECTOR (4 downto 0);
		MEM_WB_reg_Rd: in STD_LOGIC_VECTOR (4 downto 0);
		EX_MEM_reg_WB: in  STD_LOGIC;
		MEM_WB_reg_WB: in  STD_LOGIC;
		ForwardA: out STD_LOGIC_VECTOR (1 downto 0);
		ForwardB: out STD_LOGIC_VECTOR (1 downto 0)
);
end Big_fu;

architecture Behavioral of Big_fu is
component forward_unit is
Port( EX_MEM_reg_Rd: in STD_LOGIC_VECTOR (4 downto 0);
		ID_EX_reg_R: in STD_LOGIC_VECTOR (4 downto 0); 
		MEM_WB_reg_Rd: in STD_LOGIC_VECTOR (4 downto 0);
		EX_MEM_reg_WB: in  STD_LOGIC;
		MEM_WB_reg_WB: in  STD_LOGIC;
		Forward: out STD_LOGIC_VECTOR (1 downto 0)
);
end component;
begin

fu_Rs: forward_unit port map(
	EX_MEM_reg_Rd => EX_MEM_reg_Rd,
	ID_EX_reg_R	=> ID_EX_reg_Rs,
	MEM_WB_reg_Rd => MEM_WB_reg_Rd,
	EX_MEM_reg_WB => EX_MEM_reg_WB,
	MEM_WB_reg_WB => MEM_WB_reg_WB,
	Forward => ForwardA
);

fu_Rt: forward_unit port map(
	EX_MEM_reg_Rd => EX_MEM_reg_Rd,
	ID_EX_reg_R	=> ID_EX_reg_Rt,
	MEM_WB_reg_Rd => MEM_WB_reg_Rd,
	EX_MEM_reg_WB => EX_MEM_reg_WB,
	MEM_WB_reg_WB => MEM_WB_reg_WB,
	Forward => ForwardB
);
end Behavioral;

