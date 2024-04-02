----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:28:10 03/31/2024 
-- Design Name: 
-- Module Name:    system - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity system is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           addrw : in  STD_LOGIC_VECTOR (4 downto 0);
           addrr : in  STD_LOGIC_VECTOR (4 downto 0);
           w : in  STD_LOGIC;
           r : in  STD_LOGIC;
           numberIn : in  STD_LOGIC_VECTOR (15 downto 0);
           numberOut : out  STD_LOGIC_VECTOR (15 downto 0);
           valid : out  STD_LOGIC);
end system;

architecture Behavioral of system is
	signal addrwS , addrrS : STD_LOGIC_VECTOR (4 downto 0);
	signal numberInS : STD_LOGIC_VECTOR (15 downto 0);
	signal weS : STD_LOGIC;
	component memoryController is
		  Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  addrwIn : in  STD_LOGIC_VECTOR (4 downto 0);
           addrrIn : in  STD_LOGIC_VECTOR (4 downto 0);
           addrwOut : out  STD_LOGIC_VECTOR (4 downto 0);
           addrrOut : out  STD_LOGIC_VECTOR (4 downto 0);
           w : in  STD_LOGIC;
           r : in  STD_LOGIC;
			  numberInIn : in  STD_LOGIC_VECTOR (15 downto 0);
           numberInOut : out  STD_LOGIC_VECTOR (15 downto 0);
           valid : out  STD_LOGIC;
			  we : out STD_LOGIC);
	end component memoryController;
	
	component memory is 
		Port(
		d : in STD_LOGIC_VECTOR (15 DOWNTO 0);
		a : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		dpra : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		dpo : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		we : IN STD_LOGIC;
		clk : IN STD_LOGIC
		);
	end component memory;
	
begin

	fsm : memoryController
	port map(
		clk => clk,
		rst => rst,
		addrwIn => addrw,
		addrrIn => addrr,
		w => w,
		r => r,
		numberInIn => numberIn,
		valid => valid,
		addrwOut => addrwS,
		addrrOut => addrrS,
		we => weS,
		numberInOut => numberInS
	);

	mem : memory
	port map(
		clk => clk,
		d => numberInS,
		dpo => numberOut,
		dpra => addrrS,
		a => addrwS,
		we => weS
	);
	

end Behavioral;

