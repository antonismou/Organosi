--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:59:04 04/16/2024
-- Design Name:   
-- Module Name:   /home/ise/Organosi/Ex1V3/DatapathTests.vhd
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
 
ENTITY DatapathTests IS
END DatapathTests;
 
ARCHITECTURE behavior OF DatapathTests IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Datapath
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         pcImmed : IN  std_logic_vector(31 downto 0);
         pcSel : IN  std_logic;
         pcLdEn : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal pcImmed : std_logic_vector(31 downto 0) := (others => '0');
   signal pcSel : std_logic := '0';
   signal pcLdEn : std_logic := '0';

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Datapath PORT MAP (
          clk => clk,
          rst => rst,
          pcImmed => pcImmed,
          pcSel => pcSel,
          pcLdEn => pcLdEn
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		pcImmed <= '0';
		pcSel <= '0';
		rst <= '0';
		pcLdEn <= '1';
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
