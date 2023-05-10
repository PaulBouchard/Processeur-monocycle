library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Reg_PC IS PORT(
    CLK : IN STD_LOGIC; -- async. clear.
    RST : IN STD_LOGIC; -- clock.
    PC   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    PCOUT   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
);
END entity Reg_PC;

ARCHITECTURE RTL OF Reg_PC IS
BEGIN
    process(CLK, RST)
    begin
        if RST = '1' then
            PCOUT <= (others => '0');
        elsif rising_edge(CLK) then
            PCOUT <= PC;
        end if;
    end process;
END architecture RTL;