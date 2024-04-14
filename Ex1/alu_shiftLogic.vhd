----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:01:20 04/10/2024 
-- Design Name: 
-- Module Name:    alu_shiftLogic - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_shiftLogic is
  Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end alu_shiftLogic;

architecture Behavioral of alu_shiftLogic is
signal temp: STD_LOGIC_VECTOR (31 downto 0);
begin
	process
	begin
		case Op is
			when "1000" =>
				temp<=(STD_LOGIC_VECTOR(shift_right(signed(A),1)));
			when "1001" =>
				temp<=(STD_LOGIC_VECTOR(shift_right(unsigned(A),1)));
			when "1010" =>
				temp<= (STD_LOGIC_VECTOR(shift_left(unsigned(A),1)));
			when "1100" =>
				temp<= (STD_LOGIC_VECTOR(rotate_left(unsigned(A),1)));
			when "1101" =>
				temp<= (STD_LOGIC_VECTOR(rotate_right(unsigned(A),1)));
			when others=>
		
		end case;
	end process;
	process is
	begin
		if temp = x"00000000" then
			Zero <= '1';
		else
			Zero <='0';
		end if;
	end process;
	Output <= temp ; 
			



end Behavioral;

