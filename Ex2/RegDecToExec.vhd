----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:38:00 05/20/2024 
-- Design Name: 
-- Module Name:    RegDecToExec - Behavioral 
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

entity RegDecToExec is
Port(
		clk: in std_logic;
		rst: in std_logic;
		RF_AIN : IN  std_logic_vector(31 downto 0);
      RF_BIN : IN  std_logic_vector(31 downto 0);
		RF_AOUT : OUT  std_logic_vector(31 downto 0);
      RF_BOUT : OUT std_logic_vector(31 downto 0)
	);
end RegDecToExec;

architecture Behavioral of RegDecToExec is
COMPONENT reg
	 generic(dataWidth: integer := 32);
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         we : IN  std_logic;
         data : IN  std_logic_vector(dataWidth-1 downto 0);
         dout : OUT  std_logic_vector(dataWidth-1 downto 0)
        );
    END COMPONENT;
begin

regA : reg port map(clk=>clk,rst=>rst,we=>'1',data=>RF_AIN,dout=>RF_AOUT);
regB : reg port map(clk=>clk,rst=>rst,we=>'1',data=>RF_BIN,dout=>RF_BOUT);


end Behavioral;

