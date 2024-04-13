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
	dout : out STD_LOGIC_VECTOR(3 downto 0)
);
end decoder2to4;

architecture Behavioral of decoder2to4 is
begin
	process(din)
	begin
		case din is
			when "00" =>  dout <= "0001";
			when "01" =>  dout <= "0010";
			when "10" =>  dout <= "0100";
			when others => dout <= "1000";
		end case;
	end process;
end Behavioral;

