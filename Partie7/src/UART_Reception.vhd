library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity UART_Reception is
port(CLK,RST : IN STD_LOGIC;
     RX : IN STD_LOGIC;

     DATA : OUT std_logic_vector(7 downto 0);
     ERREUR,DAV : OUT STD_LOGIC);
end entity UART_Reception;

architecture RTL of UART_Reception is
     signal tick_demi_bit,clear_fdiv,davi : std_logic;
     signal datain : std_logic_vector(7 downto 0);
     signal data32,dataout : std_logic_vector(31 downto 0);
begin
     TCKR : entity work.FDIV_Recep(RTL)
        port map(CLK,clear_fdiv,tick_demi_bit);

     URX : entity work.UARTRX(RTL)
        port map(CLK,RST,tick_demi_bit,RX,datain,clear_fdiv,davi,ERREUR);

     DAV <= davi;
     data32 <= "000000000000000000000000" & datain;

     UCONF2 : entity work.UART_Conf(RTL)
        port map(CLK,RST,davi,data32,dataout);

     DATA <= dataout(7 downto 0);
end architecture;