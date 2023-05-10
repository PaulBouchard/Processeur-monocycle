library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Extende_generic is
generic(N : integer := 8);
port(E : in std_logic_vector(N-1 downto 0);
     S : out std_logic_vector(31 downto 0));
end entity Extende_generic;

architecture RTL of Extende_generic is
    signal comp : std_logic_vector(31 downto 0);
begin
    comp <= (others => E(N-1));

    S <= comp(31 downto N) & E;
end architecture RTL;