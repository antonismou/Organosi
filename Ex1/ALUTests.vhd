--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:23:38 04/12/2024
-- Design Name:   
-- Module Name:   /home/ise/Organosi/Ex1V3/ALUTests.vhd
-- Project Name:  Ex1V3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY ALUTests IS
END ALUTests;
 
ARCHITECTURE behavior OF ALUTests IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Output => Output,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
		--check all the possible alu oparations
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		A <= x"00000001";
		B <= x"00000002";
		Op <= "0000";
      wait for 100 ns;
		A <= x"00000003";
		B <= x"00000002";
		Op <= "0001";
		wait for 100 ns;
		A <= x"00000003";
		B <= x"00000002";
		Op <= "0010";
		wait for 100 ns;
		A <= x"00000003";
		B <= x"00000002";
		Op <= "0011";
		wait for 100 ns;
		A <= x"00000003";
		Op <= "0100";
		wait for 100 ns;
		A <= x"00000003";
		Op <= "1000";
		wait for 100 ns;
		A <= x"00000003";
		Op <= "1001";
		wait for 100 ns;
		A <= x"00000003";
		Op <= "1010";
		wait for 100 ns;
		A <= x"00000003";
		Op <= "1100";
		wait for 100 ns;
		A <= x"00000003";
		Op <= "1101";
		-- check Cout
		wait for 100 ns;
		A <= x"FFFFFFFF";
		B <= x"FFFFFFFF";
		Op <= "0000";
		wait for 100 ns;
		A<=x"80000000";
		B<=x"7FFFFFFF";
		Op<="0001";
		--Check for Zero
		wait for 100 ns;
		A <= x"FFFFFFFF";
		B <= x"FFFFFFFF";
		Op <= "0001";
		wait for 100 ns;
		A <= x"7FFFFFFF";
		B <= x"80000001";
		Op <= "0000";
		wait for 100 ns;
		--Check overflow
		A <= x"7FFFFFFF";
		B <= x"00000001";
		Op <= "0000";
		wait for 100 ns;
		A <= x"7FFFFFFF";
		B <= x"80000000";
		Op <= "0001";

      wait;
   end process;

END;
