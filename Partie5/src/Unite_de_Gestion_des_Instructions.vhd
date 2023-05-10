library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Unite_de_Gestion_des_Instructions is port(
    CLK,RST : in std_logic;
    NPCSEL : in std_logic;
    OFFSET : in std_logic_vector(23 downto 0);

    INSTRUCTION : out std_logic_vector(31 downto 0));
END entity Unite_de_Gestion_des_Instructions;


architecture RTL of Unite_de_Gestion_des_Instructions is
    signal PCOUT,OFFSETOUT,MUX0,MUX1,MUXOUT : std_logic_vector(31 downto 0);
begin

    PE : entity work.Extende_generic(RTL)
        generic map(24)
        port map(OFFSET,OFFSETOUT);

    MUX0 <= std_logic_vector(unsigned(PCOUT) + to_unsigned(1,32));
    MUX1 <= std_logic_vector(unsigned(PCOUT) + unsigned(OFFSETOUT) + to_unsigned(1,32));

    M1 : entity work.Mux2v1_generic(RTL)
        generic map(32)
        port map(MUX0,MUX1,NPCSEL,MUXOUT);

    R : entity work.Reg_PC(RTL)
        port map(CLK,RST,MUXOUT,PCOUT);

    IM : entity work.Instruction_Memory(RTL)
        port map(PCOUT,INSTRUCTION);
end architecture;