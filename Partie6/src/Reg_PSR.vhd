library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Reg_PSR IS
PORT(CLK : IN STD_LOGIC; -- async. clear.
     RST : IN STD_LOGIC; -- clock.
     PSREn : in std_logic;
     flags   : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
     DATAOUT   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
);
END entity Reg_PSR;

ARCHITECTURE RTL OF Reg_PSR IS
    signal flag32 : std_logic_vector(31 downto 0);
BEGIN
flag32 <= flags & x"0000000";
    process(CLK, RST)
    begin
        if RST = '1' then
            DATAOUT <= (others => '0');
        elsif rising_edge(CLK) then
            if PSREn = '1' then
                DATAOUT <= flag32;
            end if;
        end if;
    end process;
END architecture RTL;