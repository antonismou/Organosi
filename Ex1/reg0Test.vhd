--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:36:43 04/08/2024
-- Design Name:   
-- Module Name:   /home/ise/Organosi/Ex1/reg0Test.vhd
-- Project Name:  Ex1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: reg0
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
 
ENTITY reg0Test IS
END reg0Test;
 
ARCHITECTURE behavior OF reg0Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT reg0
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         we : IN  std_logic;
         data : IN  std_logic_vector(31 downto 0);
         dout : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal we : std_logic := '0';
   signal data : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal dout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reg0 PORT MAP (
          clk => clk,
          rst => rst,
          we => we,
          data => data,
          dout => dout
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
		rst <='1';
      wait for clk_period*10;
		rst <='0';
		we <= '1';
		data <= x"00001001";
      wait for clk_period*10;
		rst <='1';
		we <= '1';
		data <= x"00001111";
      wait for clk_period*10;
		rst <='0';
		we <= '0';
		data <= x"00001001";
      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
