library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FDIV is
port(CLK,RST : IN STD_LOGIC;
     TICK_BIT : OUT STD_LOGIC);
end entity FDIV;

architecture RTL of FDIV is
     signal tick : std_logic;
begin
     process(CLK, RST)
     variable cnt : integer;
     begin
          if RST = '1' then
               tick <= '0';
               cnt := 0;
          elsif Rising_edge(CLK) then
               cnt := cnt + 1;
               if cnt = 50000000/115200 -1 then
                    tick <= '1';
                    cnt := 0;
               else
                    tick <= '0';
               end if;
          end if;
     end process;

     TICK_BIT <= tick;
end architecture;