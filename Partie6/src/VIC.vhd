library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity VIC is
port(CLK,RST : in std_logic;
     IRQ_SERV : in std_logic; -- Acquittement de l’interruption venant de l’unité de gestion des instructions
     IRQ0,IRQ1 : in std_logic;

     IRQ : out std_logic;
     VICPC : out std_logic_vector(31 downto 0));
end entity VIC;

architecture RTL of VIC is
    signal IRQ0n,IRQ0n1,IRQ1n,IRQ1n1 : std_logic;
  begin

    process(CLK, RST)
    variable IRQ0_memo,IRQ1_memo : std_logic;

    begin
        if RST = '1' then
            IRQ <= '0';
            VICPC <= (others => '0');
        elsif rising_edge(CLK) then
            IRQ0n <= IRQ0;
            IRQ0n1 <= IRQ0n;
            IRQ1n <= IRQ1;
            IRQ1n1 <= IRQ1n;

            if IRQ0n = '1' and IRQ0n1 = '0' then
                IRQ0_memo := '1';
            end if;
            if IRQ1n = '1' and IRQ1n1 = '0' then
                IRQ1_memo := '1';
            end if;

            if IRQ_SERV = '1' then
                IRQ0_memo := '0';
                IRQ1_memo := '0';
            end if;

            if IRQ0_memo = '0' and IRQ1_memo = '0' then
                VICPC <= x"00000000";
            elsif IRQ0_memo = '1' then
                VICPC <= x"00000009";
            elsif IRQ1_memo = '1' then
                VICPC <= x"00000015";
            end if;

            IRQ <= IRQ0_memo or IRQ1_memo;
        end if;
    end process;
end architecture;