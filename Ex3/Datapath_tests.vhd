--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:24:09 04/25/2024
-- Design Name:   
-- Module Name:   /home/ise/Organosi/Ex1V3/DataPathTestCorrect.vhd
-- Project Name:  Ex1V3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Datapath
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Datapath_tests IS
END Datapath_tests;
 
ARCHITECTURE behavior OF Datapath_tests IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Datapath
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         pcSel : IN  std_logic;
         pcLdEn : IN  std_logic;
         RFWe : IN  std_logic;
         RFWrData : IN  std_logic;
         RF_B_sel : IN  std_logic;
         WeMem : IN  std_logic;
         ALU_Bin_sel : IN  std_logic;
         ALU_Func : IN  std_logic_vector(3 downto 0);
         Zero : OUT  std_logic;
         Ovf : OUT  std_logic;
         Cout : OUT  std_logic;
         ImmedControl : IN  std_logic_vector(1 downto 0);
         instr : OUT  std_logic_vector(31 downto 0);
			selMem : in std_logic);
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal pcSel : std_logic := '0';
   signal pcLdEn : std_logic := '0';
   signal RFWe : std_logic := '0';
   signal RFWrData : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal WeMem : std_logic := '0';
   signal ALU_Bin_sel : std_logic := '0';
   signal ALU_Func : std_logic_vector(3 downto 0) := (others => '0');
   signal ImmedControl : std_logic_vector(1 downto 0) := (others => '0');
	signal selMem:std_logic:= '0';
 	--Outputs
   signal Zero : std_logic;
   signal Ovf : std_logic;
   signal Cout : std_logic;
   signal instr : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Datapath PORT MAP (
          clk => clk,
          rst => rst,
          pcSel => pcSel,
          pcLdEn => pcLdEn,
          RFWe => RFWe,
          RFWrData => RFWrData,
          RF_B_sel => RF_B_sel,
          WeMem => WeMem,
          ALU_Bin_sel => ALU_Bin_sel,
          ALU_Func => ALU_Func,
          Zero => Zero,
          Ovf => Ovf,
          Cout => Cout,
          ImmedControl => ImmedControl,
          instr => instr,
			 selMem=>selMem
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		rst <= '1';
      wait for clk_period*2;	
		rst <= '0';
		pcSel <= '0';
		pcLdEn <= '1';
		wait for clk_period;
		--li
      RFWe <= '1';
      RFWrData <= '0';
      RF_B_sel <= '1';
      WeMem <= '0';
      ALU_Bin_sel <= '1';
      ALU_Func <= "0000";
      ImmedControl <= "01"; 
      wait for clk_period;
		--lui
      RFWe <= '1';
      RFWrData <= '0';
      RF_B_sel <= '1';
      WeMem <= '0';
      ALU_Bin_sel <= '1';
      ALU_Func <= "0000";
      ImmedControl <= "10"; 
      wait for clk_period;
		--addi
      RFWe <= '1';
      RFWrData <= '0';
      RF_B_sel <= '1';
      WeMem <= '0';
      ALU_Bin_sel <= '1';
      ALU_Func <= "0000";
      ImmedControl <= "01"; 
      wait for clk_period;
		--add
      RFWe <= '1';
      RFWrData <= '0';
      RF_B_sel <= '0';
      WeMem <= '0';
      ALU_Bin_sel <= '0';
      ALU_Func <= "0000";
      ImmedControl <= "XX"; 
      wait for clk_period;
		--sub
      ALU_Func <= "0001";
      wait for clk_period;
		--and
      ALU_Func <= "0010";
      wait for clk_period;
		--not
      ALU_Func <= "0100";
      wait for clk_period;
		--or
      ALU_Func <= "0011";
      wait for clk_period;
		--addi
      RFWe <= '1';
      RFWrData <= '0';
      RF_B_sel <= '1';
      WeMem <= '0';
      ALU_Bin_sel <= '1';
      ALU_Func <= "0000";
      ImmedControl <= "01";
		wait for clk_period;
		--sra
      RFWe <= '1';
      RFWrData <= '0';
      RF_B_sel <= '0';
      WeMem <= '0';
      ALU_Bin_sel <= '0';
      ALU_Func <= "1000";
      ImmedControl <= "XX"; 
      wait for clk_period;
		--sll
      ALU_Func <= "1010";
      wait for clk_period;
		--srl
      ALU_Func <= "1001";
      wait for clk_period;
		--rol
      ALU_Func <= "1100";
      wait for clk_period;
		--ror
      ALU_Func <= "1101";
      wait for clk_period;
		--andi
		RFWe <= '1';
      RFWrData <= '0';
      RF_B_sel <= '1';
      WeMem <= '0';
      ALU_Bin_sel <= '1';
      ALU_Func <= "0010";
      ImmedControl <= "01";
		wait for clk_period;
		--ori
		RFWe <= '1';
      RFWrData <= '0';
      RF_B_sel <= '1';
      WeMem <= '0';
      ALU_Bin_sel <= '1';
      ALU_Func <= "0010";
      ImmedControl <= "01";
		wait for clk_period;
		--sw
		pcSel <= '0';
		pcLdEn <= '1';
		RFWe <= '0';
      RFWrData <= '1';
      RF_B_sel <= '1';
      WeMem <= '1';  
      ImmedControl <= "01";
		wait for clk_period;
		--lw
		pcSel <= '0';
		pcLdEn <= '1';
		RFWe <= '1';
      RFWrData <= '1';
      RF_B_sel <= '1';
      WeMem <= '1';  
      ImmedControl <= "01";
		wait for clk_period;
		--lb
		pcSel <= '0';
		pcLdEn <= '1';
		RFWe <= '1';
      RFWrData <= '1';
      RF_B_sel <= '1';
      WeMem <= '0';  
      ImmedControl <= "01";
		selMem<='0';
		wait for clk_period;
		--b
		pcSel <= '1';
		pcLdEn <= '1';
		RFWe <= '0';
      RFWrData <= '0';
      RF_B_sel <= '1';
      WeMem <= '0';  
      ImmedControl <= "11";
		wait for clk_period;
--		--beq
--		pcSel <= '1';
--		pcLdEn <= '1';
--		RFWe <= '0';
--      RFWrData <= '0';
--      RF_B_sel <= '1';
--      WeMem <= '0';  
--      ImmedControl <= "11";
--		wait for clk_period;
		--bne
		pcSel <= '1';
		pcLdEn <= '1';
		RFWe <= '0';
      RFWrData <= '0';
      RF_B_sel <= '1';
      WeMem <= '0';  
      ImmedControl <= "11";	
	wait;
   end process;

END;