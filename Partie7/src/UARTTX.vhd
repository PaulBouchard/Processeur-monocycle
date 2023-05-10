library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UARTTX is
port(CLK,RST : IN STD_LOGIC;
     TICK_BIT : IN STD_LOGIC;
     GO : IN STD_LOGIC;
     DATA : IN std_logic_vector(7 downto 0);

     TX : OUT STD_LOGIC;
     txlrq : out std_logic);
end entity UARTTX;

architecture RTL of UARTTX is
    signal reg : std_logic_vector(9 downto 0);
    signal cnt_bit : integer range 0 to 15;
    type StateType is (E1,E2,E3,E4);
    Signal State : StateType;
begin
    process(CLK, RST)
    begin
        if RST = '1' then
            TX <= '1';
            cnt_bit <= 0;
            reg <=(others => '0');
            txlrq <= '0';
        elsif Rising_edge(CLK) then
            case State is
                when E1 => if GO = '1' then
                                State <= E2;
                                reg <= '1' & DATA & '0';
                                cnt_bit <= 0;
                                txlrq <= '0';
                           end if;
                when E2 => if TICK_BIT = '1' then
                                State <= E3;
                                TX <= reg(cnt_bit);
                           end if;
                when E3 => State <= E4;
                           cnt_bit <= cnt_bit + 1;
                when E4 => if cnt_bit = 10 then
                                State <= E1;
                                cnt_bit <= 0;
                                txlrq <= '1';
                           elsif TICK_BIT = '1' then
                                State <= E3;
                                TX <= reg(cnt_bit);
                           end if;
            end case;
        end if;
    end process;
end architecture;