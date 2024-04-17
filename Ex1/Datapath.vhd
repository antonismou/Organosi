----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:28:48 04/12/2024 
-- Design Name: 
-- Module Name:    Datapath - Behavioral 
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

entity Datapath is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           pcImmed : in  STD_LOGIC_VECTOR (31 downto 0);
           pcSel : in  STD_LOGIC;
           pcLdEn : in  STD_LOGIC);
end Datapath;

architecture Behavioral of Datapath is
COMPONENT IFSTAGE
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         rst : IN  std_logic;
         clk : IN  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
COMPONENT DECSTAGE
    PORT(
         instr : IN  std_logic_vector(31 downto 0);
			rst: in std_logic;
         RF_we : IN  std_logic;
         ALUOut : IN  std_logic_vector(31 downto 0);
         MEMOut : IN  std_logic_vector(31 downto 0);
         RF_wData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         clk : IN  std_logic;
         immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
COMPONENT ALU_ex
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_Func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
component MEM 
    Port ( clk : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end component;
signal instrS,AluOutS,MemOutS,immedS,RFA,RFB : STD_LOGIC_VECTOR(31 downto 0);
signal RFWeS, RFWrDataS, WeMemS : STD_LOGIC;
begin
InsFetch: IFSTAGE port map(PC_Immed => pcImmed, PC_sel => pcSel, PC_LdEn => pcLdEn, rst => RST, clk => clk, Instr => instrS);
Decoder: DECSTAGE port map(
	instr => instrS, rst => rst, clk => clk, RF_we => RFWeS, ALUOut => AluOutS, MEMOut => MemOutS, RF_B_sel => instrS(30),
	RF_wData_sel => RFWrDataS, immed => immedS, RF_A => RFA, RF_B => RFB);
AlU: ALU_ex port map(RF_A => RFA, RF_B => RFB, immed => immedS, ALU_Bin_sel => instrS(30),
	ALU_Func => instrS(3 downto 0), ALU_out => AluOutS);
	
MEMO : MEM port map(clk => clk, Mem_WrEn => WeMemS , ALU_MEM_addr => AluOutS, MEM_DataOut => MemOutS, MEM_DataIn =>RFB);
WeMemS <= ((not instrS(31)) and (not instrS(30)) and (not instrS(29)) and instrS(28)) or
			 ((not instrS(31)) and instrS(30) and instrS(29) and instrS(28));
end Behavioral;

