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
type fsmStates is (IFState,IFBranch,
						DECImmedSE,DECImmedZF,DECImmedB,DECImmedU,DECRType,
						Exec_li_lui_addi,Exec_andi,Exec_ori,Exec_beq_bne_b_lb_lw_sw,ExecRtype,
						MEM_lb,MEM_sw,MEMIdle,
						WriteBackMEM,WriteBackALU,WriteBackSw,
						idle);
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
	
	
	changeState : process(clk,rst)
	begin
	if rst = '1' then
		state <= idle;
		--nextState <= IFState;
	else
		if(rising_edge(clk)) then
			if instr = X"00000000" then 
				state <= idle;
			else 
				state <= nextState;
			end if;
		end if;
	end if;
	end process;
	
	
	output: process(state,zero)
	begin
		case state is
		when IFState =>
			outSignal <= "X00100XXXXXXXXXX0";
			IF instr(31 downto 30) = "10" then
				nextState <= DECRType;
			elsif instr(31 downto 26) = "111000" or instr(31 downto 26) = "110000"
					or instr(31 downto 26) = "000011" or instr(31 downto 26) = "001111"
					or instr(31 downto 26) = "011111" then
				nextState <= DECImmedSE;
			elsif instr(31 downto 26) = "110010" or instr(31 downto 26) = "110011" then
				nextState <= DECImmedZF;
			elsif instr(31 downto 26) = "111001" then
				nextState <= DECImmedU;
			else 
				nextState <= DECImmedB;
			end if;
		when IFBranch => 
			outSignal <= "X01110XXXXXXXXXX0";
			IF instr(31 downto 30) = "10" then
				nextState <= DECRType;
			elsif instr(31 downto 26) = "111000" or instr(31 downto 26) = "110000"
					or instr(31 downto 26) = "000011" or instr(31 downto 26) = "001111"
					or instr(31 downto 26) = "011111" then
				nextState <= DECImmedSE;
			elsif instr(31 downto 26) = "110010" or instr(31 downto 26) = "110011" then
				nextState <= DECImmedZF;
			elsif instr(31 downto 26) = "111001" then
				nextState <= DECImmedU;
			else 
				nextState <= DECImmedB;
			end if;
		when DECRType =>
			outSignal <= "X1X000X0XXXXXXXX0";
			nextState <= ExecRtype;
		when DECImmedSE =>
			outSignal <= "X1X000X101XXXXXX0";
			if instr(31) = '1' then 
				nextState <= Exec_li_lui_addi;
			else
				nextState <= Exec_beq_bne_b_lb_lw_sw;
			end if;
		when DECImmedZF =>
			outSignal <= "X1X000X100XXXXXX0";
			--in this state is only the andi ori 
			if instr(26) = '0' then
				nextState <= Exec_andi;
			else 
				nextState <= Exec_ori;
			end if;
		when DECImmedU =>
			--in this state only lui
			outSignal <= "X1X000X110XXXXXX0";
			nextState <= Exec_li_lui_addi;
		when DECImmedB =>
			outSignal <= "X1X000X111XXXXXX0";
			if instr(31 downto 26)= "111111" then
				nextState <= IFBranch;
			else
				nextState <= Exec_beq_bne_b_lb_lw_sw;
			end if;
		WHEN ExecRtype =>
			outSignal<= "10X000XXXX0" & instr(3 downto 0) & "X0";
			nextState<= MEMIdle;
		WHEN Exec_li_lui_addi=>
			outSignal<="10X000XXXX10000X0";
			nextState<= MEMIdle;
		WHEN Exec_andi=>
			outSignal<="10X000XXXX10010X0";
			nextState<= MEMIdle;
		WHEN Exec_ori=>
			outSignal<="10X000XXXX10011X0";
			nextState<= MEMIdle;
		WHEN Exec_beq_bne_b_lb_lw_sw=>
			outSignal<="10X000XXXX00001X0";
			if instr(31 downto 26)="010000" then --beq
				if Zero ='0' then
					nextState<= IFBranch;
				else
				nextState<= IFState;
				end if;
			elsif instr(31 downto 26)="010001" then-- bne
				if Zero /='0' then
					nextState<= IFBranch;
				else
				nextState<= IFState;
				end if;
			elsif (instr(31 downto 26)="000011") then --lb
			  nextState<= MEM_lb;
			elsif (instr(31 downto 26)="001111") then --sw
			  nextState<= MEM_sw;
			else --lw
			  nextState<= MEMIdle;
			end if;
		WHEN MEM_lb=>
			outSignal<="00X000XXXXXXXXX10";
			nextState<=WriteBackMEM;
		WHEN MEM_sw=>
			outSignal<="00X000XXXXXXXXXX1";
			nextState<=WriteBackSw;
		WHEN MEMIdle =>
			outSignal<="00X000XXXXXXXXX00";
			nextState<=WriteBackALU;
			
		WHEN WriteBackALU =>
			outSignal <= "00X0010XXXXXXXXX0";
			--------------NEXT STATE
			nextState <= IFState;
		when WriteBackMEM =>
			outSignal <= "00X0011XXXXXXXXX0";
			--------------NEXT STATE
			nextState <= IFState;
		when WriteBackSw =>
			outSignal <= "00X000XXXXXXXXXX0";
			nextState <= IFState;
		WHEN OTHERS=>
			outSignal <= "00X000XXXXXXXXXX0";
			nextState <= IFState;
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