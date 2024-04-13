----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:12:51 04/08/2024 
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

-- Uncomment the followDing library declaration if usDing
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the followDing library declaration if DinstantiatDing
-- any XilDinx primitives Din this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder3to8 is
    Port ( din : in  STD_LOGIC_VECTOR (2 downto 0);
			  en : in STD_LOGIC;	
           dout : out  STD_LOGIC_VECTOR (7 downto 0));
end decoder3to8;

architecture Behavioral of decoder3to8 is
	
	component decoder2to4
		port (din : in STD_LOGIC_VECTOR (1 downto 0);
				en : in STD_LOGIC;
				dout : out STD_LOGIC_VECTOR (3 downto 0)
				);
	end component decoder2to4;
	
	signal dec_intern : STD_LOGIC_VECTOR (1 downto 0);
	signal doutS : STD_LOGIC_VECTOR (7 downto 0);
	begin
		D0: decoder2to4
			port map ( din => din(1 downto 0),
						  en => dec_intern(0),
						  dout => doutS(3 downto 0)
						  );
						  
		D1: decoder2to4
			port map ( din => din(1 downto 0),
						  en => dec_intern(1),
						  dout => doutS(7 downto 4)
						  );
		process(din, en)
		begin
			if en = '1' then
				if din(2) = '0' then
					dec_intern <= "01";
					dout <= doutS;
				else 
					dec_intern <= "10";
					dout <= doutS;
				end if;
			else
				dout <= "00000000";
				
			end if;
		end process;	
	end Behavioral;

