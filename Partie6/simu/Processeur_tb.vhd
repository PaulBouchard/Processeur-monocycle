library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processeur_tb is
END entity Processeur_tb;

architecture Bench of Processeur_tb is
    signal clk,rst,irq0,irq1 : std_logic;
    signal aff : std_logic_vector(31 downto 0);
begin

    P : entity work.Processeur(RTL)
        port map(clk,rst,irq0,irq1,aff);

    clock: process
        begin
            rst <= '1';
            wait for 10 ns;
            rst <= '0';
            while now <= 30 us loop
                clk <= '0';
                wait for 5 NS;
                clk <= '1';
                wait for 5 NS;
            end loop;
            wait;
    end process;

    stimulus : process
    begin
        -- Initialisation
        irq0 <= 'U';
        irq1 <= 'U';
        wait for 10 ns;

        irq0 <= '0';
        irq1 <= '0';
        wait for 2895 ns;

        irq1 <= '0';
        irq0 <= '1';
        wait for 234 ns;

        irq0 <= '0';
        irq1 <= '0';
        wait for 3333 ns;

        irq1 <= '1';
        irq0 <= '0';
        wait for 156 ns;

        irq0 <= '0';
        irq1 <= '0';
        wait for 4590 ns;

        irq1 <= '1';
        irq0 <= '0';
        wait for 10 ns;

        irq0 <= '0';
        irq1 <= '0';
        wait for 3 us;

        irq1 <= '0';
        irq0 <= '1';
        wait for 10 ns;

        irq0 <= '0';
        irq1 <= '0';
        wait for 3 us;

        irq1 <= '1';
        irq0 <= '0';
        wait for 10 ns;

        irq0 <= '0';
        irq1 <= '0';
        wait for 5193 ns;

        irq1 <= '1';
        irq0 <= '0';
        wait for 10 ns;

        irq0 <= '0';
        irq1 <= '0';
        wait for 3 us;

        irq1 <= '0';
        irq0 <= '1';
        wait for 10 ns;

        irq0 <= '0';
        irq1 <= '0';
        wait for 3 us;
        wait;
    end process stimulus;
end architecture;