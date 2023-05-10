library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Unite_de_Traitement_Avance_tb is
end entity;

architecture Bench of Unite_de_Traitement_Avance_tb is

    signal clk,rst : std_logic;
    signal ra,rb,rw : std_logic_vector(3 downto 0);
    signal we,regsel,affen : std_logic;
    signal op : std_logic_vector(2 downto 0);
    signal imm : std_logic_vector(7 downto 0);
    signal com1,com2,wren : std_logic;
    signal flag : std_logic_vector(3 downto 0);
    signal affichage : std_logic_vector(31 downto 0);
begin

    UTS : entity work.Unite_de_Traitement_Avance(RTL)
        port map(clk,rst,ra,rb,rw,we,op,imm,com1,com2,wren,regsel,affen,affichage,flag);

    clock: process
        begin
            rst <= '1';
        wait for 5 ns;
        rst <= '0';
            while now <= 90 NS loop
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
        ra <= "UUUU";
        rb <= "UUUU";
        rw <= "UUUU";
        we <= 'U';
        op <= "UUU";
        imm <= "UUUUUUUU";
        com1 <= 'U';
        com2 <= 'U';
        wren <= 'U';

        

        -- Addition 2 registres
        ra <= "1111";
        rb <= "1111";
        rw <= "1110";
        we <= '1';
        op <= "000";
        imm <= "00000000";
        com1 <= '0';
        com2 <= '0';
        wren <= '0';
        wait for 10 ns;

        -- Addition registre et valeur immediate
        ra <= "1110";
        rb <= "0000";
        rw <= "1101";
        we <= '1';
        op <= "000";
        imm <= "00000011";
        com1 <= '1';
        com2 <= '0';
        wren <= '0';
        wait for 10 ns;

        -- soustraction 2 registres
        ra <= "1110";
        rb <= "1111";
        rw <= "1100";
        we <= '1';
        op <= "010";
        imm <= "00000000";
        com1 <= '0';
        com2 <= '0';
        wren <= '0';
        wait for 10 ns;

        -- soustraction registre et valeur immediate
        ra <= "1111";
        rb <= "0000";
        rw <= "1111";
        we <= '1';
        op <= "010";
        imm <= "00001000";
        com1 <= '1';
        com2 <= '0';
        wren <= '0';
        wait for 10 ns;

        -- Copie d'un registre dans un autre
        ra <= "1101";
        rb <= "1101";
        rw <= "1111";
        we <= '1';
        op <= "001";
        imm <= "00000000";
        com1 <= '0';
        com2 <= '0';
        wren <= '0';
        wait for 20 ns;

        -- Copie d'un registre dans la mémoire
        ra <= "1101";
        rb <= "1111";
        rw <= "1111";
        we <= '0';
        op <= "011";
        imm <= "00000000";
        com1 <= '0';
        com2 <= '0';
        wren <= '1';
        wait for 10 ns;

        -- Copie d'un mot mémoire dans un registre
        ra <= "0000";
        rb <= "0000";
        rw <= "1111";
        we <= '1';
        op <= "011";
        imm <= "00000000";
        com1 <= '0';
        com2 <= '1';
        wren <= '0';
        wait for 20 ns;

        wait;
    end process ;
end architecture Bench;