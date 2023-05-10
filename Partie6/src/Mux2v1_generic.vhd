library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Mux2v1_generic is
generic(N : integer := 32);
port(A,B : in std_logic_vector(N-1 downto 0);
     COM : in std_logic;
     S : out std_logic_vector(N-1 downto 0));
end entity Mux2v1_generic;

architecture RTL of Mux2v1_generic is
begin
    with COM select
        S <= A when '0',
             B when '1',
             (others => '0') when others;
end architecture RTL;