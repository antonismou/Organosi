----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:41:55 04/08/2024 
-- Design Name: 
-- Module Name:    registerFile - Behavioral 
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

entity registerFile is
    Port ( clk : in  STD_LOGIC;
			  rst : in STD_LOGIC;
           addr1 : in  STD_LOGIC_VECTOR (4 downto 0);
           addr2 : in  STD_LOGIC_VECTOR (4 downto 0);
           addrw : in  STD_LOGIC_VECTOR (4 downto 0);
           dout1 : out  STD_LOGIC_VECTOR (31 downto 0);
           dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           din : in  STD_LOGIC_VECTOR (31 downto 0);
           we : in  STD_LOGIC);
end registerFile;

architecture Behavioral of registerFile is
	component reg is
	Port ( clk : in  STD_LOGIC;
			  rst : STD_LOGIC;
           we : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (31 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component reg;
	component reg0 is
	Port ( clk : in  STD_LOGIC;
			  rst : STD_LOGIC;
           we : in  STD_LOGIC;
           data : in  STD_LOGIC_VECTOR (31 downto 0);
           dout : out  STD_LOGIC_VECTOR (31 downto 0));
	end component reg0;
	 COMPONENT mux32 is
    PORT(
         a1 : IN  std_logic_vector(31 downto 0);
         a2 : IN  std_logic_vector(31 downto 0);
         a3 : IN  std_logic_vector(31 downto 0);
         a4 : IN  std_logic_vector(31 downto 0);
         a5 : IN  std_logic_vector(31 downto 0);
         a6 : IN  std_logic_vector(31 downto 0);
         a7 : IN  std_logic_vector(31 downto 0);
         a8 : IN  std_logic_vector(31 downto 0);
         a9 : IN  std_logic_vector(31 downto 0);
         a10 : IN  std_logic_vector(31 downto 0);
         a11 : IN  std_logic_vector(31 downto 0);
         a12 : IN  std_logic_vector(31 downto 0);
         a13 : IN  std_logic_vector(31 downto 0);
         a14 : IN  std_logic_vector(31 downto 0);
         a15 : IN  std_logic_vector(31 downto 0);
         a16 : IN  std_logic_vector(31 downto 0);
         a17 : IN  std_logic_vector(31 downto 0);
         a18 : IN  std_logic_vector(31 downto 0);
         a19 : IN  std_logic_vector(31 downto 0);
         a20 : IN  std_logic_vector(31 downto 0);
         a21 : IN  std_logic_vector(31 downto 0);
         a22 : IN  std_logic_vector(31 downto 0);
         a23 : IN  std_logic_vector(31 downto 0);
         a24 : IN  std_logic_vector(31 downto 0);
         a25 : IN  std_logic_vector(31 downto 0);
         a26 : IN  std_logic_vector(31 downto 0);
         a27 : IN  std_logic_vector(31 downto 0);
         a28 : IN  std_logic_vector(31 downto 0);
         a29 : IN  std_logic_vector(31 downto 0);
         a30 : IN  std_logic_vector(31 downto 0);
         a31 : IN  std_logic_vector(31 downto 0);
         a32 : IN  std_logic_vector(31 downto 0);
         sel : IN  std_logic_vector(4 downto 0);
         b : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT mux32;
	 
	 component decoder5to32 is
    Port ( din : in  STD_LOGIC_VECTOR (4 downto 0); dout : out STD_LOGIC_VECTOR (31 downto 0));
	 end component decoder5to32;
	 
	signal weS : STD_LOGIC_VECTOR(31 downto 0);		--signal for we for registers
	
	type dout_type is array (31 downto 0) of STD_LOGIC_VECTOR(31 downto 0);		--signal for every register for the dout
	signal doutS :	dout_type ;
	signal decoderOut : STD_LOGIC_VECTOR (31 downto 0);
begin
	gen_reg: for i in 1 to 31 generate
	regs: reg port map(clk => clk, rst => rst, we => weS(i), data => din, dout => doutS(i));
	end generate gen_reg;
	
	regs: reg0 port map(clk => clk, rst => rst, we => weS(0), data => din, dout => doutS(0));
	
	mux1 : mux32 port map(
		a1 => doutS(0),a2 => doutS(1),a3 => doutS(2),a4 => doutS(3),a5 => doutS(4),a6 => doutS(5),
		a7 => doutS(6),a8 => doutS(7),a9 => doutS(8),a10 => doutS(9),a11 => doutS(10),a12 => doutS(11),
		a13 => doutS(12),a14 => doutS(13),a15 => doutS(14),a16 => doutS(15),a17 => doutS(16),a18 => doutS(17),
		a19 => doutS(18),a20 => doutS(19),a21 => doutS(20),a22 => doutS(21),a23 => doutS(22),a24 => doutS(23),
		a25 => doutS(24),a26 => doutS(25),a27 => doutS(26),a28 => doutS(27),a29 => doutS(28),a30 => doutS(29),
		a31 => doutS(30),a32 => doutS(31),sel => addr1,b => dout1);
	
	mux2 : mux32 port map(
		a1 => doutS(0),a2 => doutS(1),a3 => doutS(2),a4 => doutS(3),a5 => doutS(4),a6 => doutS(5),
		a7 => doutS(6),a8 => doutS(7),a9 => doutS(8),a10 => doutS(9),a11 => doutS(10),a12 => doutS(11),
		a13 => doutS(12),a14 => doutS(13),a15 => doutS(14),a16 => doutS(15),a17 => doutS(16),a18 => doutS(17),
		a19 => doutS(18),a20 => doutS(19),a21 => doutS(20),a22 => doutS(21),a23 => doutS(22),a24 => doutS(23),
		a25 => doutS(24),a26 => doutS(25),a27 => doutS(26),a28 => doutS(27),a29 => doutS(28),a30 => doutS(29),
		a31 => doutS(30),a32 => doutS(31),sel => addr2,b => dout2);
	
	decoder : decoder5to32 port map(din => addrw, dout => decoderOut);
	
--	process(we,decoderOut)
--	begin
		for i in 0 to 31 loop
			weS(i) <= decoderOut(i) and we;
		end loop;
	--end process;

end Behavioral;

