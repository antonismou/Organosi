----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:20:18 04/19/2024 
-- Design Name: 
-- Module Name:    CPU - Behavioral 
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

entity CPU is
    Port ( clk : in  STD_LOGIC;rst: in  STD_LOGIC);
end CPU;

architecture Behavioral of CPU is
COMPONENT Datapath
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           pcSel : in  STD_LOGIC;
           pcLdEn : in  STD_LOGIC;
           RFWe : in std_logic;
           RFWrData : in std_logic;
			  RF_B_sel : in std_logic;
           WeMem : in std_logic;
			  ALU_Bin_sel : in std_logic;
			  ALU_Func : in std_logic_vector(3 downto 0);
           Zero : out std_logic;
           Ovf : out std_logic;
           Cout : out std_logic;
			  ImmedControl: in STD_LOGIC_VECTOR(1 downto 0);
			  instr : out  STD_LOGIC_VECTOR (31 downto 0);
			  selMem : in std_logic);
    END COMPONENT;
COMPONENT Control
	Port (instr : in  STD_LOGIC_VECTOR (31 downto 0);
			zero : in std_logic;
			ovf : in std_logic;
			cout : in std_logic;
        	pcSel : out  STD_LOGIC;
        	pcLdEn : out  STD_LOGIC;
        	rfWe : out  STD_LOGIC;
        	rfBSel : out  STD_LOGIC;
        	rfWrDataSel : out  STD_LOGIC;
        	memWe : out  STD_LOGIC;
			aluBinSel : out std_logic;
			aluFunc : out STD_LOGIC_VECTOR(3 downto 0);
        	rstOut : out  STD_LOGIC;
        	rst : in  STD_LOGIC;
			immedControl: out STD_LOGIC_VECTOR(1 downto 0);
			clk: in STD_LOGIC;
			selMem : out std_logic);
	END COMPONENT;
	signal pcSelS,pcLdEnS,rfWeS,rfBSelS,rfWrDataSelS,memWeS,aluBinSelS,zeroS,ovfS,coutS,selMem: std_logic;
	signal immedCS: std_logic_vector(1 downto 0);
	signal aluFuncS : std_logic_vector(3 downto 0);
	signal instrS : std_logic_vector(31 downto 0);
begin
	cpu_controler: control port map(instr => instrS,zero => zeroS, ovf=> ovfS, cout => coutS, pcSel => pcSelS,
		pcLdEn => pcLdEnS, rfWe => rfWeS, rfBSel => rfBSelS, rfWrDataSel => rfWrDataSelS, memWe=> memWeS,immedControl=>immedCS,
		aluBinSel => aluBinSelS, aluFunc => aluFuncS, rst => rst, clk => clk , selMem => selMem);
	cpu_datapath: datapath port map(instr => instrS,Zero => zeroS, Ovf=> ovfS, Cout => coutS, pcSel => pcSelS,
		pcLdEn => pcLdEnS, RFWe => rfWeS, RF_B_Sel => rfBSelS, RFWrData => rfWrDataSelS, WeMem=> memWeS, ImmedControl=>immedCS,
		ALU_Bin_Sel => aluBinSelS, ALU_Func => aluFuncS, rst => rst, clk => clk, selMem => selMem);

end Behavioral;

