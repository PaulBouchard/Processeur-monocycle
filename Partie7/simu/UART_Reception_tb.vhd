library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UART_Reception_tb is
END entity UART_Reception_tb;

architecture Bench of UART_Reception_tb is
    signal clk,rst,rx,erreur,dav,go,txlrq : std_logic;
    signal DATAIN,DATAOUT : std_logic_vector(7 downto 0);
begin

    UEms : entity work.UART_Emission(RTL)
        port map(clk,rst,go,DATAIN,rx,txlrq);

    UTR : entity work.UART_Reception(RTL)
        port map(clk,rst,rx,DATAOUT,erreur,dav);

    clock: process
        begin
            rst <= '1';
            wait for 10 ns;
            rst <= '0';
            while now <= 400 US loop
                clk <= '0';
                wait for 5 NS;
                clk <= '1';
                wait for 5 NS;
            end loop;
            wait;
    end process;

    stimulus : process
        begin
            go <= '0';
            DATAIN <= "00001110";
            wait for 1 us;

            go <= '1';
            wait for 1 us;

            go <= '0';
            wait for 150 us;

            DATAIN <= "01110000";
            go <= '1';
            wait for 1 us;

            go <= '0';
            wait;
        end process stimulus;
end architecture;