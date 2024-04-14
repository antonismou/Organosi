--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:58:53 04/14/2024
-- Design Name:   
-- Module Name:   /home/manos/Documents/organosh/EX1V1/incrementroImmed_tests.vhd
-- Project Name:  EX1V1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: incrementor_immed
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
 
ENTITY incrementroImmed_tests IS
END incrementroImmed_tests;
 
ARCHITECTURE behavior OF incrementroImmed_tests IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT incrementor_immed
    PORT(
         input_incr_4 : IN  std_logic_vector(31 downto 0);
         immed : IN  std_logic_vector(31 downto 0);
         output : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input_incr_4 : std_logic_vector(31 downto 0) := (others => '0');
   signal immed : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
--   constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: incrementor_immed PORT MAP (
          input_incr_4 => input_incr_4,
          immed => immed,
          output => output
        );

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		input_incr_4<= x"00000004";
		immed<=x"00000007";
		
      wait for 100 ns;
		

      -- insert stimulus here 

      wait;
   end process;

END;
