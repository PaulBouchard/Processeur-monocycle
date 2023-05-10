library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity VIC is
port(CLK,RST : in std_logic;
     IRQ_SERV : in std_logic; -- Acquittement de l’interruption venant de l’unité de gestion des instructions
     IRQ0,IRQ1 : in std_logic;
     txlrq : in std_logic;

     IRQ : out std_logic;
     VICPC : out std_logic_vector(31 downto 0);
     DATA : out std_logic_vector(7 downto 0));
end entity VIC;

architecture RTL of VIC is
    signal IRQ0n,IRQ0n1,IRQ1n,IRQ1n1,txlrqn,txlrqn1 : std_logic;
    signal cnt : integer;
  begin

    process(CLK, RST)
    variable IRQ0_memo,IRQ1_memo,txlrq_memo : std_logic;
    begin
        if RST = '1' then
            IRQ <= '0';
            VICPC <= (others => '0');
            DATA <= (others => '0');
            cnt <= 0;
        elsif rising_edge(CLK) then
            IRQ0n <= IRQ0;
            IRQ0n1 <= IRQ0n;
            IRQ1n <= IRQ1;
            IRQ1n1 <= IRQ1n;

            txlrqn <= txlrq;
            txlrqn1 <= txlrqn;

            if txlrqn = '1' and txlrqn1 = '0' then
                txlrq_memo := '1';
            end if;
            if IRQ0n = '1' and IRQ0n1 = '0' then
                IRQ0_memo := '1';
            end if;
            if IRQ1n = '1' and IRQ1n1 = '0' then
                IRQ1_memo := '1';
            end if;

            if IRQ_SERV = '1' then
                IRQ0_memo := '0';
                IRQ1_memo := '0';
                txlrq_memo := '0';
            end if;

            if IRQ0_memo = '0' and IRQ1_memo = '0' and txlrq_memo = '0' then
                VICPC <= x"00000000";
            elsif IRQ0_memo = '1' then
                VICPC <= x"00000009";
            elsif IRQ1_memo = '1' or txlrq_memo = '1' then
                VICPC <= x"00000015";
            end if;

            IRQ <= IRQ0_memo or IRQ1_memo or txlrq_memo;

            if (cnt = 1 and txlrq_memo = '1') then         -- E
                DATA <= "01000101";
                cnt <= cnt + 1;
            elsif (txlrq_memo = '1' and (cnt = 2 or cnt = 3 or cnt = 9)) then         -- L
                DATA <= "01001100";
                cnt <= cnt + 1;
            elsif (txlrq_memo = '1' and (cnt = 4 or cnt = 7)) then         -- O
                DATA <= "01001111";
                cnt <= cnt + 1;
            elsif (txlrq_memo = '1' and (cnt = 5 or cnt = 11)) then         --
                DATA <= "00100000";
                cnt <= cnt + 1;
            elsif (txlrq_memo = '1' and cnt = 6) then          -- W
                DATA <= "01010111";
                cnt <= cnt + 1;
            elsif (txlrq_memo = '1' and cnt = 8) then          -- R
                DATA <= "01010010";
                cnt <= cnt + 1;
            elsif (txlrq_memo = '1' and cnt = 10) then          -- D
                DATA <= "01000100";
                cnt <= cnt + 1;
            elsif (txlrq_memo = '1' and cnt = 12) then
                cnt <= 0;
                txlrq_memo := '0';
                VICPC <= x"00000000";
            elsif IRQ1_memo = '1' then         -- H
                DATA <= "01001000";
                cnt <= cnt + 1;
                IRQ1_memo := '0';
            end if;
        end if;
    end process;
end architecture;