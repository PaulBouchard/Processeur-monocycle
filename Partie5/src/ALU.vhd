library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
port(
	A,B : in STD_LOGIC_VECTOR(31 downto 0);
  OP : in std_logic_vector(2 downto 0);
  SUM : out STD_LOGIC_VECTOR(31 downto 0);
  N,Z,C,V : out std_logic);
end entity ALU;

architecture RTL of ALU is
  signal SUMINTER : std_logic_vector(31 downto 0);
begin
  with OP select
    SUMINTER <= std_logic_vector(signed(A) + signed(B)) when "000",
           B when "001",
           std_logic_vector(signed(A) - signed(B)) when "010",
           A when "011",
           A or B when "100",
           A and B when "101",
           A xor B when "110",
           not(A) when "111",
           (others => '0') when others;

  SUM <= SUMINTER;

  N <= '1' when (to_integer(signed(SUMINTER)) < 0) else '0';

  with SUMINTER select
    Z <= '1' when x"00000000",
         '0' when others;

  C <= '0';

  V <= '1' when ((A(31) = B(31)) and (SUMINTER(31) /= A(31))) else '0';
end architecture;