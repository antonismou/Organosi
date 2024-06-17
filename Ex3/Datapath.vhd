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
           WBdata : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_wData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           immed : out  STD_LOGIC_VECTOR (31 downto 0);
           ImmedControl: in STD_LOGIC_VECTOR(1 downto 0);
			  RD: IN STD_LOGIC_VECTOR(4 downto 0);
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
			  addr_RF_B: out STD_LOGIC_VECTOR (4 downto 0);
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
COMPONENT Big_fu is
Port( EX_MEM_reg_Rd: in STD_LOGIC_VECTOR (4 downto 0);
		ID_EX_reg_Rs: in STD_LOGIC_VECTOR (4 downto 0); 
		ID_EX_reg_Rt: in STD_LOGIC_VECTOR (4 downto 0);
		MEM_WB_reg_Rd: in STD_LOGIC_VECTOR (4 downto 0);
		EX_MEM_reg_WB: in  STD_LOGIC;
		MEM_WB_reg_WB: in  STD_LOGIC;
		ForwardA: out STD_LOGIC_VECTOR (1 downto 0);
		ForwardB: out STD_LOGIC_VECTOR (1 downto 0)
);
END COMPONENT;
COMPONENT mux4
		generic(dataWidth: integer := 32 );
		port(
			a1  : in std_logic_vector(dataWidth-1 downto 0);
			a2  : in std_logic_vector(dataWidth-1 downto 0);
			a3  : in std_logic_vector(dataWidth-1 downto 0);
			a4  : in std_logic_vector(dataWidth-1 downto 0);
			sel : in  std_logic_vector(1 downto 0);
			b   : out std_logic_vector(dataWidth-1 downto 0)
		);
END COMPONENT;
COMPONENT mux2
		generic(dataWidth: integer := 32 );
		port(
			a1  : in std_logic_vector(dataWidth-1 downto 0);
			a2  : in std_logic_vector(dataWidth-1 downto 0);
			sel : in  std_logic;
			b   : out std_logic_vector(dataWidth-1 downto 0)
		);
END COMPONENT;
signal ForwardAS,ForwardBS: STD_LOGIC_VECTOR(1 downto 0);
signal muxA_out,muxB_out: STD_LOGIC_VECTOR(31 downto 0);
signal dataToWriteToRF,selectedDataS,MEMoutS : std_logic_vector(31 downto 0);
signal selectedDataMuxOut : std_logic_vector(7 downto 0);
signal addr_RFB: std_logic_vector(4 downto 0);
signal instrSToReg,immedS,immedSToReg,RFASToReg,RFBSToReg,ALU_outSToReg,MemOutSToReg : STD_LOGIC_VECTOR(31 downto 0);
signal cntrlS : std_logic_vector(10 downto 0);
signal IF_DEC_reg_in,IF_DEC_reg_out : STD_LOGIC_VECTOR(31 downto 0);	--in/out for reg IF/DEC size: 32(instr)
signal DEC_EX_reg_in,DEC_EX_reg_out : STD_LOGIC_VECTOR(89 downto 0);	--in/out for reg DEC/EX size: 5(addr_RF_s)+ 5(addr_RF_t)+ 11(cntrl S)+ 5(addr_RF_D)+ 32(RF_A)+ 32(RF_B)= 90 
signal EX_MEM_reg_in,EX_MEM_reg_out : STD_LOGIC_VECTOR(73 downto 0);	--in/out for reg EX/MEM size: 5(cntrl S)+ 5(addr_RF_D)+ 32(RF_B)+ 32(ALU_OUT)= 74
signal MEM_WB_reg_in,MEM_WB_reg_out : STD_LOGIC_VECTOR(71 downto 0);	--in/out for reg MEM/WB size: 3(cntrl S)+ 5(addr_RF_D)+ 32(ALU_out)+ 32(MEM_out)= 72
begin
fw: Big_fu port map(
	EX_MEM_reg_Rd => EX_MEM_reg_out(68 downto 64),
	ID_EX_reg_Rs => DEC_EX_reg_out(89 downto 85),
	ID_EX_reg_Rt => DEC_EX_reg_out(84 downto 80),
	MEM_WB_reg_Rd => MEM_WB_reg_out(68 downto 64),
	EX_MEM_reg_WB => EX_MEM_reg_out(70),
	MEM_WB_reg_WB => MEM_WB_reg_out(70),
	ForwardA => ForwardAS,
	ForwardB => ForwardBS);

muxA: mux4 port map(
	a1=>DEC_EX_reg_out( 63 downto 32), --RF_A from ID
	a2=>dataToWriteToRF,
	a3=> EX_MEM_reg_out(31 downto 0), -- ALU_OUT
	a4=>DEC_EX_reg_out( 63 downto 32), --RF_A from ID
	sel=>ForwardAS,
	b=>muxA_out);

muxB: mux4 port map(
	a1=>DEC_EX_reg_out(31 downto 0), --RF_B from ID
	a2=>dataToWriteToRF,
	a3=> EX_MEM_reg_out(31 downto 0), -- ALU_OUT
	a4=>DEC_EX_reg_out(31 downto 0), --RF_B	from ID
	sel=>ForwardBS,
	b=>muxB_out);
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
    instr => IF_DEC_reg_out, rst => rst, clk => clk, RF_we => MEM_WB_reg_out(70),
	 WBdata => dataToWriteToRF,
	 RF_B_sel => RF_B_sel,RF_wData_sel => MEM_WB_reg_out(69), immed => immedSToReg,
	 RD=> MEM_WB_reg_out(68 downto 64) ,RF_A => RFASToReg, RF_B => RFBSToReg,
	 addr_RF_B=>addr_RFB,
	 ImmedControl => ImmedControl, selMem => MEM_WB_reg_out(71));
--------------------------------DEC/IF(IMMED)REG--------------------------------
DEC_IF_Immed_reg: reg port map(clk=> clk, rst => rst, we => we_DEC_IF_Immed_reg, data => immedSToReg, dout => immedS);
-----------------------------------DEC/EX REG-----------------------------------
DEC_EX_reg_in <= IF_DEC_reg_out(25 downto 21) & addr_RFB & cntrlS & IF_DEC_reg_out(20 downto 16) & RFASToReg & RFBSToReg ;
DEC_EX_reg : reg generic map(dataWidth => 90)
				port map(clk=> clk, rst => rst, we => we_DEC_EX_reg, data => DEC_EX_reg_in, dout => DEC_EX_reg_out);
--cntrlS = ALU_Bin_sel(79) & ALU_Func(78 downto 75) & we_EX_MEM_REG(74) & WeMem(73) & we_MEM_WB_REG(72) & selMem(71) & RFWe(70) & RFWrData(69)
--DEC_EX_reg_out = addr_RF_s(89 downto 85)+ addr_RF_t(84 downto 80)+ cntrlS(79 downto 69)+ addr_RF_D(68 downto 64)+ RF_A(63 downto 32)+ RF_B (31 downto 0)				
---------------------------------------EX---------------------------------------
EX: ALU_ex port map(RF_A => muxA_out, RF_B => muxB_out, immed => immedS, ALU_Bin_sel => DEC_EX_reg_out(79),
    ALU_Func => DEC_EX_reg_out(78 downto 75) , ALU_out => ALU_outSToReg, Zero => Zero, Ovf => Ovf, Cout => Cout);
-----------------------------------EX/MEM REG-----------------------------------
EX_MEM_reg_in <= DEC_EX_reg_out(73 downto 64) & DEC_EX_reg_out(31 downto 0) & ALU_outSToReg ;
EX_MEM_reg : reg generic map(dataWidth => 74)
				port map(clk => clk, rst => rst, we => DEC_EX_reg_out(74), data => EX_MEM_reg_in, dout => EX_MEM_reg_out);
--cntrlS = WeMem(73) & we_MEM_WB_REG(72) & selMem(71) & RFWe(70) & RFWrData(69)
--EX_MEM_reg_out = cntrlS(73 downto 69) + addr_RF_D(68 downto 64) + RF_B(63 downto 32) + ALU_out(31 downto 0)
---------------------------------------MEM--------------------------------------
MEMO : MEM port map(clk => clk, Mem_WrEn => EX_MEM_reg_out(73) , ALU_MEM_addr => EX_MEM_reg_out(31 downto 0),
						  MEM_DataOut => MemOutSToReg, MEM_DataIn => EX_MEM_reg_out(63 downto 32));
-----------------------------------MEM/WB REG-----------------------------------
MEM_WB_reg_in <= EX_MEM_reg_out(71 downto 64) & EX_MEM_reg_out(31 downto 0) & MemOutSToReg;
MEM_WB_reg : reg generic map(dataWidth => 72)
				port map(clk => clk, rst => rst, we => EX_MEM_reg_out(72), data => MEM_WB_reg_in, dout => MEM_WB_reg_out);
--cntrlS = selMem(71) & RFWe(70) & RFWrData(69)
--MEM_WB_reg_out = cntrl(71 downto 69) + addr_RF_D(68 downto 64) + ALU_out(63 downto 32) + MEM_out(31 downto 0)
instr <= IF_DEC_reg_out(31 downto 0);
---------------------------------------WB---------------------------------------
--Choose MEM OR ALU
mux_wdata : mux2 generic map (dataWidth => 32)
		port map(a1 => MEM_WB_reg_out(63 downto 32), a2 => MEMOutS, sel => MEM_WB_reg_out(69), b => dataToWriteToRF);
		--a1 = ALU_out, a2= MEM_out , sel = RFWrData
--Choose byte from MEM
mux_forBits:mux4 generic map(dataWidth => 8)
	port map(a1=>MEM_WB_reg_out(7 downto 0), a2=>MEM_WB_reg_out(15 downto 8), a3=>MEM_WB_reg_out(23 downto 16), a4=> MEM_WB_reg_out(31 downto 24),
	sel => MEM_WB_reg_out(33 downto 32) ,b => selectedDataMuxOut);
	--sel = ALU_out(1 downto 0)
--Zero fill for byte
selectedDataS <= (31 downto 8 => '0') & selectedDataMuxOut;
--Choose selected byte or whole MEM
mux_forMEM: mux2 generic map (dataWidth => 32)
		port map(a1 => MEM_WB_reg_out(31 downto 0), a2 => selectedDataS, sel => MEM_WB_reg_out(71), b => MEMOutS);
		--a1 = MEM, a2 = selectedByte, sel = selMem

end Behavioral;