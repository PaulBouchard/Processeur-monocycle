library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Reg_LR IS PORT(
    CLK : IN STD_LOGIC; -- async. clear.
    RST : IN STD_LOGIC; -- clock.
    IRQ : in STD_LOGIC;
    LR   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    LROUT   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
);
END entity Reg_LR;

ARCHITECTURE RTL OF Reg_LR IS
BEGIN
    process(CLK, RST)
    begin
        if RST = '1' then
            LROUT <= (others => '0');
        elsif rising_edge(CLK) then
            if IRQ = '1' then
                LROUT <= LR;
            end if;
        end if;
    end process;
END architecture RTL;