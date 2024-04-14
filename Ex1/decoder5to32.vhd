----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:16:31 04/08/2024 
-- Design Name: 
-- Module Name:    decoder5to32 - Behavioral 
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

entity decoder5to32 is
    Port ( din : in  STD_LOGIC_VECTOR (4 downto 0);
           dout : out STD_LOGIC_VECTOR (31 downto 0));
end decoder5to32;

architecture structural of decoder5to32 is
	component decoder3to8
		port (din : in STD_LOGIC_VECTOR (2 downto 0);
				dout : out STD_LOGIC_VECTOR (7 downto 0);
				en : in STD_LOGIC
				);
	end component;
	
	component decoder2to4
		port (din : in STD_LOGIC_VECTOR (1 downto 0);
				dout : out STD_LOGIC_VECTOR (3 downto 0)
				);
	end component;

	signal dec_intern : STD_LOGIC_VECTOR (3 downto 0);

	begin 
		
		D0 : decoder2to4
			port map ( din => din(4 downto 3),
						  dout => dec_intern
						);
							
		D1 : decoder3to8
			port map (din => din(2 downto 0),
						 en => dec_intern(0),
						 dout => dout(7 downto 0)
						 );
						 
		D2 : decoder3to8
			port map (din => din(2 downto 0),
						 en => dec_intern(1),
						 dout => dout(15 downto 8)
						 );
						 
		D3 : decoder3to8
			port map (din => din(2 downto 0),
						 en => dec_intern(2),
						 dout => dout(23 downto 16)
						 );
						 
		D4 : decoder3to8
			port map (din => din(2 downto 0),
						 en => dec_intern(3),
						 dout => dout(31 downto 24)
						 );
	
		
	
end structural;

