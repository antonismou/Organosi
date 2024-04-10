--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:31:50 04/08/2024
-- Design Name:   
-- Module Name:   /home/ise/Organosi/Ex1/mux16Tests.vhd
-- Project Name:  Ex1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux16
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
 
ENTITY mux16Tests IS
END mux16Tests;
 
ARCHITECTURE behavior OF mux16Tests IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux16
    PORT(
         a1 : IN  std_logic_vector(31 downto 0);
         a2 : IN  std_logic_vector(31 downto 0);
         a3 : IN  std_logic_vector(31 downto 0);
         a4 : IN  std_logic_vector(31 downto 0);
         a5 : IN  std_logic_vector(31 downto 0);
         a6 : IN  std_logic_vector(31 downto 0);
         a7 : IN  std_logic_vector(31 downto 0);
         a8 : IN  std_logic_vector(31 downto 0);
         a9 : IN  std_logic_vector(31 downto 0);
         a10 : IN  std_logic_vector(31 downto 0);
         a11 : IN  std_logic_vector(31 downto 0);
         a12 : IN  std_logic_vector(31 downto 0);
         a13 : IN  std_logic_vector(31 downto 0);
         a14 : IN  std_logic_vector(31 downto 0);
         a15 : IN  std_logic_vector(31 downto 0);
         a16 : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic_vector(3 downto 0);
         b : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a1 : std_logic_vector(31 downto 0) := (others => '0');
   signal a2 : std_logic_vector(31 downto 0) := (others => '0');
   signal a3 : std_logic_vector(31 downto 0) := (others => '0');
   signal a4 : std_logic_vector(31 downto 0) := (others => '0');
   signal a5 : std_logic_vector(31 downto 0) := (others => '0');
   signal a6 : std_logic_vector(31 downto 0) := (others => '0');
   signal a7 : std_logic_vector(31 downto 0) := (others => '0');
   signal a8 : std_logic_vector(31 downto 0) := (others => '0');
   signal a9 : std_logic_vector(31 downto 0) := (others => '0');
   signal a10 : std_logic_vector(31 downto 0) := (others => '0');
   signal a11 : std_logic_vector(31 downto 0) := (others => '0');
   signal a12 : std_logic_vector(31 downto 0) := (others => '0');
   signal a13 : std_logic_vector(31 downto 0) := (others => '0');
   signal a14 : std_logic_vector(31 downto 0) := (others => '0');
   signal a15 : std_logic_vector(31 downto 0) := (others => '0');
   signal a16 : std_logic_vector(31 downto 0) := (others => '0');
   signal sel : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal b : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux16 PORT MAP (
          a1 => a1,
          a2 => a2,
          a3 => a3,
          a4 => a4,
          a5 => a5,
          a6 => a6,
          a7 => a7,
          a8 => a8,
          a9 => a9,
          a10 => a10,
          a11 => a11,
          a12 => a12,
          a13 => a13,
          a14 => a14,
          a15 => a15,
          a16 => a16,
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
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;
		a1 <= x"00000000"; -- 0
		a2 <= x"00000001"; -- 1
		a3 <= x"00000002"; -- 2
		a4 <= x"00000003"; -- 3
		a5 <= x"00000004"; -- 4
		a6 <= x"00000005"; -- 5
		a7 <= x"00000006"; -- 6
		a8 <= x"00000007"; -- 7
		a9 <= x"00000008"; -- 8
		a10 <= x"00000009"; -- 9
		a11 <= x"0000000A"; -- 10
		a12 <= x"0000000B"; -- 11
		a13 <= x"0000000C"; -- 12
		a14 <= x"0000000D"; -- 13
		a15 <= x"0000000E"; -- 14
		a16 <= x"0000000F"; -- 15
		sel <= "0000";
		wait for 50 ns;
		sel <= "0001";
		wait for 50 ns;
		sel <= "0010";
		wait for 50 ns;
		sel <= "0011";
		wait for 50 ns;
		sel <= "0100";
		wait for 50 ns;
		sel <= "0101";
		wait for 50 ns;
		sel <= "0110";
		wait for 50 ns;
		sel <= "0111";
		wait for 50 ns;
		sel <= "1000";
		wait for 50 ns;
		sel <= "1001";
		wait for 50 ns;
		sel <= "1010";
		wait for 50 ns;
		sel <= "1011";
		wait for 50 ns;
		sel <= "1100";
		wait for 50 ns;
		sel <= "1101";
		wait for 50 ns;
		sel <= "1110";
		wait for 50 ns;
		sel <= "1111";
		wait for 50 ns;
      -- insert stimulus here 

      wait;
   end process;

END;
