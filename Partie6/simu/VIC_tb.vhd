library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity VIC_tb is
END entity VIC_tb;

architecture Bench of VIC_tb is
    signal clk,rst,irq_serv,irq0,irq1,irq : std_logic;
    signal vicpc : std_logic_vector(31 downto 0);
begin

    V : entity work.VIC(RTL)
        port map(clk,rst,irq_serv,irq0,irq1,irq,vicpc);

    clock: process
    begin
        rst <= '1';
        rst <= '0';
        while now <= 100 ns loop
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
        irq_serv <= 'U';
        irq0 <= 'U';
        irq1 <= 'U';

        -- Pas de requête d'interruption (car acquittement reçu) donc vicpc = 0x00000000 et IRQ = 0
        irq_serv <= '1';
        irq0 <= '0';
        irq1 <= '0';
        wait for 15 ns;

        -- Requête d'interruption venant de IRQ0 donc vicpc = 0x00000009 et IRQ = 1
        irq_serv <= '0';
        irq0 <= '1';
        irq1 <= '0';
        wait for 15 ns;

        -- On remet les IRQi_memo à zéro avec l'acquittement et donc vicpc = 0x00000000 et IRQ = 0
        irq_serv <= '1';
        irq0 <= '0';
        irq1 <= '0';
        wait for 15 ns;

        -- Requête d'interruption venant de IRQ1 donc vicpc = 0x00000015 et IRQ = 1
        irq_serv <= '0';
        irq0 <= '0';
        irq1 <= '1';
        wait for 15 ns;

        -- On remet les IRQi_memo à zéro avec l'acquittement et vicpc = 0x00000000 et IRQ = 0
        irq_serv <= '1';
        irq0 <= '0';
        irq1 <= '0';
        wait for 15 ns;

        -- Requête d'interruption venant de IRQ0 et IRQ1 donc vicpc = 0x00000009 car IRQ0 a la priorité et IRQ = 1
        irq_serv <= '0';
        irq0 <= '1';
        irq1 <= '1';
        wait for 15 ns;

        wait;
    end process stimulus;
end architecture;