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

entity extendMSB is
    Port ( din : in  STD_LOGIC_VECTOR (15 downto 0);
           immed : out  STD_LOGIC_VECTOR (31 downto 0));
end extendMSB;

architecture Behavioral of extendMSB is

begin
immed <= std_logic_vector(resize(signed(din),32)); 

end Behavioral;

