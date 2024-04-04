--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   07:11:32 03/31/2024
-- Design Name:   
-- Module Name:   /home/ise/Desktop/Organosi/askisi0Sosti/test.vhd
-- Project Name:  askisi0Sosti
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: system
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
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT system
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         addrw : IN  std_logic_vector(4 downto 0);
         addrr : IN  std_logic_vector(4 downto 0);
         w : IN  std_logic;
         r : IN  std_logic;
         numberIn : IN  std_logic_vector(15 downto 0);
         numberOut : OUT  std_logic_vector(15 downto 0);
         valid : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal addrw : std_logic_vector(4 downto 0) := (others => '0');
   signal addrr : std_logic_vector(4 downto 0) := (others => '0');
   signal w : std_logic := '0';
   signal r : std_logic := '0';
   signal numberIn : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal numberOut : std_logic_vector(15 downto 0);
   signal valid : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: system PORT MAP (
          clk => clk,
          rst => rst,
          addrw => addrw,
          addrr => addrr,
          w => w,
          r => r,
          numberIn => numberIn,
          numberOut => numberOut,
          valid => valid
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
      -- lets test the change of the state
      wait for 100 ns;	
		rst <= '1';
		r <= '0';
		w <= '0';
		wait for clk_period*3;	
		rst <= '0';
		r <= '1';
		w <= '0';
		wait for clk_period*3;	
		r <= '0';
		w <= '1';
		wait for clk_period*3;
		rst <= '1';
		r <= '1';
		w <= '1';
		wait for clk_period*3;
		rst <= '0';
		r <= '1';
		w <= '1';
		--all states cheacked
		wait for clk_period*3;
		rst <= '1';
		r <= '0';
		w <= '0';
		wait for clk_period*3;
		--cheack the read state (we want to see valid=1 numOut=2)
		rst <= '0';
		r <= '1';
		w <= '0';
		addrr<= "00010";
		addrw<= "01010";
		numberIn <= x"0005";
		wait for clk_period*10;
		--cheack again the read state (we want to see valid=1 numOut=1)
		rst <= '0';
		r <= '1';
		w <= '0';
		addrr<= "00001";
		addrw<= "01011";
		numberIn <= x"0002";
		wait for clk_period*10;
		--cheack again the read state (we want to see valid=1 numOut=0)
		rst <= '0';
		r <= '1';
		w <= '0';
		addrr<= "00000";
		addrw<= "01001";
		numberIn <= x"0006";
		wait for clk_period*10;
		--(expaicting to see valid=1 numberOut=32 and to write the number 1 to address 32)
		rst<= '0';
		r <= '1';
		w <= '1';
		addrr<= "1111";
		addrw<= "1111";
		numberIn <= x"0001";
		wait for clk_period*10;
		--(expaicting to see Valid=1 numberOut=1 that we wrote in the previous clock event=1)
		rst<= '0';
		r <= '1';
		w <= '0';
		addrr<= "1111";
		addrw<= "1111";
		numberIn <= x"0001";
		
	
	
      -- insert stimulus here 

      wait;
   end process;

END;
