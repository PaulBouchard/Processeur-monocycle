library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processeur_tb is
END entity Processeur_tb;

architecture Bench of Processeur_tb is
    signal clk,rst : std_logic;
    signal aff : std_logic_vector(31 downto 0);
begin

    P : entity work.Processeur(RTL)
        port map(clk,rst,aff);

    clock: process
        begin
            rst <= '1';
            wait for 10 ns;
            rst <= '0';
            while now <= 100 us loop
                clk <= '0';
                wait for 5 NS;
                clk <= '1';
                wait for 5 NS;
            end loop;
            wait;
    end process;

end architecture;