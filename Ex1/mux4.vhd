----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:11:35 04/08/2024 
-- Design Name: 
-- Module Name:    mux4 - Behavioral 
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

entity mux4 is
generic(
dataWidth: integer := 32 
);
port(
	a1  : in std_logic_vector(dataWidth-1 downto 0);
	a2  : in std_logic_vector(dataWidth-1 downto 0);
	a3  : in std_logic_vector(dataWidth-1 downto 0);
	a4  : in std_logic_vector(dataWidth-1 downto 0);
	sel     : in  std_logic_vector(1 downto 0);
	b       : out std_logic_vector(dataWidth-1 downto 0)
	);
end mux4;

architecture Behavioral of mux4 is

begin
	process(a1, a2, a3, a4, sel)
	begin
        case sel is
            when "00" =>
                b <= a1;
            when "01" =>
                b <= a2;
            when "10" =>
                b <= a3;
            when others =>
                b <= a4;
        end case;
	end process;
end Behavioral;


