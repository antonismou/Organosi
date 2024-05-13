----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:34:01 04/26/2024 
-- Design Name: 
-- Module Name:    compare_module - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity compare_module is
	Port ( 
		inp : in STD_LOGIC_VECTOR (4 downto 0);
		inp2 : in  STD_LOGIC_VECTOR (4 downto 0);
		we : in std_logic;
		outp: out std_logic
		 );
end compare_module;


architecture Behavioral of compare_module is

	signal temp: std_logic; 

begin
	process(inp,inp2,we)	
	begin
		if(we='1') then	
			if (inp = inp2) then
				if(inp = "00000") then
					temp <='0';
				else
					temp<= '1';
				end if;
			else
				temp<= '0';
			end if;
		else
			temp <= '0';
		end if;	
		
	end process;
		 
		outp <= temp;

end Behavioral;

