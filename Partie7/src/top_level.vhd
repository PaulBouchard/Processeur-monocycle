library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_level is port(
    CLOCK_50 :  IN  STD_LOGIC;
	KEY	:  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
	SW 	:  IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
	GPIO :  OUT  STD_LOGIC_VECTOR(0 TO 35);
    HEX0 : OUT STD_LOGIC_VECTOR(0 to 6);
    HEX1 : OUT STD_LOGIC_VECTOR(0 to 6)
);
END entity top_level;


architecture RTL of top_level is
    signal 	rst,clk,GO,GOn1,irq1,irq0,pol,RX,ERREUR,DAV  : std_logic;
    signal Afficheur : std_logic_vector(31 downto 0);

    signal DATA2 : std_logic_vector(7 downto 0);
begin

    irq0 <= not KEY(0);
	irq1 <= not KEY(1);
    pol <= SW(8);

    -- Pour écrire un caractère à la fois
    process(CLOCK_50,RST)
    begin
        if SW(9) = '1' then
            GO <= '0';
            GOn1 <= '0';
        elsif Rising_edge(CLOCK_50) then
            GOn1 <= not KEY(1);
            GO <= not GOn1 and not KEY(1);
        end if;
    end process;

    Pro : entity work.Processeur(RTL)
        port map(CLOCK_50,SW(9),irq0,irq1,GPIO(0),DATA2,Afficheur);

        S71 : entity work.SEVEN_SEG(COMB)
            port map(DATA2(3 downto 0),pol,HEX0);

    S72 : entity work.SEVEN_SEG(COMB)
            port map(DATA2(7 downto 4),pol,HEX1);


end architecture;