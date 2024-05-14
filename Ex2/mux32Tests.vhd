--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:12:01 04/08/2024
-- Design Name:   
-- Module Name:   /home/ise/Organosi/Ex1/mux32Tests.vhd
-- Project Name:  Ex1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux32
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
 
ENTITY mux32Tests IS
END mux32Tests;
 
ARCHITECTURE behavior OF mux32Tests IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux32
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
         a17 : IN  std_logic_vector(31 downto 0);
         a18 : IN  std_logic_vector(31 downto 0);
         a19 : IN  std_logic_vector(31 downto 0);
         a20 : IN  std_logic_vector(31 downto 0);
         a21 : IN  std_logic_vector(31 downto 0);
         a22 : IN  std_logic_vector(31 downto 0);
         a23 : IN  std_logic_vector(31 downto 0);
         a24 : IN  std_logic_vector(31 downto 0);
         a25 : IN  std_logic_vector(31 downto 0);
         a26 : IN  std_logic_vector(31 downto 0);
         a27 : IN  std_logic_vector(31 downto 0);
         a28 : IN  std_logic_vector(31 downto 0);
         a29 : IN  std_logic_vector(31 downto 0);
         a30 : IN  std_logic_vector(31 downto 0);
         a31 : IN  std_logic_vector(31 downto 0);
         a32 : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic_vector(4 downto 0);
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
   signal a17 : std_logic_vector(31 downto 0) := (others => '0');
   signal a18 : std_logic_vector(31 downto 0) := (others => '0');
   signal a19 : std_logic_vector(31 downto 0) := (others => '0');
   signal a20 : std_logic_vector(31 downto 0) := (others => '0');
   signal a21 : std_logic_vector(31 downto 0) := (others => '0');
   signal a22 : std_logic_vector(31 downto 0) := (others => '0');
   signal a23 : std_logic_vector(31 downto 0) := (others => '0');
   signal a24 : std_logic_vector(31 downto 0) := (others => '0');
   signal a25 : std_logic_vector(31 downto 0) := (others => '0');
   signal a26 : std_logic_vector(31 downto 0) := (others => '0');
   signal a27 : std_logic_vector(31 downto 0) := (others => '0');
   signal a28 : std_logic_vector(31 downto 0) := (others => '0');
   signal a29 : std_logic_vector(31 downto 0) := (others => '0');
   signal a30 : std_logic_vector(31 downto 0) := (others => '0');
   signal a31 : std_logic_vector(31 downto 0) := (others => '0');
   signal a32 : std_logic_vector(31 downto 0) := (others => '0');
   signal sel : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal b : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux32 PORT MAP (
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
          a17 => a17,
          a18 => a18,
          a19 => a19,
          a20 => a20,
          a21 => a21,
          a22 => a22,
          a23 => a23,
          a24 => a24,
          a25 => a25,
          a26 => a26,
          a27 => a27,
          a28 => a28,
          a29 => a29,
          a30 => a30,
          a31 => a31,
          a32 => a32,
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
		a17 <= x"00000010"; -- 16
		a18 <= x"00000011"; -- 17
		a19 <= x"00000012"; -- 18
		a20 <= x"00000013"; -- 19
		a21 <= x"00000014"; -- 20
		a22 <= x"00000015"; -- 21
		a23 <= x"00000016"; -- 22
		a24 <= x"00000017"; -- 23
		a25 <= x"00000018"; -- 24
		a26 <= x"00000019"; -- 25
		a27 <= x"0000001A"; -- 26
		a28 <= x"0000001B"; -- 27
		a29 <= x"0000001C"; -- 28
		a30 <= x"0000001D"; -- 29
		a31 <= x"0000001E"; -- 30
		a32 <= x"0000001F"; -- 31
		sel <= "00000";
		wait for 50 ns;
		sel <= "00001";
		wait for 50 ns;
		sel <= "00010";
		wait for 50 ns;
		sel <= "00011";
		wait for 50 ns;
		sel <= "00100";
		wait for 50 ns;
		sel <= "00101";
		wait for 50 ns;
		sel <= "00110";
		wait for 50 ns;
		sel <= "00111";
		wait for 50 ns;
		sel <= "01000";
		wait for 50 ns;
		sel <= "01001";
		wait for 50 ns;
		sel <= "01010";
		wait for 50 ns;
		sel <= "01011";
		wait for 50 ns;
		sel <= "01100";
		wait for 50 ns;
		sel <= "01101";
		wait for 50 ns;
		sel <= "01110";
		wait for 50 ns;
		sel <= "01111";
		wait for 50 ns;
		sel <= "10001";
		wait for 50 ns;
		sel <= "10010";
		wait for 50 ns;
		sel <= "10011";
		wait for 50 ns;
		sel <= "10100";
		wait for 50 ns;
		sel <= "10101";
		wait for 50 ns;
		sel <= "10110";
		wait for 50 ns;
		sel <= "10111";
		wait for 50 ns;
		sel <= "11000";
		wait for 50 ns;
		sel <= "11001";
		wait for 50 ns;
		sel <= "11010";
		wait for 50 ns;
		sel <= "11011";
		wait for 50 ns;
		sel <= "11100";
		wait for 50 ns;
		sel <= "11101";
		wait for 50 ns;
		sel <= "11110";
		wait for 50 ns;
		sel <= "11111";
		wait for 50 ns;

      -- insert stimulus here 

      wait;
   end process;

END;
