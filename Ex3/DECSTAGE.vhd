----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:09:30 04/11/2024 
-- Design Name: 
-- Module Name:    DECSTAGE - Behavioral 
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

entity DECSTAGE is
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
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0);
			  selMem : in std_logic);
end DECSTAGE;

architecture Behavioral of DECSTAGE is
 COMPONENT registerFile
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         addr1 : IN  std_logic_vector(4 downto 0);
         addr2 : IN  std_logic_vector(4 downto 0);
         addrw : IN  std_logic_vector(4 downto 0);
         dout1 : OUT  std_logic_vector(31 downto 0);
         dout2 : OUT  std_logic_vector(31 downto 0);
         din : IN  std_logic_vector(31 downto 0);
         we : IN  std_logic
        );
    END COMPONENT;
	 component mux2 
		generic(dataWidth: integer := 32 );
		port(
			a1  : in std_logic_vector(dataWidth-1 downto 0);
			a2  : in std_logic_vector(dataWidth-1 downto 0);
			sel : in  std_logic;
			b   : out std_logic_vector(dataWidth-1 downto 0)
		);
	 end component;
	 component mux4
		generic(dataWidth: integer := 8 );
		port(
			a1  : in std_logic_vector(dataWidth-1 downto 0);
			a2  : in std_logic_vector(dataWidth-1 downto 0);
			a3  : in std_logic_vector(dataWidth-1 downto 0);
			a4  : in std_logic_vector(dataWidth-1 downto 0);
			sel : in  std_logic_vector(1 downto 0);
			b   : out std_logic_vector(dataWidth-1 downto 0)
		);
	 end component;
	 COMPONENT cloud
    PORT(
         din : IN  std_logic_vector(15 downto 0);
			ImmedControl: in STD_LOGIC_VECTOR(1 downto 0);
         immed : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 signal RF2S: std_logic_vector(4 downto 0);
	 signal dataToWriteToRF,selectedDataS, MEMOutS : std_logic_vector(31 downto 0);
	 signal selectedDataMuxOut : std_logic_vector(7 downto 0);
begin
	--RF_B_sel = instr(30)
	RF : registerFile
		port map(clk => clk, addr1 => instr(25 downto 21), addr2 => RF2S, addrw => instr(20 downto 16),
		dout1 => RF_A, dout2 => RF_B, din => dataToWriteToRF, we => RF_we, rst => rst);
	mux_reg2 : mux2 generic map (dataWidth => 5)
		port map(a1 => instr(15 downto 11), a2 => instr(20 downto 16), sel => RF_B_sel, b => RF2S);
	mux_wdata : mux2 generic map (dataWidth => 32)
		port map(a1 => ALUOut, a2 => MEMOutS, sel => RF_wData_sel, b => dataToWriteToRF);
	cloudUnit : cloud port map(din => instr(15 downto 0), immed => immed, ImmedControl => ImmedControl);
	mux_forBits:mux4 generic map(dataWidth => 8)
		port map(a1=>MEMOut(7 downto 0), a2=>MEMOut(15 downto 8), a3=>MEMOut(23 downto 16), a4=> MEMOut(31 downto 24),
		sel => ALUOut(1 downto 0) ,b => selectedDataMuxOut);
	selectedDataS <= (31 downto 8 => '0') & selectedDataMuxOut;
	mux_forMEM: mux2 generic map (dataWidth => 32)
		port map(a1 => MEMOut, a2 => selectedDataS, sel => selMem, b => MEMOutS);
	
end Behavioral;

