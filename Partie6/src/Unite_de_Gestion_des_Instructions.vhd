library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Unite_de_Gestion_des_Instructions is port(
    CLK,RST : in std_logic;
    NPCSEL : in std_logic;
    OFFSET : in std_logic_vector(23 downto 0);
    IRQ : IN STD_LOGIC;
    VICPC : IN STD_LOGIC_VECTOR(31 downto 0);
    IRQ_END : IN STD_LOGIC;

    IRQ_SERV : out STD_LOGIC;
    INSTRUCTION : out std_logic_vector(31 downto 0));
END entity Unite_de_Gestion_des_Instructions;


architecture RTL of Unite_de_Gestion_des_Instructions is
    signal PCOUT,OFFSETOUT,MUX0,MUX1,MUXOUT,LROUT,PCIN : std_logic_vector(31 downto 0);
    signal rstinter : std_logic;
begin

    IRQ_SERV <= '1' when IRQ = '1' else '0';

    PE : entity work.Extende_generic(RTL)
        generic map(24)
        port map(OFFSET,OFFSETOUT);

    MUX0 <= std_logic_vector(unsigned(PCOUT) + to_unsigned(1,32));
    MUX1 <= std_logic_vector(unsigned(PCOUT) + unsigned(OFFSETOUT) + to_unsigned(1,32));

    M1 : entity work.Mux2v1_generic(RTL)
        generic map(32)
        port map(MUX0,MUX1,NPCSEL,MUXOUT);

    PCIN <= VICPC when IRQ = '1' else MUXOUT;

    rstinter <= IRQ_END or RST;
    RPC : entity work.Reg_PC(RTL)
        port map(CLK,rstinter,PCIN,PCOUT);

    IM : entity work.Instruction_Memory_IRQ(RTL)
        port map(PCOUT,INSTRUCTION);
end architecture;