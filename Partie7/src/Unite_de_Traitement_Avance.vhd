library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Unite_de_Traitement_Avance is port(
    CLK,RST : in std_logic;                         -- horloge et reset
    RA,RB,RW : in std_logic_vector(3 downto 0);     -- bus d'adresses lecture sur port A et B et bus d'adresses d'écriture
    WE : in std_logic;                              -- write enable (activation ou non de l'écriture)
    OP : in std_logic_vector(2 downto 0);
    IMM : in std_logic_vector(7 downto 0);
    COM1,COM2 : in std_logic;
    WREN : in std_logic;
    REGSEL : in std_logic;
    AFFEN : in std_logic;

    Affichage : out std_logic_vector(31 downto 0);
    flag : out std_logic_vector(3 downto 0));
END entity Unite_de_Traitement_Avance;


architecture RTL of Unite_de_Traitement_Avance is
    signal WINTER,A,B,IMMOUT,MUXOUT,ALUOUT,DATAOUT : std_logic_vector(31 downto 0);
    signal RBINTER : std_logic_vector(3 downto 0);
begin

    IE : entity work.Extende_generic(RTL)
        generic map(8)
        port map(IMM,IMMOUT);

    MUXI : entity work.Mux2v1_generic(RTL)
        generic map(32)
        port map(B,IMMOUT,COM1,MUXOUT);

    ALU : entity work.ALU(RTL)
        port map(A,MUXOUT,OP,ALUOUT,flag(3),flag(2),flag(1),flag(0));

    DM : entity work.Data_Memory(RTL)
        port map(CLK,RST,B,ALUOUT(5 downto 0),WREN,DATAOUT);

    RAFF : entity work.Reg_Aff(RTL)
        port map(CLK,RST,AFFEN,B,Affichage);

    MUXW : entity work.Mux2v1_generic(RTL)
        generic map(32)
        port map(ALUOUT,DATAOUT,COM2,WINTER);

    MUXA : entity work.Mux2v1_generic(RTL)
        generic map(4)
        port map(RB,RW,REGSEL,RBINTER);

    BR : entity work.Banc_de_Registres(RTL)
        port map(CLK,RST,WINTER,RA,RBINTER,RW,WE,A,B);
end architecture;