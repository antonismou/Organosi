----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:37:58 04/12/2024 
-- Design Name: 
-- Module Name:    extendMSB - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cloud is
    Port ( din : in  STD_LOGIC_VECTOR (15 downto 0);
			ImmedControl: in STD_LOGIC_VECTOR(1 downto 0);
           immed : out  STD_LOGIC_VECTOR (31 downto 0));
end cloud;

architecture Behavioral of cloud is

begin

process(din,ImmedControl)
begin
case ImmedControl is 
	-- Zero fill
	when "00" =>
		immed <= (31 downto 16 => '0') & din; 
	-- Sign Extend
	when "01" =>
		immed <= (31 downto 16 => din(15)) & din; 
	-- Zero Fill & Shift
	when "10" =>
		immed <= din & (31 downto 16 => '0'); 
	-- Sign Extend and shift
	when others =>
		immed <= std_logic_vector(shift_left(unsigned(resize(signed(din), 32)), 2));
end case;
end process;

end Behavioral;

