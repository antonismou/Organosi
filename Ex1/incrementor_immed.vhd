----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:03:00 04/14/2024 
-- Design Name: 
-- Module Name:    incrementor_immed - Behavioral 
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

entity incrementor_immed is
	Port ( input_incr_4 : in  STD_LOGIC_VECTOR (31 downto 0);
           immed : in  STD_LOGIC_VECTOR (31 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end incrementor_immed;

architecture Behavioral of incrementor_immed is
--	component incrementor_4 is
--		Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
--				 output : out  STD_LOGIC_VECTOR (31 downto 0));	
--	end component;
begin
--	incrementor_4: incrementor_4 port map (
--		input=>in
	output<= input_incr_4 + immed;

end Behavioral;

