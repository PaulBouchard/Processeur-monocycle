library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Unite_de_Traitement_tb is
end entity;

architecture Bench of Unite_de_Traitement_tb is

    signal clk,rst,we : std_logic;
    signal ra,rb,rw : std_logic_vector(3 downto 0);
    signal op : std_logic_vector(2 downto 0);

begin

    UB : entity work.Unite_de_Traitement(RTL)
        port map(clk,rst,ra,rb,rw,we,op);

    clock: process
        begin
            rst <= '1';
            wait for 1 ns;
            rst <= '0';
            while now <= 60 NS loop
                clk <= '0';
                wait for 5 NS;
                clk <= '1';
                wait for 5 NS;
            end loop;
            wait;
    end process;

    stimulus : process
        begin

            -- r(1) = r(15)
            -- reg sortie et alu entrée
            ra <= "1111";
            rb <= "0000";
            op <= "011";

            -- alu sortie et reg entrée
            we <= '1';
            rw <= "0001";
            wait for 10 ns;

            -- R(1) = R(1) + R(15)
            -- reg sortie et alu entrée
            ra <= "1111";
            rb <= "0001";
            op <= "000";

            -- alu sortie et reg entrée
            we <= '1';
            rw <= "0001";
            wait for 10 ns;

            -- R(2) = R(1) + R(15)
            -- reg sortie et alu entrée
            ra <= "1111";
            rb <= "0001";
            op <= "000";

            -- alu sortie et reg entrée
            we <= '1';
            rw <= "0010";
            wait for 10 ns;

            -- R(3) = R(1) – R(15)
            -- reg sortie et alu entrée
            ra <= "0001";
            rb <= "1111";
            op <= "010";

            -- alu sortie et reg entrée
            we <= '1';
            rw <= "0011";
            wait for 10 ns;

            -- R(5) = R(7) – R(15)
            -- reg sortie et alu entrée
            ra <= "0111";
            rb <= "1111";
            op <= "010";

            -- alu sortie et reg entrée
            we <= '1';
            rw <= "0101";
            wait for 10 ns;

            wait;
        end process stimulus;
end architecture Bench;