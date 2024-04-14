--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:01:05 04/12/2024
-- Design Name:   
-- Module Name:   /home/ise/Organosi/Ex1V3/extendMSBTests.vhd
-- Project Name:  Ex1V3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: extendMSB
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
 
ENTITY extendMSBTests IS
END extendMSBTests;
 
ARCHITECTURE behavior OF extendMSBTests IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT extendMSB
    PORT(
         din : IN  std_logic_vector(15 downto 0);
         immed : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal din : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal immed : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: extendMSB PORT MAP (
          din => din,
          immed => immed
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		din <= x"1002";
		wait for 100 ns;
		din <= x"FFFF";
		wait for 100 ns;
		din <= x"FF0F";
      -- insert stimulus here 

      wait;
   end process;

END;
