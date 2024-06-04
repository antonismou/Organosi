----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:04:51 04/13/2024 
-- Design Name: 
-- Module Name:    decoder3to8 - Behavioral 
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

entity decoder3to8 is
  Port (  din : in  STD_LOGIC_VECTOR(2 downto 0);
          dout : out  STD_LOGIC_vector(7 downto 0);
			 en : in STD_LOGIC);
  end decoder3to8;
architecture Behavioral of decoder3to8 is
begin
process(din,en)
     begin
	  if en = '1' then
			case din is
				when "000"=>dout <="00000001";
				when "001"=>dout <="00000010";
				when "010"=>dout <="00000100";
				when "011"=>dout <="00001000";
				when "100"=>dout <="00010000";
				when "101"=>dout <="00100000";
				when "110"=>dout <="01000000";
				when others=>dout<="10000000"; 
			 end case;
		else 
			dout <="00000000";
		end if;
end process;
end Behavioral;

