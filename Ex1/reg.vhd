----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:17:23 04/08/2024 
-- Design Name: 
-- Module Name:    reg - Behavioral 
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

entity reg is
    Port ( clk : in  STD_LOGIC;
			  rst : STD_LOGIC;
           we : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (31 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
end reg;

architecture Behavioral of reg is

begin
	process
	begin
		WAIT UNTIL clk'EVENT AND clk = '1';
		if rst = '1' then
			dout <= x"00000000";
		else
			if we = '1' then
				dout <= data;
			end if;
		end if;
	end process;
		

end Behavioral;

