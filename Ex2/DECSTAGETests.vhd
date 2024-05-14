--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:08:48 04/12/2024
-- Design Name:   
-- Module Name:   /home/ise/Organosi/Ex1V3/DECSTAGETests.vhd
-- Project Name:  Ex1V3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DECSTAGE
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
 
ENTITY DECSTAGETests IS
END DECSTAGETests;
 
ARCHITECTURE behavior OF DECSTAGETests IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         instr : IN  std_logic_vector(31 downto 0);
			rst: in std_logic;
         RF_we : IN  std_logic;
         ALUOut : IN  std_logic_vector(31 downto 0);
         MEMOut : IN  std_logic_vector(31 downto 0);
         RF_wData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         clk : IN  std_logic;
         immed : OUT  std_logic_vector(31 downto 0);
			ImmedControl: in STD_LOGIC_VECTOR(1 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal instr : std_logic_vector(31 downto 0) := (others => '0');
	signal ImmedControl: STD_LOGIC_VECTOR(1 downto 0) := (others => '0');
	signal rst : std_logic := '0';
   signal RF_we : std_logic := '0';
   signal ALUOut : std_logic_vector(31 downto 0) := (others => '0');
   signal MEMOut : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_wData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          instr => instr,
			 ImmedControl => ImmedControl,
			 rst => rst,
          RF_we => RF_we,
          ALUOut => ALUOut,
          MEMOut => MEMOut,
          RF_wData_sel => RF_wData_sel,
          RF_B_sel => RF_B_sel,
          clk => clk,
          immed => immed,
          RF_A => RF_A,
          RF_B => RF_B
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
      rst <= '1';
      wait for 10 ns;
		instr <= b"000000_00000_00011_00000_00000_000000"; --fake instr just to test if we write at reg3 
		rst <= '0';
		RF_we <= '1';	--write enable on
		ALUOut <= x"FFFFFFFF";	
		RF_wData_sel <= '0';	--select alu
		wait for clk_period;
		instr <= b"000000_00011_00000_00011_00000_000000"; --fake instr just to test if we read from reg3 
		RF_we <= '0';	--write enable off
		wait for clk_period;
		instr <= b"000000_00010_00010_00010_00000_000000"; --fake instr just to test read write at same reg2
		RF_we <= '1';	--write enable off
		MEMOut <= x"AAAAAAAA";	
		RF_wData_sel <= '1';	--select mem
		wait for clk_period;
		rst<='1';
		instr <= b"000000_00011_00000_00010_00000_000000"; --fake instr just to test if we read from reg3 and reg2
		wait;
		
   end process;

END;
