----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:15:15 04/08/2024 
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

entity mux16 is
generic(dataWidth: integer := 32);
port (
	a1  : in std_logic_vector(dataWidth-1 downto 0);
	a2  : in std_logic_vector(dataWidth-1 downto 0);
	a3  : in std_logic_vector(dataWidth-1 downto 0);
	a4  : in std_logic_vector(dataWidth-1 downto 0);
	a5  : in std_logic_vector(dataWidth-1 downto 0);
	a6  : in std_logic_vector(dataWidth-1 downto 0);
	a7  : in std_logic_vector(dataWidth-1 downto 0);
	a8  : in std_logic_vector(dataWidth-1 downto 0);
	a9  : in std_logic_vector(dataWidth-1 downto 0);
	a10 : in std_logic_vector(dataWidth-1 downto 0);
	a11 : in std_logic_vector(dataWidth-1 downto 0);
	a12 : in std_logic_vector(dataWidth-1 downto 0);
	a13 : in std_logic_vector(dataWidth-1 downto 0);
	a14 : in std_logic_vector(dataWidth-1 downto 0);
	a15 : in std_logic_vector(dataWidth-1 downto 0);
	a16 : in std_logic_vector(dataWidth-1 downto 0);
	sel : in  std_logic_vector(3 downto 0);
	b   : out std_logic_vector(dataWidth-1 downto 0)
);
end mux16;

architecture Behavioral of mux16 is
signal b1,b2,b3,b4 : std_logic_vector(dataWidth-1 downto 0);
component mux4 is
generic(dataWidth: integer := 32);
port(
	a1  : in std_logic_vector(dataWidth-1 downto 0);
	a2  : in std_logic_vector(dataWidth-1 downto 0);
	a3  : in std_logic_vector(dataWidth-1 downto 0);
	a4  : in std_logic_vector(dataWidth-1 downto 0);
	sel     : in  std_logic_vector(1 downto 0);
	b       : out std_logic_vector(dataWidth-1 downto 0)
	);
end component mux4;

begin
	mux_1 : mux4 generic map(dataWidth => dataWidth)
	port map(
	a1 => a1,
	a2 => a2,
	a3 => a3,
	a4 => a4,
	sel => sel(1 downto 0),
	b => b1
	);
	mux_2 : mux4 generic map(dataWidth => dataWidth)
	port map(
	a1	 => a5,
	a2 => a6,
	a3 => a7,
	a4 => a8,
	sel => sel(1 downto 0),
	b => b2
	);
	mux_3 : mux4 generic map(dataWidth => dataWidth)
	port map(
	a1	 => a9,
	a2 => a10,
	a3 => a11,
	a4 => a12,
	sel => sel(1 downto 0),
	b => b3
	);
	mux_4 : mux4 generic map(dataWidth => dataWidth)
	port map(
	a1	 => a13,
	a2 => a14,
	a3 => a15,
	a4 => a16,
	sel => sel(1 downto 0),
	b => b4
	);
	mux_5 : mux4 generic map(dataWidth => dataWidth)
	port map(
	a1	 => b1,
	a2 => b2,
	a3 => b3,
	a4 => b4,
	sel => sel(3 downto 2),
	b => b
	);
end Behavioral;

