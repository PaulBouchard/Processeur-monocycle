library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is port(
    CLOCK_50 :  IN  STD_LOGIC;
	KEY	:  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
	SW 	:  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);

	HEX0 :  OUT  STD_LOGIC_VECTOR(0 TO 6);
	HEX1 :  OUT  STD_LOGIC_VECTOR(0 TO 6);
	HEX2 :  OUT  STD_LOGIC_VECTOR(0 TO 6);
	HEX3 :  OUT  STD_LOGIC_VECTOR(0 TO 6);
	HEX4 :  OUT  STD_LOGIC_VECTOR(0 TO 6);
	HEX5 :  OUT  STD_LOGIC_VECTOR(0 TO 6)
);
END entity top_level;


architecture RTL of top_level is
    signal 	rst,clk,pol  : std_logic;
    signal Afficheur : std_logic_vector(31 downto 0);
begin
    rst <= not KEY(0);
    clk <= CLOCK_50;
    pol <= SW(9);

    Pro : entity work.Processeur(RTL)
        port map(clk,rst,Afficheur);

    LED1 : entity work.SEVEN_SEG(COMB)
		port map(Afficheur(3 downto 0),pol,HEX0);

	LED2 : entity work.SEVEN_SEG(COMB)
		port map(Afficheur(7 downto 4),pol,HEX1);

	LED3 : entity work.SEVEN_SEG(COMB)
		port map(Afficheur(11 downto 8),pol,HEX2);

	LED4 : entity work.SEVEN_SEG(COMB)
		port map(Afficheur(15 downto 12),pol,HEX3);

	LED5 : entity work.SEVEN_SEG(COMB)
		port map(Afficheur(19 downto 16),pol,HEX4);

	LED6 : entity work.SEVEN_SEG(COMB)
		port map(Afficheur(23 downto 20),pol,HEX5);
end architecture;