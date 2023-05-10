library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY Reg_Aff IS
PORT(CLK : IN STD_LOGIC; -- async. clear.
     RST : IN STD_LOGIC; -- clock.
     WE : in std_logic;
     DATAIN   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
     DATAOUT   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- output
);
END entity Reg_Aff;

ARCHITECTURE RTL OF Reg_Aff IS

BEGIN
    process(CLK, RST)
    begin
        if RST = '1' then
            DATAOUT <= (others => '0');
        elsif rising_edge(CLK) then
            if WE = '1' then
                DATAOUT <= DATAIN;
            end if;
        end if;
    end process;
END architecture RTL;