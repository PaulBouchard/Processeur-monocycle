library ieee,std;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.STANDARD.all;
entity Unite_de_Traitement is port(
    CLK,RST : in std_logic;                         -- horloge et reset
    RA,RB,RW : in std_logic_vector(3 downto 0);     -- bus d'adresses lecture sur port A et B et bus d'adresses d'écriture
    WE : in std_logic;                              -- write enable (activation ou non de l'écriture)
    OP : in std_logic_vector(2 downto 0));
END entity Unite_de_Traitement;


architecture RTL of Unite_de_Traitement is
    signal WINTER : std_logic_vector(31 downto 0);
    signal A : std_logic_vector(31 downto 0);
    signal B : std_logic_vector(31 downto 0);
    signal flag : std_logic_vector(3 downto 0);
begin

    BR : entity work.Banc_de_Registres(RTL)
      port map(CLK,RST,WINTER,RA,RB,RW,WE,A,B);

    ALU : entity work.ALU(RTL)
      port map(A,B,OP,WINTER,flag(0),flag(1),flag(2),flag(3));
end architecture;