----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:53:59 04/10/2024 
-- Design Name: 
-- Module Name:    alu_and_or_not - Behavioral 
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

entity alu_and_or_not is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end alu_and_or_not;

architecture Behavioral of alu_and_or_not is
signal temp: STD_LOGIC_VECTOR (31 downto 0);
begin
	process(A,B,Op)	is
	begin
		Cout<='0';
		Ovf<='0';
		if Op="0010" then
			temp<= (A and B);
		elsif Op="0011" then
			temp<= (A or B);
		else
			temp<= (not A);
		end if;
	end process;
	
	process(temp) is
	begin
		if temp = x"00000000" then
			Zero <= '1';
		else
			Zero <='0';
		end if;
	end process;
	Output <= temp ; 
	
		


end Behavioral;

