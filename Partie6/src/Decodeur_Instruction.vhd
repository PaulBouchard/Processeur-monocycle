library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Decodeur_Instruction is
port(
    instruction : in std_logic_vector(31 downto 0);
    flags : in std_logic_vector(31 downto 0);

    npcsel : out std_logic;
    RegWr : out std_logic;
    ALUsrc : out std_logic;
    ALUctrl : out std_logic_vector(2 downto 0);
    PSREn : out std_logic;
    MemWr : out std_logic;
    WrSrc : out std_logic;
    RegSel : out std_logic;
    RegAff : out std_logic;
    imm8 : out std_logic_vector(7 downto 0);
    imm24 : out std_logic_vector(23 downto 0);
    irq_end : out std_logic);
end entity;

architecture RTL of Decodeur_Instruction is
    type enum_instruction is (MOV, ADDi, ADDr, CMP, LDR, STR, BAL, BLT, BX);
    signal instr_courante: enum_instruction;
    signal test : integer;
begin
    InstCourValue: process(instruction)
    begin
        case instruction(31 downto 20) is
            when "111000101000" => instr_courante <= ADDi;        -- ADDi
            when "111000001000" => instr_courante <= ADDr;        -- ADDr
            when "111000111010" => instr_courante <= MOV;         -- MOV
            when "111000110101" => instr_courante <= CMP;         -- CMP
            when "111001100001" => instr_courante <= LDR;         -- LDR
            when "111001100000" => instr_courante <= STR;         -- STR
            when "111010110000" => instr_courante <= BX;
            when others => test <= 0;
        end case;
        if test = 0 then
            case instruction(31 downto 24) is
                when "11101010" => instr_courante <= BAL;         -- BAL
                when "10111010" => instr_courante <= BLT;         -- BLT
                when others => test <= 0;
            end case;
        end if;
    end process;

    InstCmdValue: process(instruction,instr_courante)
    begin
        case instr_courante is
            when ADDi =>npcsel <= '0';
                        RegWr <= '1';
                        ALUsrc <= '1';
                        ALUctrl <= "000";
                        PSREn <= '1';
                        MemWr <= '0';
                        WrSrc <= '0';
                        RegSel <= '0';
                        RegAff <= '0';
                        imm8 <= instruction(7 downto 0);
                        imm24 <= (others => '0');
                        irq_end <= '0';

            when ADDr =>npcsel <= '0';
                        RegWr <= '1';
                        ALUsrc <= '0';
                        ALUctrl <= "000";
                        PSREn <= '1';
                        MemWr <= '0';
                        WrSrc <= '0';
                        RegSel <= '0';
                        RegAff <= '0';
                        imm8 <= (others => '0');
                        imm24 <= (others => '0');
                        irq_end <= '0';

            when MOV => npcsel <= '0';
                        RegWr <= '1';
                        ALUsrc <= '1';
                        ALUctrl <= "001";
                        PSREn <= '0';
                        MemWr <= '0';
                        WrSrc <= '0';
                        RegSel <= '0';
                        RegAff <= '0';
                        imm8 <= instruction(7 downto 0);
                        imm24 <= (others => '0');
                        irq_end <= '0';

            when CMP => npcsel <= '0';
                        RegWr <= '0';
                        ALUsrc <= '1';
                        ALUctrl <= "010";
                        PSREn <= '1';
                        MemWr <= '0';
                        WrSrc <= '0';
                        RegSel <= '0';
                        RegAff <= '0';
                        imm8 <= instruction(7 downto 0);
                        imm24 <= (others => '0');
                        irq_end <= '0';

            when LDR => npcsel <= '0';
                        RegWr <= '1';
                        ALUsrc <= '0';
                        ALUctrl <= "011";
                        PSREn <= '0';
                        MemWr <= '0';
                        WrSrc <= '1';
                        RegSel <= '0';
                        RegAff <= '0';
                        imm8 <= (others => '0');
                        imm24 <= (others => '0');
                        irq_end <= '0';

            when STR => npcsel <= '0';
                        RegWr <= '0';
                        ALUsrc <= '0';
                        ALUctrl <= "011";
                        PSREn <= '0';
                        MemWr <= '1';
                        WrSrc <= '0';
                        RegSel <= '1';
                        RegAff <= '1';
                        imm8 <= (others => '0');
                        imm24 <= (others => '0');
                        irq_end <= '0';

            when BAL => npcsel <= '1';
                        RegWr <= '0';
                        ALUsrc <= '0';
                        ALUctrl <= "000";
                        PSREn <= '0';
                        MemWr <= '0';
                        WrSrc <= '0';
                        RegSel <= '0';
                        RegAff <= '0';
                        imm8 <= (others => '0');
                        imm24 <= instruction(23 downto 0);
                        irq_end <= '0';

            when BLT => if flags(31) = '1' then
                            npcsel <= '1';
                            RegWr <= '0';
                            ALUsrc <= '0';
                            ALUctrl <= "000";
                            PSREn <= '0';
                            MemWr <= '0';
                            WrSrc <= '0';
                            RegSel <= '0';
                            RegAff <= '0';
                            imm8 <= (others => '0');
                            imm24 <= instruction(23 downto 0);
                            irq_end <= '0';

                        else
                            npcsel <= '0';
                            RegWr <= '0';
                            ALUsrc <= '0';
                            ALUctrl <= "000";
                            PSREn <= '0';
                            MemWr <= '0';
                            WrSrc <= '0';
                            RegSel <= '0';
                            RegAff <= '0';
                            imm8 <= (others => '0');
                            imm24 <= (others => '0');
                            irq_end <= '0';
                        end if;

            when BX =>  npcsel <= '0';
                        RegWr <= '0';
                        ALUsrc <= '0';
                        ALUctrl <= "000";
                        PSREn <= '0';
                        MemWr <= '0';
                        WrSrc <= '0';
                        RegSel <= '0';
                        RegAff <= '0';
                        imm8 <= (others => '0');
                        imm24 <= (others => '0');
                        irq_end <= '1';

            when others => npcsel <= '0';
                           RegWr <= '0';
                           ALUsrc <= '0';
                           ALUctrl <= "000";
                           PSREn <= '0';
                           MemWr <= '0';
                           WrSrc <= '0';
                           RegSel <= '0';
                           RegAff <= '0';
                           imm8 <= (others => '0');
                           imm24 <= (others => '0');
                           irq_end <= '0';

        end case;
    end process;
end architecture;
