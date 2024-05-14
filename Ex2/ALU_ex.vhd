----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:21:33 04/14/2024 
-- Design Name: 
-- Module Name:    ALU_ex - Behavioral 
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

entity ALU_ex is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_Func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU_ex;

architecture Behavioral of ALU_ex is
Component mux2 is
		Port(	a1  : in std_logic_vector(31 downto 0);
				a2  : in std_logic_vector(31 downto 0);
				sel : in  std_logic;
				b   : out std_logic_vector(31 downto 0));
	end component;
Component ALU is
Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end component;

signal mux_out: STD_LOGIC_VECTOR (31 downto 0);
begin
mux : mux2 port map(
	a1=>RF_B,a2=>Immed,sel=>ALU_Bin_sel,b=>mux_out);

Alu_comp : ALU port map(
	A=>RF_A,B=>mux_out,Op=>ALU_func,Output=>ALU_out,Zero => Zero, Cout => Cout, Ovf => Ovf);


end Behavioral;

