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
    Port (  clk : in  STD_LOGIC;
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
            we_DEC_IF_Immed_reg: in std_logic;
            we_IF_DEC_reg: in std_logic;
				we_DEC_EX_reg : in std_logic;
				we_EX_MEM_reg: in std_logic;
				we_MEM_WB_reg: in std_logic);
end Datapath;

architecture Behavioral of Datapath is

COMPONENT RegDecToExec
    Port(
        clk: in std_logic;
        rst: in std_logic;
        RF_AIN : IN  std_logic_vector(31 downto 0);
        RF_BIN : IN  std_logic_vector(31 downto 0);
        RF_AOUT : OUT  std_logic_vector(31 downto 0);
        RF_BOUT : OUT std_logic_vector(31 downto 0)
    );
End COMPONENT;

COMPONENT reg
    generic(dataWidth: integer := 32);
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         we : IN  std_logic;
         data : IN  std_logic_vector(dataWidth-1 downto 0);
         dout : OUT  std_logic_vector(dataWidth-1 downto 0)
    );
END COMPONENT;
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
    Port ( instr : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in std_logic;
           RF_we : in  STD_LOGIC;
           ALUOut : in  STD_LOGIC_VECTOR (31 downto 0);
           MEMOut : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_wData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           immed : out  STD_LOGIC_VECTOR (31 downto 0);
           ImmedControl: in STD_LOGIC_VECTOR(1 downto 0);
			  RD: IN STD_LOGIC_VECTOR(4 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
           selMem : in std_logic);
END COMPONENT;
COMPONENT ALU_ex
    PORT(
         RF_A : IN  std_logic_vector(31 downto 0);
         RF_B : IN  std_logic_vector(31 downto 0);
         Immed : IN  std_logic_vector(31 downto 0);
         ALU_Bin_sel : IN  std_logic;
         ALU_Func : IN  std_logic_vector(3 downto 0);
         ALU_out : OUT  std_logic_vector(31 downto 0);
         Zero : out  STD_LOGIC;
         Cout : out  STD_LOGIC;
         Ovf : out  STD_LOGIC);
END COMPONENT;

COMPONENT MEM 
    Port ( clk : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
END COMPONENT;
signal instrS,instrSToReg,immedS,immedSToReg,RFASToReg,RFBSToReg,ALU_outSToReg,MemOutS,MemOutSToReg : STD_LOGIC_VECTOR(31 downto 0);
signal cntrlS : std_logic_vector(10 downto 0);
signal IF_DEC_reg_in,IF_DEC_reg_out : STD_LOGIC_VECTOR(31 downto 0);	--in/out for reg IF/DEC size: 32(instr)
signal DEC_EX_reg_in,DEC_EX_reg_out : STD_LOGIC_VECTOR(79 downto 0);	--in/out for reg DEC/EX size: 11(cntrl S)+ 5(RF_D)+ 32(RF_A)+ 32(RF_B)= 80 
signal EX_MEM_reg_in,EX_MEM_reg_out : STD_LOGIC_VECTOR(73 downto 0);	--in/out for reg EX/MEM size: 5(cntrl S)+ 5(RF_D)+ 32(RF_B)+ 32(ALU_OUT)= 74
signal MEM_WB_reg_in,MEM_WB_reg_out : STD_LOGIC_VECTOR(71 downto 0);	--in/out for reg MEM/WB size: 3(cntrl S)+ 5(RF_D)+ 32(ALU_out)+ 32(MEM_out)= 72
begin
------------------CREATE VECTOR WITH ALL CONTROL SIGNALS FROM CONTROLLER------------------
cntrlS <= ALU_Bin_sel & ALU_Func & we_EX_MEM_REG & WeMem & we_MEM_WB_REG & selMem & RFWe & RFWrData;
---------------------------------------IF-------------------------------------- 
InsFetch: IFSTAGE port map(PC_Immed => immedS, PC_sel =>pcSel, PC_LdEn => pcLdEn, rst => rst, clk => clk, Instr => instrSToReg);
-----------------------------------IF/DEC REG----------------------------------
IF_DEC_reg_in <= instrSToReg;		-- instr
IF_DEC_reg : reg generic map(dataWidth => 32)
				port map(clk=> clk, rst => rst, we => we_IF_DEC_reg, data => IF_DEC_reg_in, dout => IF_DEC_reg_out);
--------------------------------------DEC--------------------------------------
ID: DECSTAGE port map(
    instr => instrS, rst => rst, clk => clk, RF_we => MEM_WB_reg_out(70), ALUOut => MEM_WB_reg_out(63 downto 32), MEMOut => MEM_WB_reg_out(31 downto 0), 
	 RF_B_sel => RF_B_sel,RF_wData_sel => MEM_WB_reg_out(69), immed => immedSToReg,RD=> MEM_WB_reg_out(68 downto 64) ,RF_A => RFASToReg, RF_B => RFBSToReg,
	 ImmedControl => ImmedControl, selMem => MEM_WB_reg_out(71));
--------------------------------DEC/IF(IMMED)REG--------------------------------
DEC_IF_Immed_reg: reg port map(clk=> clk, rst => rst, we => we_DEC_IF_Immed_reg, data => immedSToReg, dout => immedS);
-----------------------------------DEC/EX REG-----------------------------------
DEC_EX_reg_in <= cntrlS & instrS(20 downto 16) & RFASToReg & RFBSToReg ;	--cntrl + RF_D + RF_A + RF_B
DEC_EX_reg : reg generic map(dataWidth => 80)
				port map(clk=> clk, rst => rst, we => we_DEC_EX_reg, data => DEC_EX_reg_in, dout => DEC_EX_reg_out); 
---------------------------------------EX---------------------------------------
EX: ALU_ex port map(RF_A => DEC_EX_reg_out(63 downto 32), RF_B => DEC_EX_reg_out(31 downto 0), immed => immedS, ALU_Bin_sel => DEC_EX_reg_out(79),
    ALU_Func => DEC_EX_reg_out(78 downto 75) , ALU_out => ALU_outSToReg, Zero => Zero, Ovf => Ovf, Cout => Cout);
-----------------------------------EX/MEM REG-----------------------------------
EX_MEM_reg_in <= DEC_EX_reg_out(73 downto 64) & DEC_EX_reg_out(31 downto 0) & ALU_outSToReg ;	--cntrl + RF_D + RF_B + ALU_out
EX_MEM_reg : reg generic map(dataWidth => 74)
				port map(clk => clk, rst => rst, we => DEC_EX_reg_out(74), data => EX_MEM_reg_in, dout => EX_MEM_reg_out);
---------------------------------------MEM--------------------------------------
MEMO : MEM port map(clk => clk, Mem_WrEn => EX_MEM_reg_out(73) , ALU_MEM_addr => EX_MEM_reg_out(31 downto 0),
						  MEM_DataOut => MemOutSToReg, MEM_DataIn => EX_MEM_reg_out(63 downto 32));
-----------------------------------MEM/WB REG-----------------------------------
MEM_WB_reg_in <= EX_MEM_reg_out(71 downto 64) & EX_MEM_reg_out(31 downto 0) & MemOutSToReg;	-- cntrl + RF_D + ALU_out + MEM_out
MEM_WB_reg : reg generic map(dataWidth => 72)
				port map(clk => clk, rst => rst, we => EX_MEM_reg_out(72), data => MEM_WB_reg_in, dout => MEM_WB_reg_out);

instr <= IF_DEC_reg_out(31 downto 0);
end Behavioral;