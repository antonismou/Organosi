----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:31:38 04/08/2024 
-- Design Name: 
-- Module Name:    mux16 - Behavioral 
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

entity mux8 is
port (
	a1  : in std_logic_vector(31 downto 0);
	a2  : in std_logic_vector(31 downto 0);
	a3  : in std_logic_vector(31 downto 0);
	a4  : in std_logic_vector(31 downto 0);
	a5  : in std_logic_vector(31 downto 0);
	a6  : in std_logic_vector(31 downto 0);
	a7  : in std_logic_vector(31 downto 0);
	a8  : in std_logic_vector(31 downto 0);
	sel     : in  std_logic_vector(3 downto 0);
	b       : out std_logic_vector(31 downto 0)
);
end mux8;

architecture Behavioral of mux8 is
signal b1,b2 : std_logic_vector(31 downto 0);
component mux4 is
port(
	a1  : in std_logic_vector(31 downto 0);
	a2  : in std_logic_vector(31 downto 0);
	a3  : in std_logic_vector(31 downto 0);
	a4  : in std_logic_vector(31 downto 0);
	sel     : in  std_logic_vector(1 downto 0);
	b       : out std_logic_vector(31 downto 0)
	);
end component mux4;

begin
	mux1 : mux4
	port map(
	a1 => a1,
	a2 => a2,
	a3 => a3,
	a4 => a4,
	sel => sel(1 downto 0),
	b => b1
	);
	mux2 : mux4
	port map(
	a1	 => a5,
	a2 => a6,
	a3 => a7,
	a4 => a8,
	sel => sel(3 downto 2),
	b => b2
	);
	process
	begin
		if sel(2) = '1' then 
			b <= b2;
		else
			b <= b1;
		end if;
	end process;
end Behavioral;

