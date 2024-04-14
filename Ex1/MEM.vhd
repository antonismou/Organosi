----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:32:08 04/12/2024 
-- Design Name: 
-- Module Name:    MEM - Behavioral 
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

entity MEM is
    Port ( clk : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end MEM;

architecture Behavioral of MEM is
component memram is
PORT(
	ADDRA : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	DINA : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	DOUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	CLKA : IN STD_LOGIC;
	WEA : in std_logic);
end component;

begin
	memory : memram port map(CLKA => clk, DINA => MEM_DataIn, DOUT => MEM_DataOut, ADDRA => ALU_MEM_addr, WEA => Mem_WrEn);

end Behavioral;

