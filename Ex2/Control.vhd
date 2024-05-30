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
				rst : in  STD_LOGIC;
				clk: in STD_LOGIC;
				immedControl: out STD_LOGIC_VECTOR(1 downto 0);
				selMem : out std_logic;
				selBranch : out std_logic;
				weImmed: out std_logic;
				weAluOut: out std_logic;
				we_Reg_A:out std_logic;
				we_Reg_B:out std_logic;
				we_mem_to_wb:out std_logic;
				we_Reg_to_Dec:out std_logic);
end Control;

architecture Behavioral of Control is
type fsmStates is (IFState,IFBranch,
						DECImmedSE,DECImmedZF,DECImmedB,DECImmedU,DECRType,
						Exec_li_lui_addi,Exec_andi,Exec_ori,Exec_beq_bne_lb_lw_sw,ExecRtype,
						MEM_load,MEM_sw,
						WriteBackMEM,WriteBackALU,WriteBackSw,
						b,bne_beq);
--type fsmStates is (rtype,li,lui,addi,andi,ori,b,beq,bne,lb,lw,sb,sw,idle,afterB);
signal state,nextState : fsmStates;


begin

	process
		begin
			wait until clk'EVENT and clk='1';
			if rst = '1' then
				state <= IFState;
			else 
				state <= nextState;
			end if;
	end process;
	
	
	 changeState: process(instr(31 downto 26),instr(3 downto 0), state)
    begin
        nextState <= IFState;
        case(state) is
            when IFState =>
                case(instr(31 downto 26)) is
                    when "100000"=> --r_type
                        nextState <= DECRType;
                    when "111000" | "110000" | "000011" | "001111" | "011111" => --li, addi, lb, lw, sw
                        nextState <= DECImmedSE;
                    when "110010" | "110011" => -- andi, ori
                        nextState <= DECImmedZF;
                    when "111001" => -- lui
                        nextState <= DECImmedU;
                    when "010000" | "010001" | "111111" =>
                        nextState <= DECImmedB;-- branches
                    when others =>
                        nextState <= IFState;
                end case;
				when DECRType =>
                nextState <= ExecRtype;
				when DECImmedSE =>
                case(instr(31 downto 26)) is
                    when "111000" | "110000" => --li, lui
                        nextState <= Exec_li_lui_addi;
                    when "000011" | "001111" | "011111" =>
                        nextState <= Exec_beq_bne_lb_lw_sw;
                    when others =>
                        nextState <= IFState;
                end case;
				when DECImmedU =>
                nextState <= Exec_li_lui_addi;
            when DECImmedB =>
                case(instr(31 downto 26)) is
                    when "111111" => -- b
                        nextState <= b;
                    when "010000" | "010001" =>
                        nextState <= Exec_beq_bne_lb_lw_sw;
							when others=>
								nextState<=IFState;
                end case;
            when DECImmedZF =>
                case(instr(31 downto 26)) is
                    when "110010" =>
                        nextState <= Exec_andi;
                    when "110011" =>
                        nextState <= Exec_ori;
                    when others =>
                        nextState <= IFState;
                end case;
            when ExecRtype | Exec_andi | Exec_ori | Exec_li_lui_addi =>
                nextState <= WriteBackALU;
            when Exec_beq_bne_lb_lw_sw =>
                case(instr(31 downto 26)) is
                    when "000011" | "001111" => -- lb, lw
                        nextState <= MEM_load;
                    when "011111" => -- sw
                        nextState <= MEM_sw;
                    when "010000" | "010001" => -- beq, bne
                        nextState <= IFState;
                    when others =>
                        nextState <= IFState;
                end case;
            when MEM_load =>
                nextState <= WriteBackMEM;
            when MEM_sw =>
                nextState <= IFState;
            when WriteBackALU | WriteBackMEM=>
                nextState <= IFState;
				when b=>
					nextState<=IFState;
				when bne_beq=>
					nextState<=IFState;
            when others =>
                nextState <= IFState;
        end case;
    end process;


	
	output: process(state,zero,instr(31 downto 26),instr(3 downto 0))
	begin
		case state is
		WHEN IFState =>
			
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '1'; --wirte to pc
			we_Reg_to_Dec<='1'; --write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; -- no write in rf
			rfWrDataSel <= '0';--read drom alu
			rfBSel <= 'X';--set rt(no use here)
			immedControl<= "XX";--modify immed(no use here)
			weImmed <='0';-- dont write to immed reg
			we_Reg_A<='0';--dont write to regA
			we_Reg_B<='0';--dont write to regB
			---------------
			aluBinSel <= '0';-- choose rfB
			aluFunc <= "0000";--alu func
			weAluOut <= '0';--no write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';--dont store 
			we_mem_to_wb<='0';--dont write to meme reg
		when DECRType =>
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '0'; --dont wirte to pc
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; -- no write in rf
			rfWrDataSel <= 'X';--read drom alu
			rfBSel <= '0';--set rt(no use here)
			immedControl<= "XX";--modify immed(no use here)
			weImmed <='0';-- dont write to immed reg
			we_Reg_A<='1';--dont write to regA
			we_Reg_B<='1';--dont write to regB
			---------------
			aluBinSel <= '0';-- choose rfB
			aluFunc <= "0000";--alu func
			weAluOut <= '0';--no write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';--dont store 
			we_mem_to_wb<='0';--dont write to meme reg
		when DECImmedSE =>
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '0'; --dont wirte to pc
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; -- no write in rf
			rfWrDataSel <= 'X';--dont care
			rfBSel <= '1';--set rt
			immedControl<= "01";--modify immed(no use here)
			weImmed <='1';-- dont write to immed reg
			we_Reg_A<='1';--dont write to regA
			we_Reg_B<='1';--dont write to regB
			---------------
			aluBinSel <= '1';-- choose immed
			aluFunc <= "0000";--alu func
			weAluOut <= '0';--no write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';--dont store 
			we_mem_to_wb<='0';--dont write to meme reg
		when DECImmedZF =>
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '0'; --dont wirte to pc
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; -- no write in rf
			rfWrDataSel <= 'X'; --dont care
			rfBSel <= '1';--set rt
			immedControl<= "00";--modify immed(no use here)
			weImmed <='1';-- dont write to immed reg
			we_Reg_A<='1';--dont write to regA
			we_Reg_B<='1';--dont write to regB
			---------------
			aluBinSel <= '1';-- choose immed
			aluFunc <= "0000";--alu func
			weAluOut <= '0';--no write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';--dont store 
			we_mem_to_wb<='0';--dont write to meme reg
		when DECImmedU =>
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '0'; --dont wirte to pc
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; -- no write in rf
			rfWrDataSel <= 'X'; --dont care
			rfBSel <= '1';--set rt
			immedControl<= "10";--modify immed(no use here)
			weImmed <='1';-- dont write to immed reg
			we_Reg_A<='1';--dont write to regA
			we_Reg_B<='1';--dont write to regB
			---------------
			aluBinSel <= '1';-- choose immed
			aluFunc <= "0000";--alu func
			weAluOut <= '0';--no write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';--dont store 
			we_mem_to_wb<='0';--dont write to meme reg
		when DECImmedB =>
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '0'; --dont wirte to pc
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; -- no write in rf
			rfWrDataSel <= 'X'; --dont care
			rfBSel <= '1';--set rt
			immedControl<= "11";--modify immed(no use here)
			weImmed <='1';-- dont write to immed reg
			we_Reg_A<='1';--dont write to regA
			we_Reg_B<='1';--dont write to regB
			---------------
			aluBinSel <= '1';-- choose immed
			aluFunc <= "0000";--alu func
			weAluOut <= '0';--no write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';--dont store 
			we_mem_to_wb<='0';--dont write to meme reg
		WHEN ExecRtype =>
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '0'; --dont wirte to pc
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; -- no write in rf
			rfWrDataSel <= 'X'; --dont care
			rfBSel <= 'X';--set rt
			immedControl<= "XX";--modify immed(no use here)
			weImmed <='0';-- dont write to immed reg
			we_Reg_A<='0';--dont write to regA
			we_Reg_B<='0';--dont write to regB
			---------------
			aluBinSel <= '0';-- choose rfB
			aluFunc <= instr(3 downto 0);--alu func
			weAluOut <= '1';-- write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';--dont store 
			we_mem_to_wb<='0';--dont write to meme reg
		WHEN Exec_li_lui_addi=>
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '0'; --dont wirte to pc
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; -- no write in rf
			rfWrDataSel <= 'X'; --dont care
			rfBSel <= 'X';--set rt
			immedControl<= "XX";--modify immed(no use here)
			weImmed <='0';-- dont write to immed reg
			we_Reg_A<='0';--dont write to regA
			we_Reg_B<='0';--dont write to regB
			---------------
			aluBinSel <= '1';-- choose immed
			aluFunc <= "0000";--alu func
			weAluOut <= '1';--write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';--dont store 
			we_mem_to_wb<='0';--dont write to meme reg
		WHEN Exec_andi=>
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '0'; --dont wirte to pc
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; -- no write in rf
			rfWrDataSel <= 'X'; --dont care
			rfBSel <= 'X';--set rt
			immedControl<= "XX";--modify immed(no use here)
			weImmed <='0';-- dont write to immed reg
			we_Reg_A<='0';--dont write to regA
			we_Reg_B<='0';--dont write to regB
			---------------
			aluBinSel <= '1';-- choose immed
			aluFunc <= "0010";--alu func
			weAluOut <= '1';-- write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';--dont store 
			we_mem_to_wb<='0';--dont write to meme reg
		WHEN Exec_ori=>
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '0'; --dont wirte to pc
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; -- no write in rf
			rfWrDataSel <= 'X'; --dont care
			rfBSel <= 'X';--set rt
			immedControl<= "XX";--modify immed(no use here)
			weImmed <='0';-- dont write to immed reg
			we_Reg_A<='0';--dont write to regA
			we_Reg_B<='0';--dont write to regB
			---------------
			aluBinSel <= '1';-- choose immed
			aluFunc <= "0011";--alu func
			weAluOut <= '1'; --write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';--dont store 
			we_mem_to_wb<='0';--dont write to meme reg
		WHEN Exec_beq_bne_lb_lw_sw=>
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '0'; --dont wirte to pc
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; -- no write in rf
			rfWrDataSel <= 'X'; --dont care
			rfBSel <= 'X';--set rt
			immedControl<= "XX";--modify immed(no use here)
			weImmed <='0';-- dont write to immed reg
			we_Reg_A<='0';--dont write to regA
			we_Reg_B<='0';--dont write to regB
			---------------
			aluBinSel <= '0';-- choose rfB
			aluFunc <= "0001";--alu func
			weAluOut <= '1';-- write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';--dont store 
			we_mem_to_wb<='0';--dont write to meme reg
		WHEN b=>
			pcSel <= '1'; -- pc + 4 + immed
			pcLdEn <= '1'; --dont wirte to pc
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; -- no write in rf
			rfWrDataSel <= 'X'; --dont care
			rfBSel <= 'X';--set rt
			immedControl<= "XX";--modify immed(no use here)
			weImmed <='0';-- dont write to immed reg
			we_Reg_A<='0';--dont write to regA
			we_Reg_B<='0';--dont write to regB
			---------------
			aluBinSel <= '0';-- choose rfB
			aluFunc <= "0000";--alu func
			weAluOut <= '0';-- write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';--dont store 
			we_mem_to_wb<='0';--dont write to meme reg
		WHEN bne_beq=>
			pcSel <= instr(26) xor Zero; -- pc+4 or pc + 4 + immed
			pcLdEn <= instr(26) xor Zero;
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; -- no write in rf
			rfWrDataSel <= 'X'; --dont care
			rfBSel <= 'X';--set rt
			immedControl<= "XX";--modify immed(no use here)
			weImmed <='0';-- dont write to immed reg
			we_Reg_A<='0';--dont write to regA
			we_Reg_B<='0';--dont write to regB
			---------------
			aluBinSel <= '0';-- choose rfB
			aluFunc <= "0000";--alu func
			weAluOut <= '0';-- write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';--dont store 
			we_mem_to_wb<='0';--dont write to mem reg
		WHEN MEM_load=>
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '0'; --dont wirte to pc
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; -- no write in rf
			rfWrDataSel <= 'X'; --dont care
			rfBSel <= 'X';--set rt
			immedControl<= "XX";--modify immed(no use here)
			weImmed <='0';-- dont write to immed reg
			we_Reg_A<='0';--dont write to regA
			we_Reg_B<='0';--dont write to regB
			---------------
			aluBinSel <= 'X';-- choose immed
			aluFunc <= "XXXX";--alu func
			weAluOut <= '0';--no write to alu reg
			--------------
			selMem <= not instr(28);--choose lw or lb
			memWe <= '0';--dont store 
			we_mem_to_wb<='1';-- write to mem reg
		WHEN MEM_sw=>
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '0'; --dont wirte to pc
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; -- no write in rf
			rfWrDataSel <= 'X'; --dont care
			rfBSel <= 'X';--set rt
			immedControl<= "XX";--modify immed(no use here)
			weImmed <='0';-- dont write to immed reg
			we_Reg_A<='0';--dont write to regA
			we_Reg_B<='0';--dont write to regB
			---------------
			aluBinSel <= 'X';-- choose immed
			aluFunc <= "XXXX";--alu func
			weAluOut <= '0';--no write to alu reg
			--------------
			selMem <='0';--no use
			memWe <= '1';-- store 
			we_mem_to_wb<='1';-- write to meme reg
		WHEN WriteBackALU =>
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '0'; --dont wirte to pc
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '1'; --  write in rf
			rfWrDataSel <= '0'; --choose from alu
			rfBSel <= 'X';--set rt
			immedControl<= "XX";--modify immed(no use here)
			weImmed <='0';-- dont write to immed reg
			we_Reg_A<='0';--dont write to regA
			we_Reg_B<='0';--dont write to regB
			---------------
			aluBinSel <= 'X';-- choose immed
			aluFunc <= "XXXX";--alu func
			weAluOut <= '0';--no write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';-- store 
			we_mem_to_wb<='0';-- write to meme reg
		when WriteBackMEM =>
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '0'; --dont wirte to pc
			we_Reg_to_Dec<='0'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '1'; --  write in rf
			rfWrDataSel <= '1'; --choose from alu
			rfBSel <= 'X';--set rt
			immedControl<= "XX";--modify immed(no use here)
			weImmed <='0';-- dont write to immed reg
			we_Reg_A<='0';--dont write to regA
			we_Reg_B<='0';--dont write to regB
			---------------
			aluBinSel <= 'X';-- choose immed
			aluFunc <= "XXXX";--alu func
			weAluOut <= '0';--no write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';-- store 
			we_mem_to_wb<='0';-- write to meme reg
		WHEN OTHERS=>
			pcSel <= '0'; -- pc + 4
			pcLdEn <= '1'; --wirte to pc
			we_Reg_to_Dec<='1'; --dont write instr to reg
			--selBranch <= 
			----------------
			rfWe <= '0'; --  write in rf
			rfWrDataSel <= '0'; --choose from alu
			rfBSel <= 'X';--set rt
			immedControl<= "XX";--modify immed(no use here)
			weImmed <='0';-- dont write to immed reg
			we_Reg_A<='0';--dont write to regA
			we_Reg_B<='0';--dont write to regB
			---------------
			aluBinSel <= 'X';-- choose immed
			aluFunc <= "XXXX";--alu func
			weAluOut <= '0';--no write to alu reg
			--------------
			selMem <='X';--no use
			memWe <= '0';-- store 
			we_mem_to_wb<='0';-- write to meme reg
		END CASE;
			
end process;

end Behavioral;
