----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:16:49 05/20/2024 
-- Design Name: 
-- Module Name:    IMEMComp - Behavioral 
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

entity IMEMComp is
	Port(
			clk : in std_logic;
			pc : in std_logic_vector(31 downto 0);
			immed : in std_logic_vector(31 downto 0);
			selBranch: in std_logic;
			instr : out std_logic_vector(31 downto 0));
end IMEMComp;

architecture Behavioral of IMEMComp is

	Component incrementor is
	Port( a:in  STD_LOGIC_VECTOR (31 downto 0);
			b:in  STD_LOGIC_VECTOR (31 downto 0);
			output: out  STD_LOGIC_VECTOR (31 downto 0));
	end Component;
	
	Component IFROM is
	Port( a: in STD_LOGIC_VECTOR (9 DOWNTO 0);
			spo: out STD_LOGIC_VECTOR (31 DOWNTO 0);
			clk : in  STD_LOGIC);
	end component;
	
	Component mux2 is
	Port(	a1  : in std_logic_vector(31 downto 0);
			a2  : in std_logic_vector(31 downto 0);
			sel : in  std_logic;
			b   : out std_logic_vector(31 downto 0));
	end component;
	
	signal incr_out, mux_out: std_logic_vector(31 downto 0);
begin

	incr_immed : incrementor port map(a => pc, b => immed, output => incr_out);
	mux : mux2 port map(a1 => pc, a2 => incr_out, sel => selBranch, b => mux_out);
	rom_mem : IFROM port map(a => mux_out(11 downto 2), spo => instr, clk => clk);

end Behavioral;

