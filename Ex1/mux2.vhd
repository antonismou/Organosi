----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:41:43 04/08/2024 
-- Design Name: 
-- Module Name:    mux2 - Behavioral 
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

entity mux2 is
port(
	a1  : in std_logic_vector(31 downto 0);
	a2  : in std_logic_vector(31 downto 0);
	sel : in  std_logic;
	b   : out std_logic_vector(31 downto 0)
);
end mux2;

architecture Behavioral of mux2 is
	
begin
	process(a1, a2,sel)
	begin
		if sel = '0' then
			b <= a1;
		else 
			b <= a2;
		end if;
	end process;
	

end Behavioral;

