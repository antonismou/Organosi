--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:49:25 04/08/2024
-- Design Name:   
-- Module Name:   /home/ise/Organosi/Ex1/mux2Tests.vhd
-- Project Name:  Ex1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux2
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
 
ENTITY mux2Tests IS
END mux2Tests;
 
ARCHITECTURE behavior OF mux2Tests IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux2
    PORT(
         a1 : IN  std_logic_vector(31 downto 0);
         a2 : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic;
         b : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a1 : std_logic_vector(31 downto 0) := (others => '0');
   signal a2 : std_logic_vector(31 downto 0) := (others => '0');
   signal sel : std_logic := '0';

 	--Outputs
   signal b : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux2 PORT MAP (
          a1 => a1,
          a2 => a2,
          sel => sel,
          b => b
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
-- 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		a1 <= x"01010000";
		a2 <= x"00000001";
		sel <= '0';
		wait for 100 ns;	
		a1 <= x"01010000";
		a2 <= x"00000001";
		sel <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
