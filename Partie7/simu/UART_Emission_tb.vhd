library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity UART_Emission_tb is
END entity UART_Emission_tb;

architecture Bench of UART_Emission_tb is
    signal clk,rst,go,tx,txlrq : std_logic;
    signal data : std_logic_vector(7 downto 0);
begin

    UTE : entity work.UART_Emission(RTL)
        port map(clk,rst,go,data,tx,txlrq);

    clock: process
        begin
            rst <= '1';
            wait for 10 ns;
            rst <= '0';
            while now <= 200 US loop
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
            data <= "00001110";
            wait for 1 us;

            go <= '1';
            wait for 1 us;

            go <= '0';
            wait for 75 us;

            data <= "01110000";
            go <= '1';
            wait for 1 us;

            go <= '0';
            wait;
        end process stimulus;
end architecture;