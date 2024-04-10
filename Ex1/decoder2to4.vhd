----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:06:03 04/08/2024 
-- Design Name: 
-- Module Name:    decoder2to4 - Behavioral 
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

entity decoder2to4 is
port(
	din : in STD_LOGIC_VECTOR(1 downto 0);
	en : in STD_LOGIC;
	dout : out STD_LOGIC_VECTOR(3 downto 0)
);
end decoder2to4;

architecture Behavioral of decoder2to4 is
begin
	process(en,din)
	begin
		case en is
			when '1' =>
				if din = "00" then
					dout <= "0001";
				elsif din = "01" then
					dout <= "0010";
				elsif din = "10" then
					dout <= "0100";
				else 
					dout <= "1000";
				end if;
			when others =>
				dout <= "0000";
		end case;
	end process;
end Behavioral;

