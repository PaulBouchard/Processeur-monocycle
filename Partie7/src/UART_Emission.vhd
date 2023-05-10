library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UART_Emission is
port(CLK,RST : IN STD_LOGIC;
     GO : IN STD_LOGIC;
     DATA : IN std_logic_vector(7 downto 0);

     TX : OUT STD_LOGIC;
     txlrq : out std_logic);
end entity UART_Emission;

architecture RTL of UART_Emission is
     signal tick_bit : std_logic;
     signal DATAOUT : std_logic_vector(31 downto 0);
     signal DATAINTER : std_logic_vector(31 downto 0);
begin
     DATAINTER <= "000000000000000000000000" & DATA;

     UCONF : entity work.UART_Conf(RTL)
          port map(CLK,RST,GO,DATAINTER,DATAOUT);

     TCK : entity work.FDIV(RTL)
        port map(CLK,RST,tick_bit);

     UTX : entity work.UARTTX(RTL)
        port map(CLK,RST,tick_bit,GO,DATAOUT(7 downto 0),TX,txlrq);
end architecture;