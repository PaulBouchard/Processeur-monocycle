library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Banc_de_Registres is
port(
	CLK,RST : in std_logic;                         -- horloge et reset
    W : in std_logic_vector(31 downto 0);           -- Bus de données d'écriture
    RA,RB,RW : in std_logic_vector(3 downto 0);     -- bus d'adresses lecture sur port A et B et bus d'adresses d'écriture
    WE : in std_logic;                              -- write enable (activation ou non de l'écriture)
    A,B : out std_logic_vector(31 downto 0));       -- bus de données de lecture
end entity Banc_de_Registres;

architecture RTL OF Banc_de_Registres IS
    -- Numéros des registres qu'indique RA et RB et RW
    signal num_reg_a : integer;
    signal num_reg_b : integer;
    signal num_reg_w : integer;

    -- Declaration Type Tableau Memoire
    type table is array(15 downto 0) of
    std_logic_vector(31 downto 0);

    -- Fonction d'Initialisation du Banc de Registres
    function init_banc return table is
    variable result : table;
    begin
    for i in 14 downto 0 loop
    result(i) := std_logic_vector(to_unsigned(0,32));
    end loop;
    result(15):=X"00000030";
    return result;
    end init_banc;

    -- Déclaration et Initialisation du Banc de Registres 16x32 bits
    signal Banc: table:=init_banc;

begin
    num_reg_a <= to_integer(unsigned(RA));
    num_reg_b <= to_integer(unsigned(RB));
    A <= Banc(num_reg_a) when (num_reg_a > -1 and num_reg_a < 16) else (others => '-');
    B <= Banc(num_reg_b) when (num_reg_b > -1 and num_reg_b < 16) else (others => '-');
    num_reg_w <= to_integer(unsigned(RW));

  process(CLK,RST)
  begin
    if RST = '1'  THEN
        Banc <= init_banc;
 	elsif rising_edge(CLK)then
        if WE = '1' then
            if num_reg_w > -1 and num_reg_w < 16 then
                Banc(num_reg_w) <= W;
            end if;
        end if;
    end if;
  end process;
end architecture;
