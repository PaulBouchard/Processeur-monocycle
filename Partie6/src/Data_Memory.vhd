library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Data_Memory is
port(
	CLK,RST : in std_logic;                         -- horloge et reset
    DATAIN : in std_logic_vector(31 downto 0);           -- Bus de données d'écriture
    ADDR : in std_logic_vector(5 downto 0);     -- Bus d’adresses en lecture et écriture sur 6 bits
    WREN : in std_logic;                              -- write enable (activation ou non de l'écriture)
    DATAOUT : out std_logic_vector(31 downto 0));       -- bus de données de lecture
end entity Data_Memory;

architecture RTL of Data_Memory is
    -- Declaration Type Tableau Memoire
    type table is array(63 downto 0) of
    std_logic_vector(31 downto 0);

    -- Fonction d'Initialisation du Banc de Registres
    function init_banc return table is
    variable result : table;
    begin
    for i in 62 downto 0 loop
    result(i) := std_logic_vector(to_unsigned(i,32));
    end loop;
    result(63):=X"00000030";
    return result;
    end init_banc;

    -- Déclaration et Initialisation du Banc de Registres 16x32 bits
    signal Banc: table:=init_banc;
    signal numO : integer;
begin

    numO <= to_integer(unsigned(ADDR));
    DATAOUT <= Banc(numO) when (numO >= 0 and numO < 64) else (others => '-');

    process(CLK,RST)
    begin
        if RST = '1'  THEN
            Banc <= init_banc;
        elsif rising_edge(CLK)then
            if WREN = '1' then
                if numO >= 0 and numO < 64 then
                    Banc(numO) <= DATAIN;
                end if;
            end if;
        end if;
    end process;
end architecture;