----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:16:36 04/17/2024 
-- Design Name: 
-- Module Name:    Control - Behavioral 
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

entity Control is
    Port (	instr : in  STD_LOGIC_VECTOR (31 downto 0);
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
			clk: in STD_LOGIC;
			immedControl: out STD_LOGIC_VECTOR(1 downto 0);
			selMem : out std_logic;
			we_IF_DEC_reg: out std_logic;
			we_DEC_IF_reg: out std_logic;
			we_DEC_EX_reg: out std_logic;
			we_EX_MEM_reg: out std_logic;
			we_MEM_WB_reg: out std_logic
			);
end Control;

architecture Behavioral of Control is
type fsmStates is (rtype,li,lui,addi,andi,ori,b,beq,bne,lb,lw,sb,sw,idle,afterB);
signal state,nextState : fsmStates;

begin
	findState : process(instr)
	begin
	--wait until clk'event and clk = '1';
	if rst = '1' then
			state <= idle;
	else 
		case instr(31 downto 26) is
			when "100000" => state <= rtype;
			when "111000" => state <= li;	
			when "111001" => state <= lui;
			when "110000" => state <= addi;
			when "110010" => state <= andi;
			when "110011" => state <= ori;
			when "111111" => state <= b;
			when "010000" => state <= beq;
			when "010001" => state <= bne;
			when "000011" => state <= lb;
			when "001111" => state <= lw;
			when "000111" => state <= sb;
			when "011111" => state <= sw;
			when others => state <= idle;
			end case;
	end if;
	end process;
	
	
	output: process(instr,state,zero)
	begin
		case state is
			when idle =>
				--IFSTATE
				pcSel <= '0';
				pcLdEn <= '1';
				--DecState
				immedControl<="XX"; 
				rfBSel <= '0';
				--ExState
				aluBinSel <= '0';
				aluFunc <= "0000";
				-- Mem State
				selMem <= 'X';
				memWe <= '0';
				--WbState
				rfWe <= '0';
				rfWrDataSel <= '0';
				--REGISTERS BETWEEN STAGES
				we_IF_DEC_reg <= '1';
				we_DEC_IF_reg <= '1';
				we_DEC_EX_reg <= '1';
				we_EX_MEM_reg <= '1';
				we_MEM_WB_reg <= '1';
				--NextState
				nextState<= idle;
			when rtype => 
				--IFSTATE
				pcSel <= '0';
				pcLdEn <= '1';
				--DecState
				immedControl<="XX"; --not in use
				rfBSel <= '0';
				--ExState
				aluBinSel <= '0';
				aluFunc <= instr(3 downto 0);
				-- Mem State
				selMem <= 'X';
				memWe <= '0';
				--WbState
				rfWe <= '1';
				rfWrDataSel <= '0';
				--REGISTERS BETWEEN STAGES
				we_IF_DEC_reg <= '1';
				we_DEC_IF_reg <= '1';
				we_DEC_EX_reg <= '1';
				we_EX_MEM_reg <= '1';
				we_MEM_WB_reg <= '1';
				--NextState
				nextState<= idle;
			when li =>
				--IFSTATE
				pcSel <= '0';
				pcLdEn <= '1';
				--DecState
				immedControl<="01"; 
				rfBSel <= 'X';
				--ExState
				aluBinSel <= '1';
				aluFunc <= "0000";
				-- Mem State
				selMem <= 'X';
				memWe <= '0';
				--WbState
				rfWe <= '1';
				rfWrDataSel <= '0';
				--REGISTERS BETWEEN STAGES
				we_IF_DEC_reg <= '1';
				we_DEC_IF_reg <= '1';
				we_DEC_EX_reg <= '1';
				we_EX_MEM_reg <= '1';
				we_MEM_WB_reg <= '1';
				--NextState
				nextState<= idle;
			when lui =>
				--IFSTATE
				pcSel <= '0';
				pcLdEn <= '1';
				--DecState
				immedControl<="10"; 
				rfBSel <= 'X';
				--ExState
				aluBinSel <= '1';
				aluFunc <= "0000";
				-- Mem State
				selMem <= 'X';
				memWe <= '0';
				--WbState
				rfWe <= '1';
				rfWrDataSel <= '0';
				--REGISTERS BETWEEN STAGES
				we_IF_DEC_reg <= '1';
				we_DEC_IF_reg <= '1';
				we_DEC_EX_reg <= '1';
				we_EX_MEM_reg <= '1';
				we_MEM_WB_reg <= '1';
				--NextState
				nextState<= idle;
			when addi =>
				--IFSTATE
				pcSel <= '0';
				pcLdEn <= '1';
				--DecState
				immedControl<="01"; 
				rfBSel <= 'X';
				--ExState
				aluBinSel <= '1';
				aluFunc <= "0000";
				-- Mem State
				selMem <= 'X';
				memWe <= '0';
				--WbState
				rfWe <= '1';
				rfWrDataSel <= '0';
				--REGISTERS BETWEEN STAGES
				we_IF_DEC_reg <= '1';
				we_DEC_IF_reg <= '1';
				we_DEC_EX_reg <= '1';
				we_EX_MEM_reg <= '1';
				we_MEM_WB_reg <= '1';
				--NextState
				nextState<= idle;
			when andi =>
				--IFSTATE
				pcSel <= '0';
				pcLdEn <= '1';
				--DecState
				immedControl<="00"; 
				rfBSel <= 'X';
				--ExState
				aluBinSel <= '1';
				aluFunc <= "0010";
				-- Mem State
				selMem <= 'X';
				memWe <= '0';
				--WbState
				rfWe <= '1';
				rfWrDataSel <= '0';
				--REGISTERS BETWEEN STAGES
				we_IF_DEC_reg <= '1';
				we_DEC_IF_reg <= '1';
				we_DEC_EX_reg <= '1';
				we_EX_MEM_reg <= '1';
				we_MEM_WB_reg <= '1';
				--NextState
				nextState<= idle;
			when ori =>
				--IFSTATE
				pcSel <= '0';
				pcLdEn <= '1';
				--DecState
				immedControl<="00"; 
				rfBSel <= 'X';
				--ExState
				aluBinSel <= '1';
				aluFunc <= "0011";
				-- Mem State
				selMem <= 'X';
				memWe <= '0';
				--WbState
				rfWe <= '1';
				rfWrDataSel <= '0';
				--REGISTERS BETWEEN STAGES
				we_IF_DEC_reg <= '1';
				we_DEC_IF_reg <= '1';
				we_DEC_EX_reg <= '1';
				we_EX_MEM_reg <= '1';
				we_MEM_WB_reg <= '1';
				--NextState
				nextState<= idle;
			when b => -- NOT SURE FOR  SIGNALS AFTER DEOCDE. X IN THE MOMEMNT MIGHT CHAGE LATER
				--IFSTATE
				pcSel <= '1';
				pcLdEn <= '1';
				--DecState
				immedControl<="11"; 
				rfBSel <= 'X';
				--ExState
				aluBinSel <= 'X';
				aluFunc <= "XXXX";
				-- Mem State
				selMem <= 'X';
				memWe <= 'X';
				--WbState
				rfWe <= 'X';
				rfWrDataSel <= 'X';
				--REGISTERS BETWEEN STAGES
				we_IF_DEC_reg <= '1';
				we_DEC_IF_reg <= '1';
				we_DEC_EX_reg <= '1';
				we_EX_MEM_reg <= '1';
				we_MEM_WB_reg <= '1';
				--NextState
				nextState<= idle;
			when beq => -- NOT SURE FOR SIGNALS AFTER EXEC
				--IFSTATE
				if zero = '1' then
					pcSel <= '1';
				else
					pcSel <= '0';
				end if;
				pcLdEn <= '1';
				--DecState
				immedControl<="11"; 
				rfBSel <= '1';
				--ExState
				aluBinSel <= '0';
				aluFunc <= "0001";
				-- Mem State
				selMem <= 'X';
				memWe <= 'X';
				--WbState
				rfWe <= 'X';
				rfWrDataSel <= 'X';
				--REGISTERS BETWEEN STAGES
				we_IF_DEC_reg <= '1';
				we_DEC_IF_reg <= '1';
				we_DEC_EX_reg <= '1';
				we_EX_MEM_reg <= '1';
				we_MEM_WB_reg <= '1';
				--NextState
				nextState<= idle;
			when bne =>-- NOT SURE FOR SIGNALS AFTER EXEC
				--IFSTATE
				if zero = '1' then
					pcSel <= '0';
				else
					pcSel <= '1';
				end if;
				pcLdEn <= '1';
				--DecState
				immedControl<="11"; 
				rfBSel <= '1';
				--ExState
				aluBinSel <= '0';
				aluFunc <= "0001";
				-- Mem State
				selMem <= 'X';
				memWe <= 'X';
				--WbState
				rfWe <= 'X';
				rfWrDataSel <= 'X';
				--REGISTERS BETWEEN STAGES
				we_IF_DEC_reg <= '1';
				we_DEC_IF_reg <= '1';
				we_DEC_EX_reg <= '1';
				we_EX_MEM_reg <= '1';
				we_MEM_WB_reg <= '1';
				--NextState
				nextState<= idle;
			when lb =>
				--IFSTATE
				pcSel <= '0';
				pcLdEn <= '1';
				--DecState
				immedControl<="01"; 
				rfBSel <= 'X';
				--ExState
				aluBinSel <= '1';
				aluFunc <= "0000";
				-- Mem State
				selMem <= '1';
				memWe <= '0';
				--WbState
				rfWe <= '1';
				rfWrDataSel <= '1';
				--REGISTERS BETWEEN STAGES
				we_IF_DEC_reg <= '1';
				we_DEC_IF_reg <= '1';
				we_DEC_EX_reg <= '1';
				we_EX_MEM_reg <= '1';
				we_MEM_WB_reg <= '1';
				--NextState
				nextState<= idle;
			when lw =>
				--IFSTATE
				pcSel <= '0';
				pcLdEn <= '1';
				--DecState
				immedControl<="01"; 
				rfBSel <= 'X';
				--ExState
				aluBinSel <= '1';
				aluFunc <= "0000";
				-- Mem State
				selMem <= '0';
				memWe <= '0';
				--WbState
				rfWe <= '1';
				rfWrDataSel <= '1';
				--REGISTERS BETWEEN STAGES
				we_IF_DEC_reg <= '1';
				we_DEC_IF_reg <= '1';
				we_DEC_EX_reg <= '1';
				we_EX_MEM_reg <= '1';
				we_MEM_WB_reg <= '1';
				--NextState
				nextState<= idle;
			when sw =>
				--IFSTATE
				pcSel <= '0';
				pcLdEn <= '1';
				--DecState
				immedControl<="01"; 
				rfBSel <= 'X';
				--ExState
				aluBinSel <= '1';
				aluFunc <= "0000";
				-- Mem State
				selMem <= 'X';
				memWe <= '1';
				--WbState
				rfWe <= '0';
				rfWrDataSel <= 'X';
				--REGISTERS BETWEEN STAGES
				we_IF_DEC_reg <= '1';
				we_DEC_IF_reg <= '1';
				we_DEC_EX_reg <= '1';
				we_EX_MEM_reg <= '1';
				we_MEM_WB_reg <= '1';
				--NextState
				nextState<= idle;
			when others => 
				pcSel <= '0';
				pcLdEn <= '0';
				-------------
				rfWe <= '0';
				rfWrDataSel <= '0';
				rfBSel <= '0';
				immedControl<="00"; 
				-------------
				aluBinSel <= '0'; 
				aluFunc <= "0000"; 
				------------
				memWe <= '0';	
				selMem <= 'X';
				nextState <= idle; --don't care just different from afterB
				--REGISTERS BETWEEN STAGES
				we_IF_DEC_reg <= '0';
				we_DEC_IF_reg <= '0';
				we_DEC_EX_reg <= '0';
				we_EX_MEM_reg <= '0';
				we_MEM_WB_reg <= '0';
			end case;
	end process;
end Behavioral;