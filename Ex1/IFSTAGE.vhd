----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:14:21 04/14/2024 
-- Design Name: 
-- Module Name:    IFSTAGE - Behavioral 
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

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is
	Component mux2 is
		Port(	a1  : in std_logic_vector(31 downto 0);
				a2  : in std_logic_vector(31 downto 0);
				sel : in  std_logic;
				b   : out std_logic_vector(31 downto 0));
	end component;
	
--	Component incrementor_4 is
--		 Port ( input : in  STD_LOGIC_VECTOR (31 downto 0);
--				  output : out  STD_LOGIC_VECTOR (31 downto 0));
--	end component;
--	
--	Component incrementor_immed is
--		Port ( input_incr_4 : in  STD_LOGIC_VECTOR (31 downto 0);
--				 immed : in  STD_LOGIC_VECTOR (31 downto 0);
--             output : out  STD_LOGIC_VECTOR (31 downto 0));
--	end component;
	Component incrementor is
		Port( a:in  STD_LOGIC_VECTOR (31 downto 0);
				b:in  STD_LOGIC_VECTOR (31 downto 0);
				output: out  STD_LOGIC_VECTOR (31 downto 0));
	end Component;
	
	Component reg is
	Port ( clk : in  STD_LOGIC;
			  rst : STD_LOGIC;
           we : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (31 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component;
	
	Component IFROM is
		Port( a: in STD_LOGIC_VECTOR (9 DOWNTO 0);
				spo: out STD_LOGIC_VECTOR (31 DOWNTO 0);
				clk : in  STD_LOGIC);
		end component;
		
signal mux2_out: STD_LOGIC_VECTOR (31 DOWNTO 0);
signal incrementor_4_out: STD_LOGIC_VECTOR (31 DOWNTO 0);
signal reg_out: STD_LOGIC_VECTOR (31 DOWNTO 0);
signal incrementor_out: STD_LOGIC_VECTOR (31 DOWNTO 0);
begin

--incrementor4 : incrementor_4 port map (
--	input=>reg_out, output=>incrementor_4_out);
--
--incrementorImmed: incrementor_immed port map(
--	input_incr_4=>incrementor_4_out, immed=>Pc_Immed, output=>incrementor_out);
incr_4: incrementor port map(
	a=>reg_out, b=>x"00000004",output=>incrementor_4_out);
	
incr_immed: incrementor port map(
	a=>incrementor_4_out, b=>PC_Immed,output=>incrementor_out);
	
mux: mux2 port map(
	a1=>incrementor_4_out,a2=>incrementor_out,sel=>PC_sel,b=>mux2_out);

program_counter: reg port map(
	clk=>clk, rst=>rst, we=>Pc_LdEn, data=>mux2_out, dout=>reg_out);
	
rom_mem : IFROM port map (
	clk=>clk,a=>reg_out(11 downto 2), spo=>Instr);



end Behavioral;

