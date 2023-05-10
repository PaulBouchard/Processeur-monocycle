library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY UART_Conf IS PORT(
    CLK : IN STD_LOGIC; -- async. clear.
    RST : IN STD_LOGIC; -- clock.
    go : in STD_LOGIC;
    OCTET   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    DATA   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
);
END entity UART_Conf;

ARCHITECTURE RTL OF UART_Conf IS
BEGIN
    process(CLK, RST)
    begin
        if RST = '1' then
            DATA <= (others => '0');
        elsif rising_edge(CLK) then
            if go = '1' then
                DATA <= OCTET;
            end if;
        end if;
    end process;
END architecture RTL;