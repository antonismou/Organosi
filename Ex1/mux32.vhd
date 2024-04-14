----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:40:02 04/08/2024 
-- Design Name: 
-- Module Name:    mux32 - Behavioral 
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

entity mux32 is
generic(dataWidth: integer := 32);
port(
	a1  : in std_logic_vector(dataWidth-1 downto 0);
	a2  : in std_logic_vector(dataWidth-1 downto 0);
	a3  : in std_logic_vector(dataWidth-1 downto 0);
	a4  : in std_logic_vector(dataWidth-1 downto 0);
	a5  : in std_logic_vector(dataWidth-1 downto 0);
	a6  : in std_logic_vector(dataWidth-1 downto 0);
	a7  : in std_logic_vector(dataWidth-1 downto 0);
	a8  : in std_logic_vector(dataWidth-1 downto 0);
	a9  : in std_logic_vector(dataWidth-1 downto 0);
	a10 : in std_logic_vector(dataWidth-1  downto 0);
	a11 : in std_logic_vector(dataWidth-1 downto 0);
	a12 : in std_logic_vector(dataWidth-1  downto 0);
	a13 : in std_logic_vector(dataWidth-1 downto 0);
	a14 : in std_logic_vector(dataWidth-1 downto 0);
	a15 : in std_logic_vector(dataWidth-1 downto 0);
	a16 : in std_logic_vector(dataWidth-1  downto 0);
	a17 : in std_logic_vector(dataWidth-1 downto 0);
	a18 : in std_logic_vector(dataWidth-1 downto 0);
	a19 : in std_logic_vector(dataWidth-1 downto 0);
	a20 : in std_logic_vector(dataWidth-1 downto 0);
	a21 : in std_logic_vector(dataWidth-1 downto 0);
	a22 : in std_logic_vector(dataWidth-1 downto 0);
	a23 : in std_logic_vector(dataWidth-1 downto 0);
	a24 : in std_logic_vector(dataWidth-1 downto 0);
	a25 : in std_logic_vector(dataWidth-1 downto 0);
	a26 : in std_logic_vector(dataWidth-1 downto 0);
	a27 : in std_logic_vector(dataWidth-1 downto 0);
	a28 : in std_logic_vector(dataWidth-1 downto 0);
	a29 : in std_logic_vector(dataWidth-1 downto 0);
	a30 : in std_logic_vector(dataWidth-1 downto 0);
	a31 : in std_logic_vector(dataWidth-1 downto 0);
	a32 : in std_logic_vector(dataWidth-1 downto 0);
	sel : in  std_logic_vector(4 downto 0);
	b   : out std_logic_vector(dataWidth-1 downto 0)
	);
end mux32;

architecture Behavioral of mux32 is
	COMPONENT mux16 is
	generic(dataWidth: integer := 32);
    PORT(
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
    END COMPONENT mux16;
	 COMPONENT mux2 is
	 generic(dataWidth: integer := 32);
    PORT(
         a1 : IN  std_logic_vector(dataWidth-1 downto 0);
         a2 : IN  std_logic_vector(dataWidth-1 downto 0);
         sel : IN  std_logic;
         b : OUT  std_logic_vector(dataWidth-1 downto 0)
        );
    END COMPONENT mux2;
	 signal b1,b2 : std_logic_vector(dataWidth-1 downto 0);
begin
	mux_1 : mux16
	generic map(dataWidth => dataWidth)
	port map(
		a1 => a1,
		a2 => a2,
		a3 => a3,
		a4 => a4,
		a5 => a5,
		a6 => a6,
		a7 => a7,
		a8 => a8,
		a9 => a9,
		a10 => a10,
		a11 => a11,
		a12 => a12,
		a13 => a13,
		a14 => a14,
		a15 => a15,
		a16 => a16,
		sel => sel(3 downto 0),
		b => b1
	);
	mux_2 : mux16 generic map(dataWidth => dataWidth)
	port map(
		a1 => a17,
		a2 => a18,
		a3 => a19,
		a4 => a20,
		a5 => a21,
		a6 => a22,
		a7 => a23,
		a8 => a24,
		a9 => a25,
		a10 => a26,
		a11 => a27,
		a12 => a28,
		a13 => a29,
		a14 => a30,
		a15 => a31,
		a16 => a32,
		sel => sel(3 downto 0),
		b => b2
	);
	mux_3 : mux2 generic map(dataWidth => dataWidth)
	port map(
	a1 => b1,
	a2 => b2,
	sel => sel(4),
	b => b
	);
end Behavioral;

