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
			selBranch : out std_logic;
			weImmed: out std_logic;
			weAluOut: out std_logic);
end Control;

architecture Behavioral of Control is
type fsmStates is (IFState,IFBranch,DECImmed,DECRType,ExecImmed,ExecRtype,MEM,MEMIdle,WriteBackMEM,WriteBackALU);
--type fsmStates is (rtype,li,lui,addi,andi,ori,b,beq,bne,lb,lw,sb,sw,idle,afterB);
signal state,nextState : fsmStates;
signal outSignal : std_logic_vector(16 downto 0);

begin
	weAluOut <= outSignal(16);
	weImmed <= outSignal(15);
	pcSel <= outSignal(14);
	pcLdEn <= outSignal(13);
	selBranch <= outSignal(12);
	rfWe <= outSignal(11);
	rfWrDataSel <= outSignal(10);
	rfBSel <= outSignal(9);
	immedControl<= outSignal(8 downto 7);
	selMem <= outSignal(6);
	aluBinSel <= outSignal(5);
	aluFunc <= outSignal(4 downto 1);
	memWe <= outSignal(0);
	
	
	findState : process(clk)
	begin
	if rst = '1' then
		state <= IFState;
	elsif instr = X"00000000" then 
		state <= IFState;
	else 
		state <= nextState;
	end if;
	end process;
	
	
	output: process(state,zero)
	begin
		case state is
		when IFState =>
			outSignal <= ""
			IF instr(31 downto 30) = "10" then
				nextState <= DECRType;
			else 
				nextState <= DECImmed;
			end if;
		when IFBranch => 
			pcSel <= '1';
			pcLdEn <= '1';
			--------------NOT IN USE DEC
			rfWe <= '0';
			rfWrDataSel <= 'X';
			rfBSel <= 'X';
			immedControl<="XX";
			selMem <= 'X';
			--------------NOT IN USE ALU
			aluBinSel <= 'X';
			aluFunc <= "XXXX";
			--------------NOT IN USE MEM
			memWe <= '0';
			--------------NEXT STATE
			IF instr(31 downto 30) = "10" then
				nextState <= DECRType;
			else 
				nextState <= DECImmed;
			end if;
		when DECRType =>
			-------------NOT IN USE IF
			pcSel <= 'X';
			pcLdEn <= '0';
			--------------USE DEC
			rfWe <= '0';			--WRITE DISABLE
			rfWrDataSel <= 'X';	--NOT IN USE
			rfBSel <= '0';			--R TYPE			
			immedControl<="XX";	--NOT IN USE
			selMem <= 'X';			--NOT IN USE
			--------------NOT IN USE ALU
			aluBinSel <= 'X';
			aluFunc <= "XXXX";
			--------------NOT IN USE MEM
			memWe <= '0';
			--------------NEXT STATE
			nextState <= ExecRtype;
		WHEN ExecRtype =>
			-------------NOT IN USE IF
			pcSel <= 'X';
			pcLdEn <= '0';
			--------------NOT IN USE DEC
			rfWe <= '0';
			rfWrDataSel <= 'X';
			rfBSel <= 'X';						
			immedControl<="XX";	
			selMem <= 'X';			
			--------------USE ALU
			aluBinSel <= '0';
			aluFunc <= instr(3 downto 0);
			--------------NOT IN USE MEM
			memWe <= '0';
			--------------NEXT STATE
			nextState <= MEMIdle;
		WHEN MEMIdle =>
			-------------NOT IN USE IF
			pcSel <= 'X';
			pcLdEn <= '0';
			--------------NOT IN USE DEC
			rfWe <= '0';
			rfWrDataSel <= 'X';
			rfBSel <= 'X';						
			immedControl<="XX";	
			selMem <= 'X';			
			--------------NOT IN USE ALU
			aluBinSel <= 'X';
			aluFunc <= "XXXX";
			--------------NOT IN USE MEM
			memWe <= '0';
			--------------NEXT STATE
			nextState <= WriteBackALU;
		WHEN WriteBackALU =>
			-------------NOT IN USE IF
			pcSel <= 'X';
			pcLdEn <= '0';
			--------------USE DEC
			rfWe <= '1';				--WRITE ENABLE
			rfWrDataSel <= 'X';		--NOT IN USE
			rfBSel <= '0';				--ALU WRITE BACK						
			immedControl<="XX";		--NOT IN USE
			selMem <= 'X';				--NOT IN USE
			--------------NOT IN USE ALU
			aluBinSel <= 'X';
			aluFunc <= "XXXX";
			--------------NOT IN USE MEM
			memWe <= '0';
			--------------NEXT STATE
			nextState <= IFState;
		WHEN OTHERS=>
		END CASE;
			
--			when idle =>
--				pcSel <= '0';
--				pcLdEn <= '1';
--				--------------
--				rfWe <= '0';
--				rfWrDataSel <= '0';
--				rfBSel <= '0';
--				immedControl<="XX"; --not in use
--				--------------
--				memWe <= '0';
--				selMem <= 'X';
--				--------------
--				aluBinSel <= '0';
--				aluFunc <= "0000";
--				nextState <= idle; --don't care just different from afterB
--			when rtype => 
--				pcSel <= '0';
--				pcLdEn <= '1';
--				-------------
--				rfWe <= '1';
--				rfWrDataSel <= '0';
--				immedControl<="XX"; --not in use
--				rfBSel <= '0';
--				--------------
--				aluBinSel <= '0';
--				aluFunc <= instr(3 downto 0);
--				--------------
--				memWe <= '0';
--				selMem <= 'X';
--				nextState <= idle; --don't care just different from afterB
--			when li =>
--				pcSel <= '0';
--				pcLdEn <= '1';
--				-------------
--				rfWe <= '1';
--				rfWrDataSel <= '0';
--				rfBSel <= '1';
--				immedControl<="01"; --sign extension
--				-------------
--				aluBinSel <= '1'; --choose immed
--				aluFunc <= "0000"; --rd +immed
--				-------------
--				memWe <= '0';
--				selMem <= 'X';
--				nextState <= idle; --don't care just different from afterB
--			when lui =>
--				pcSel <= '0';
--				pcLdEn <= '1';
--				-------------
--				rfWe <= '1';
--				rfWrDataSel <= '0';
--				rfBSel <= '1';
--				immedControl<="10"; 
--				-------------
--				aluBinSel <= '1'; 
--				aluFunc <= "0000"; 
--				-------------
--				memWe <= '0';
--				selMem <= 'X';
--				nextState <= idle; --don't care just different from afterB
--			when addi =>
--				pcSel <= '0';
--				pcLdEn <= '1';
--				-------------
--				rfWe <= '1';
--				rfWrDataSel <= '0';
--				rfBSel <= '1';
--				immedControl<="01"; --sign extension
--				-------------
--				aluBinSel <= '1'; --choose immed
--				aluFunc <= "0000"; --rd +immed
--				-------------
--				memWe <= '0';
--				selMem <= 'X';
--				nextState <= idle; --don't care just different from afterB
--			when andi =>
--				pcSel <= '0';
--				pcLdEn <= '1';
--				-------------
--				rfWe <= '1';
--				rfWrDataSel <= '0';
--				rfBSel <= '1';
--				immedControl<="00"; 
--				-------------
--				aluBinSel <= '1'; 
--				aluFunc <= "0010"; 
--				-------------
--				memWe <= '0';
--				selMem <= 'X';
--				nextState <= idle; --don't care just different from afterB
--			when ori =>
--				pcSel <= '0';
--				pcLdEn <= '1';
--				-------------
--				rfWe <= '1';
--				rfWrDataSel <= '0';
--				rfBSel <= '1';
--				immedControl<="00"; 
--				-------------
--				aluBinSel <= '1'; 
--				aluFunc <= "0011"; 
--				memWe <= '0';
--				selMem <= 'X';
--				nextState <= idle; --don't care just different from afterB
--			when b =>
--				pcSel <= '1';
--				pcLdEn <= '1';
--				-------------
--				rfWe <= '0';
--				rfWrDataSel <= 'X';
--				rfBSel <= '1';
--				immedControl<="11"; 
--				-------------
--				aluBinSel <= 'X'; 
--				aluFunc <= "XXXX"; 
--				------------
--				memWe <= '0';
--				selMem <= 'X';
--				nextState <= afterB; 
--			when beq =>
--				if zero = '1' then
--					pcSel <= '1';
--					nextState <= afterB;
--				else
--					pcSel <= '0';
--					nextState <= idle;--don't care just different from afterB
--				end if;
--				pcLdEn <= '1';
--				-------------
--				rfWe <= '0';
--				rfWrDataSel <= 'X';
--				rfBSel <= '1';
--				immedControl<="11"; 
--				-------------
--				aluBinSel <= '0'; 
--				aluFunc <= "0001"; 
--				------------
--				memWe <= '0';
--				selMem <= 'X';
--			when bne =>
--				if zero = '1' then
--					pcSel <= '0';
--					nextState <= idle; --don't care just different from afterB
--				else
--					pcSel <= '1';
--					nextState <= afterB;
--				end if;
--				pcLdEn <= '1';
--				-------------
--				rfWe <= '0';
--				rfWrDataSel <= 'X';
--				rfBSel <= '1';
--				immedControl<="11";
--				-------------
--				aluBinSel <= '0'; 
--				aluFunc <= "0001"; 
--				------------
--				memWe <= '0';
--				selMem <= 'X';
--			when lb =>
--				pcSel <= '0';
--				pcLdEn <= '1';
--				-------------
--				rfWe <= '1';
--				rfWrDataSel <= '1';
--				rfBSel <= '1';
--				immedControl<="01";
--				-------------
--				aluBinSel <= 'X'; 
--				aluFunc <= "XXXX"; 
--				------------
--				memWe <= '0';	
--				selMem <= '0';
--				nextState <= idle; --don't care just different from afterB
--			when lw =>
--				pcSel <= '0';
--				pcLdEn <= '1';
--				-------------
--				rfWe <= '1';
--				rfWrDataSel <= '1';
--				rfBSel <= '1';
--				immedControl<="01"; 
--				-------------
--				aluBinSel <= 'X'; 
--				aluFunc <= "XXXX"; 
--				------------
--				memWe <= '0';	
--				selMem <= 'X';
--				nextState <= idle; --don't care just different from afterB
--			when sb | sw =>
--				pcSel <= '0';
--				pcLdEn <= '1';
--				-------------
--				rfWe <= '0';
--				rfWrDataSel <= 'X';
--				rfBSel <= '1';
--				immedControl<="01"; --sign extension
--				-------------
--				aluBinSel <= '1'; --choose immed
--				aluFunc <= "0000"; -- no use
--				------------
--				memWe <= '1';
--				selMem <= 'X';
--				nextState <= idle; --don't care just different from afterB
--			when others => 
--				pcSel <= '0';
--				pcLdEn <= '0';
--				-------------
--				rfWe <= '0';
--				rfWrDataSel <= '0';
--				rfBSel <= '0';
--				immedControl<="00"; 
--				-------------
--				aluBinSel <= '0'; 
--				aluFunc <= "0000"; 
--				------------
--				memWe <= '0';	
--				selMem <= 'X';
--				nextState <= idle; --don't care just different from afterB
--			end case;
	end process;
end Behavioral;