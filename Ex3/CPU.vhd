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
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC);
end CPU;

architecture Behavioral of CPU is
COMPONENT Datapath
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           pcSel : in  STD_LOGIC;
           pcLdEn : in  STD_LOGIC;
           selBranch : in std_logic;
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
           selMem : in std_logic;
           weImmed: in std_logic;
           weAluOut: in std_logic;
           we_Reg_to_Dec: in std_logic;
           we_mem_to_wb: in std_logic;
           we_RegA: in std_logic;
           we_RegB: in std_logic);
END COMPONENT;
COMPONENT Control
    Port ( instr : in  STD_LOGIC_VECTOR (31 downto 0);
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
           rst : in  STD_LOGIC;
           clk: in STD_LOGIC;
           immedControl: out STD_LOGIC_VECTOR(1 downto 0);
           selMem : out std_logic;
           selBranch : out std_logic;
           weImmed: out std_logic;
           weAluOut: out std_logic;
           we_Reg_A: out std_logic;
           we_Reg_B: out std_logic;
           we_mem_to_wb: out std_logic;
           we_Reg_to_Dec: out std_logic);
END COMPONENT;
signal pcSelS, pcLdEnS, rfWeS, rfBSelS, rfWrDataSelS, memWeS, aluBinSelS, zeroS, ovfS, coutS, selMemS, selBranchS, weAluOutS, weImmedS, we_Reg_to_DecS, we_mem_to_wbS, we_RegAS, we_RegBS: std_logic;
signal immedCS: std_logic_vector(1 downto 0);
signal aluFuncS : std_logic_vector(3 downto 0);
signal instrS : std_logic_vector(31 downto 0);
begin
    cpu_control: Control port map(
        instr => instrS,
        zero => zeroS,
        ovf => ovfS,
        cout => coutS,
        pcSel => pcSelS,
        pcLdEn => pcLdEnS,
        rfWe => rfWeS,
        rfBSel => rfBSelS,
        rfWrDataSel => rfWrDataSelS,
        memWe => memWeS,
        aluBinSel => aluBinSelS,
        aluFunc => aluFuncS,
        rst => rst,
        clk => clk,
        immedControl => immedCS,
        selMem => selMemS,
        selBranch => selBranchS,
        weImmed => weImmedS,
        weAluOut => weAluOutS,
        we_Reg_A => we_RegAS, 
        we_Reg_B => we_RegBS,
        we_mem_to_wb => we_mem_to_wbS,
        we_Reg_to_Dec => we_Reg_to_DecS);

	 cpu_datapath: Datapath port map(
        clk => clk,
        rst => rst,
        pcSel => pcSelS,
        pcLdEn => pcLdEnS,
        selBranch => selBranchS,
        RFWe => rfWeS,
        RFWrData => rfWrDataSelS,
        RF_B_sel => rfBSelS,
        WeMem => memWeS,
        ALU_Bin_sel => aluBinSelS,
        ALU_Func => aluFuncS,
        Zero => zeroS,
        Ovf => ovfS,
        Cout => coutS,
        ImmedControl => immedCS,
        instr => instrS,
        selMem => selMemS,
        weImmed => weImmedS,
        weAluOut => weAluOutS,
        we_Reg_to_Dec => we_Reg_to_DecS,
        we_mem_to_wb => we_mem_to_wbS,
        we_RegA => we_RegAS,
        we_RegB => we_RegBS
    );

end Behavioral;

