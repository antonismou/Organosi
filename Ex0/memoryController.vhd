----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    06:19:19 03/31/2024 
-- Design Name: 
-- Module Name:    memoryController - Behavioral 
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

entity memoryController is
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
end memoryController;

architecture Behavioral of memoryController is
type state is (idle,toRead,toWrite,toReadWrite);
signal fsm_state : state;

begin
	go_to_state : process
	begin
		WAIT UNTIL clk'EVENT AND clk = '1';
		if rst = '1' then
			fsm_state <= idle;
		else 
			if w = '1' and r = '1' then
				fsm_state <= toReadWrite;
			elsif w = '1' and r = '0' then
				fsm_state <= toWrite ;
			elsif w = '0' and r = '1' then
				fsm_state <= toRead;
			else 
				fsm_state <= idle;
			end if;
		end if;
	end process;	
	
	output : process(fsm_state,addrwIn,addrrIn,numberInIn)
	begin
		case fsm_state is
			when idle =>
				we <= '0'; 
				valid <= '0';
			when toRead =>
				we <= '0'; 
				valid <= '1';
				addrrOut <= addrrIn;
			when toWrite =>
				we <= '1'; 
				valid <= '0';
				numberInOut <= numberInIn; 
				addrwOut <= addrwIn;
			when toReadWrite =>
				we <= '1'; 
				valid <= '1';
				numberInOut <= numberInIn; 
				addrwOut <= addrwIn;
				addrrOut <= addrrIn;
			end case;
		end process;
				

end Behavioral;

