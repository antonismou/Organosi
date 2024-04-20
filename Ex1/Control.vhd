----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:16:36 04/17/2024 
-- Design Name: 
-- Module Name:    Control - Behavioral 
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

entity Control is
    Port ( instr : in  STD_LOGIC_VECTOR (31 downto 0);
           pcSel : out  STD_LOGIC;
           pcLdEn : out  STD_LOGIC;
           rfWe : out  STD_LOGIC;
           rfBSel : out  STD_LOGIC;
           rfWrDataSel : out  STD_LOGIC;
           memWe : out  STD_LOGIC;
           rstOut : out  STD_LOGIC;
           rst : in  STD_LOGIC;
			  clk: in STD_LOGIC);
end Control;

architecture Behavioral of Control is
type fsmStates is (insFe,opFe,ex,wb);
signal state : fsmStates;

begin
	 process
	 begin
		wait until clk'event and clk = '1';
		if rst = '1' or instr = "00000000000000000000000000000000" then
			state <= insFe;
		else 
			state <= insFe; --prepei na to ftiaksoume ebala kati ka8ara gia to error
		end if;
	end process;
	
	process(state)
	begin
	case state is
		when insFe =>
			if instr(31) = '0' and instr(30) = '1' then		--branch
				pcSel <= '1';
			else
				pcSel <= '0';
			end if;
			pcLdEn <= '1';
			rfWe <= '0'; rfBSel <= '0'; rfWrDataSel <= '0'; memWe <= '0'; rstOut <= '0';		
		when opFe =>
			pcLdEn <= '0'; rfWe <= '0';
			if instr(30) = '1' then 	--immed
				rfBSel <= '1';
			else
				rfBSel <= '0';
			end if;
         rfWrDataSel <= '0'; memWe <= '0'; rstOut <= '0';	
		when ex =>
			pcLdEn <= '0';
			rfWe <= '0';
			if instr(31) = '1' and instr(28) = '0' then 	--alu wb to rf
				rfWrDataSel <= '0';
				
			else
				rfWrDataSel <= '1';
			end if;
         memWe <= '0';
         rstOut <= '0';	
		when wb =>
			pcLdEn <= '0';
			if instr(31 downto 26) = "011111" or instr(31 downto 26) = "000111" then 	--wrte to mem
				memWe<='1';
			else
				rfWe <= '1';
			end if;	
			
		end case;
	end process;

end Behavioral;

