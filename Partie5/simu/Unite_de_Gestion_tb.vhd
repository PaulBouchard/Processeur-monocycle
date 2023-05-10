library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Unite_de_Gestion_tb is
end entity;

architecture Bench of Unite_de_Gestion_tb is

    signal clk,rst,npcsel : std_logic;
    signal offset : std_logic_vector(23 downto 0);
    signal instruction : std_logic_vector(31 downto 0);
begin

    UG : entity work.Unite_de_Gestion_des_Instructions(RTL)
        port map(clk,rst,npcsel,offset,instruction);

    clock: process
        begin
            while now <= 200 NS loop
                clk <= '0';
                wait for 5 NS;
                clk <= '1';
                wait for 5 NS;
            end loop;
            wait;
    end process;

    process
    begin
        -- Init
        npcsel <= 'U';
        offset <= (others => 'U');

        -- Reset
        rst <= '1';
        wait for 5 ns;
        rst <= '0';

        -- On incrémente simplement
        npcsel <= '0';
        offset <= (others => '0');
        wait for 80 ns;

        -- après la dernière instruction (BAL) npcsel et offset sont modifiés
        npcsel <= '1';
        offset <= "111111111111111111110111";
        wait for 10 ns;

        -- on revient à l'incrémentation normale
        npcsel <= '0';
        offset <= (others => '0');
        wait;
    end process ;
end architecture Bench;