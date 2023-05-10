library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UARTRX is
port(CLK,RST : IN STD_LOGIC;
     TICK_DEMI_BIT : IN STD_LOGIC;
     RX : IN STD_LOGIC;

     DATA : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
     CLEAR_FDIV : OUT STD_LOGIC;
     DAV : OUT STD_LOGIC;
     ERREUR : OUT STD_LOGIC);
end entity UARTRX;

architecture RTL of UARTRX is
    signal reg : std_logic_vector(7 downto 0);
    signal cnt_bit : integer range 0 to 15;
    type StateType is (E1,E2,E21,E3,E4,E5,E6,E7,E8,E9,E10,ER);
    Signal State : StateType;
begin
     process(CLK, RST)
     begin
          if RST = '1' then
               DAV <= '0';
               cnt_bit <= 0;
               reg <=(others => '0');
               CLEAR_FDIV <= '0';
               ERREUR <= '0';
          elsif Rising_edge(CLK) then
               case State is
                    when E1 =>if RX = '0' then
                                   State <= E2;
                                   CLEAR_FDIV <= '1';
                                   DAV <= '0';
                                   ERREUR <= '0';
                              end if;
                    when E2 =>State <= E21;
                              CLEAR_FDIV <= '0';
                    when E21=>if TICK_DEMI_BIT = '1' then
                                   State <= E3;
                              end if;
                    when E3 =>if RX = '1' then
                                   State <= ER;
                                   ERREUR <= '1';
                              elsif RX = '0' then
                                   State <= E4;
                              end if;
                    when E4 =>if TICK_DEMI_BIT = '1' then
                                   State <= E5;
                              end if;
                    when E5 =>if TICK_DEMI_BIT = '1' then
                                   State <= E6;
                                   reg(cnt_bit) <= RX;
                                   cnt_bit <= cnt_bit + 1;
                              end if;
                    when E6 =>if TICK_DEMI_BIT = '1' then
                                   State <= E5;
                              elsif cnt_bit = 8 then
                                   State <= E7;
                              end if;
                    when E7 =>if TICK_DEMI_BIT = '1' then
                                   State <= E8;
                              end if;
                    when E8 =>if TICK_DEMI_BIT = '1' then
                                   State <= E9;
                              end if;
                    when E9 =>if RX = '0' then
                                   State <= ER;
                                   ERREUR <= '1';
                              else
                                   State <= E10;
                                   DATA <= reg;
                                   DAV <= '1';
                              end if;
                    when E10=>State <= E1;
                              cnt_bit <= 0;
                    when ER =>State <= E1;
                              cnt_bit <= 0;
            end case;
        end if;
    end process;
end architecture;