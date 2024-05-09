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
			selMem : out std_logic);
end Control;

architecture Behavioral of Control is
type fsmStates is (rtype,li,lui,addi,andi,ori,b,beq,bne,lb,lw,sb,sw,idle,afterB);
signal state,nextState : fsmStates;

begin
	findState : process(instr,clk)
	begin
	if rst = '1' then
			state <= idle;
	else 
		case nextState is
		when afterB => state <= afterB;
		when others =>
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
		end case;
	end if;
	end process;
	
	
	output: process(state,zero)
	begin
		case state is
			when idle =>
				pcSel <= '0';
				pcLdEn <= '1';
				--------------
				rfWe <= '0';
				rfWrDataSel <= '0';
				rfBSel <= '0';
				immedControl<="XX"; --not in use
				--------------
				memWe <= '0';
				selMem <= 'X';
				--------------
				aluBinSel <= '0';
				aluFunc <= "0000";
				nextState <= idle; --don't care just different from afterB
			when rtype => 
				pcSel <= '0';
				pcLdEn <= '1';
				-------------
				rfWe <= '1';
				rfWrDataSel <= '0';
				immedControl<="XX"; --not in use
				rfBSel <= '0';
				--------------
				aluBinSel <= '0';
				aluFunc <= instr(3 downto 0);
				--------------
				memWe <= '0';
				selMem <= 'X';
				nextState <= idle; --don't care just different from afterB
			when li =>
				pcSel <= '0';
				pcLdEn <= '1';
				-------------
				rfWe <= '1';
				rfWrDataSel <= '0';
				rfBSel <= '1';
				immedControl<="01"; --sign extension
				-------------
				aluBinSel <= '1'; --choose immed
				aluFunc <= "0000"; --rd +immed
				-------------
				memWe <= '0';
				selMem <= 'X';
				nextState <= idle; --don't care just different from afterB
			when lui =>
				pcSel <= '0';
				pcLdEn <= '1';
				-------------
				rfWe <= '1';
				rfWrDataSel <= '0';
				rfBSel <= '1';
				immedControl<="10"; 
				-------------
				aluBinSel <= '1'; 
				aluFunc <= "0000"; 
				-------------
				memWe <= '0';
				selMem <= 'X';
				nextState <= idle; --don't care just different from afterB
			when addi =>
				pcSel <= '0';
				pcLdEn <= '1';
				-------------
				rfWe <= '1';
				rfWrDataSel <= '0';
				rfBSel <= '1';
				immedControl<="01"; --sign extension
				-------------
				aluBinSel <= '1'; --choose immed
				aluFunc <= "0000"; --rd +immed
				-------------
				memWe <= '0';
				selMem <= 'X';
				nextState <= idle; --don't care just different from afterB
			when andi =>
				pcSel <= '0';
				pcLdEn <= '1';
				-------------
				rfWe <= '1';
				rfWrDataSel <= '0';
				rfBSel <= '1';
				immedControl<="00"; 
				-------------
				aluBinSel <= '1'; 
				aluFunc <= "0010"; 
				-------------
				memWe <= '0';
				selMem <= 'X';
				nextState <= idle; --don't care just different from afterB
			when ori =>
				pcSel <= '0';
				pcLdEn <= '1';
				-------------
				rfWe <= '1';
				rfWrDataSel <= '0';
				rfBSel <= '1';
				immedControl<="00"; 
				-------------
				aluBinSel <= '1'; 
				aluFunc <= "0011"; 
				memWe <= '0';
				selMem <= 'X';
				nextState <= idle; --don't care just different from afterB
			when b =>
				pcSel <= '1';
				pcLdEn <= '1';
				-------------
				rfWe <= '0';
				rfWrDataSel <= 'X';
				rfBSel <= '1';
				immedControl<="11"; 
				-------------
				aluBinSel <= 'X'; 
				aluFunc <= "XXXX"; 
				------------
				memWe <= '0';
				selMem <= 'X';
				nextState <= afterB; 
			when beq =>
				if zero = '1' then
					pcSel <= '1';
					nextState <= afterB;
				else
					pcSel <= '0';
					nextState <= idle;--don't care just different from afterB
				end if;
				pcLdEn <= '1';
				-------------
				rfWe <= '0';
				rfWrDataSel <= 'X';
				rfBSel <= '1';
				immedControl<="11"; 
				-------------
				aluBinSel <= '0'; 
				aluFunc <= "0001"; 
				------------
				memWe <= '0';
				selMem <= 'X';
			when bne =>
				if zero = '1' then
					pcSel <= '0';
					nextState <= idle; --don't care just different from afterB
				else
					pcSel <= '1';
					nextState <= afterB;
				end if;
				pcLdEn <= '1';
				-------------
				rfWe <= '0';
				rfWrDataSel <= 'X';
				rfBSel <= '1';
				immedControl<="11";
				-------------
				aluBinSel <= '0'; 
				aluFunc <= "0001"; 
				------------
				memWe <= '0';
				selMem <= 'X';
			when lb =>
				pcSel <= '0';
				pcLdEn <= '1';
				-------------
				rfWe <= '1';
				rfWrDataSel <= '1';
				rfBSel <= '1';
				immedControl<="01";
				-------------
				aluBinSel <= 'X'; 
				aluFunc <= "XXXX"; 
				------------
				memWe <= '0';	
				selMem <= '0';
				nextState <= idle; --don't care just different from afterB
			when lw =>
				pcSel <= '0';
				pcLdEn <= '1';
				-------------
				rfWe <= '1';
				rfWrDataSel <= '1';
				rfBSel <= '1';
				immedControl<="01"; 
				-------------
				aluBinSel <= 'X'; 
				aluFunc <= "XXXX"; 
				------------
				memWe <= '0';	
				selMem <= 'X';
				nextState <= idle; --don't care just different from afterB
			when sb | sw =>
				pcSel <= '0';
				pcLdEn <= '1';
				-------------
				rfWe <= '0';
				rfWrDataSel <= 'X';
				rfBSel <= '1';
				immedControl<="01"; --sign extension
				-------------
				aluBinSel <= '1'; --choose immed
				aluFunc <= "0000"; -- no use
				------------
				memWe <= '1';
				selMem <= 'X';
				nextState <= idle; --don't care just different from afterB
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
			end case;
	end process;
end Behavioral;