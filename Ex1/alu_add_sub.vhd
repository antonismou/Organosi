----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:49:18 04/10/2024 
-- Design Name: 
-- Module Name:    alu_add_sub - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity add_sub_ALU is
    Port( A : in  STD_LOGIC_VECTOR (31 downto 0);
        B : in  STD_LOGIC_VECTOR (31 downto 0);
        Op : in  STD_LOGIC_VECTOR (3 downto 0);
        Output : out  STD_LOGIC_VECTOR (31 downto 0);
	     Zero : out  STD_LOGIC;
        Cout : out  STD_LOGIC;
        Ovf : out  STD_LOGIC);
end add_sub_ALU;

architecture Behavioral of add_sub_ALU is
SIGNAL temp : STD_LOGIC_VECTOR (32 downto 0); 


begin

	process(Op,A,B) is
	begin
		if Op = "0000" then --add
			temp <=((A(31) & A) + (B(31) & B)); 
		else
			temp <=  ((A(31) & A) - (B(31) & B)); 
		end if;
	end process;
	

	process(Op,A,B,temp) is
	begin										
		if((Op = "0000") AND (A(31) = B(31)) AND ( A(31) /= temp(31))) then
			Ovf <= '1';
		elsif ((Op = "0001") AND (A(31) /= B(31)) AND ( B(31) = temp(31))) then 
			Ovf <= '1';
		else 
			Ovf <='0';
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
	Cout <= temp(32);
	Output <= temp(31 downto 0); 

end Behavioral;