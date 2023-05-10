library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processeur is port(
    CLK,RST : in std_logic;
    IRQ0,IRQ1 : in std_logic;

    Afficheur : out std_logic_vector(31 downto 0)
);
END entity Processeur;


architecture RTL of Processeur is
    signal npcsel,regwr,alusrc,psren,memwr,wrsrc,regsel,regaff : std_logic;
    signal instruction,flagsout : std_logic_vector(31 downto 0);
    signal flagsin : std_logic_vector(3 downto 0);
    signal aluctrl : std_logic_vector(2 downto 0);
    signal ra,rb,rw : std_logic_vector(3 downto 0);
    signal Imm8 : std_logic_vector(7 downto 0);
    signal Imm24 : std_logic_vector(23 downto 0);

    signal irq,irq_end,irq_serv : std_logic;
    signal vicpc : std_logic_vector(31 downto 0);
begin

    VI : entity work.VIC(RTL)
        port map(CLK,RST,irq_serv,IRQ0,IRQ1,irq,vicpc);

    UGI : entity work.Unite_de_Gestion_des_Instructions(RTL)
        port map(CLK,RST,npcsel,Imm24,irq,vicpc,irq_end,irq_serv,instruction);

    DI : entity work.Decodeur_Instruction(RTL)
        port map(instruction,flagsout,npcsel,regwr,alusrc,aluctrl,psren,memwr,wrsrc,regsel,regaff,imm8,imm24,irq_end);

    ra <= instruction(19 downto 16);
    rb <= instruction(3 downto 0);
    rw <= instruction(15 downto 12);
    UT : entity work.Unite_de_Traitement_Avance(RTL)
        port map(CLK,RST,ra,rb,rw,regwr,aluctrl,imm8,alusrc,wrsrc,memwr,regsel,regaff,Afficheur,flagsin);

    RPSR : entity work.Reg_PSR(RTL)
        port map(CLK,RST,psren,flagsin,flagsout);
end architecture;