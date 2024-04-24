--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:20:25 04/11/2024
-- Design Name:   
-- Module Name:   /home/manos/Documents/organosh/registerFileTest/regFileTest.vhd
-- Project Name:  registerFileTest
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: registerFile
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
 
ENTITY regFileTest IS
END regFileTest;
 
ARCHITECTURE behavior OF regFileTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registerFile
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         addr1 : IN  std_logic_vector(4 downto 0);
         addr2 : IN  std_logic_vector(4 downto 0);
         addrw : IN  std_logic_vector(4 downto 0);
         dout1 : OUT  std_logic_vector(31 downto 0);
         dout2 : OUT  std_logic_vector(31 downto 0);
         din : IN  std_logic_vector(31 downto 0);
         we : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal addr1 : std_logic_vector(4 downto 0) := (others => '0');
   signal addr2 : std_logic_vector(4 downto 0) := (others => '0');
   signal addrw : std_logic_vector(4 downto 0) := (others => '0');
   signal din : std_logic_vector(31 downto 0) := (others => '0');
   signal we : std_logic := '0';

 	--Outputs
   signal dout1 : std_logic_vector(31 downto 0);
   signal dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registerFile PORT MAP (
          clk => clk,
          rst => rst,
          addr1 => addr1,
          addr2 => addr2,
          addrw => addrw,
          dout1 => dout1,
          dout2 => dout2,
          din => din,
          we => we
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
		rst<='0';
		


      -- insert stimulus here 

      wait;
   end process;

END;
