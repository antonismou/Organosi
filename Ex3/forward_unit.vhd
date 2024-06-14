----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:27:51 06/13/2024 
-- Design Name: 
-- Module Name:    forward_unit - Behavioral 
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

entity forward_unit is
Port( EX_MEM_reg_Rd: in STD_LOGIC_VECTOR (4 downto 0);
		ID_EX_reg_Rs: in STD_LOGIC_VECTOR (4 downto 0); 
		ID_EX_reg_Rt: in STD_LOGIC_VECTOR (4 downto 0);
		MEM_WB_reg_Rd: in STD_LOGIC_VECTOR (4 downto 0);
		EX_MEM_reg_WB: in  STD_LOGIC;
		MEM_WB_reg_WB: in  STD_LOGIC;
		ForwardA: out STD_LOGIC_VECTOR (1 downto 0);
		ForwardB: out STD_LOGIC_VECTOR (1 downto 0)
);
end forward_unit;

architecture Behavioral of forward_unit is

begin

	process
	begin
	--For Rs
	--Execute danger
		if ((EX_MEM_reg_WB='1') and (EX_MEM_reg_Rd=ID_EX_reg_Rs)) then
			ForwardA <= "10";-- RF_A is the forwarding of the last alu result
		--Memory danger
		elsif(MEM_WB_reg_WB='1'  and not(EX_MEM_reg_WB='1' and (EX_MEM_reg_Rd/=ID_EX_reg_Rs) and(MEM_WB_reg_Rd =ID_EX_reg_Rs))) then
			ForwardA<="01";-- RF_A is the forwarding of the memory output or the last alu result
		else 
			ForwardA<="00"; --RF_A is from registerFile
		end if;
		
	--For Rt
	--Execute danger
		if(EX_MEM_reg_WB='1' and  EX_MEM_reg_Rd=ID_EX_reg_Rt) then
			ForwardB <= "10";-- RF_B is the forwarding of the last alu result
		end if;
		--Memory danger
		if(MEM_WB_reg_WB='1' and not(EX_MEM_reg_WB='1' and (EX_MEM_reg_Rd/=ID_EX_reg_Rt) and(MEM_WB_reg_Rd =ID_EX_reg_Rt))) then
			ForwardB<="01";-- RF_B is the forwarding of the memory output or the last alu result
		else
				ForwardB<="00"; --RF_B is from registerFile
		end if;

	end process;
	end Behavioral;

