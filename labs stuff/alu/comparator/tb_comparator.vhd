library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity tb_comparator is
end entity;

architecture test_comparator of tb_comparator is

  component comparator is
    generic(
      n : integer := 2
    );
    port (
      a, b : in  std_logic_vector(n - 1 downto 0);
      cout : out std_logic;
      z    : out std_logic
    );
  end component;

  constant nbit : integer := 4;

  signal tb_a, tb_b    : std_logic_vector(nbit - 1 downto 0);
  signal tb_cout, tb_z : std_logic;

begin

  dut : comparator
  generic map(nbit)
  port map(tb_a, tb_b, tb_cout, tb_z);

  --      a > b               a < b                        a = b
  tb_a <= std_logic_vector(to_unsigned(5, tb_a'length)), std_logic_vector(to_unsigned(2, tb_a'length)) after 5 ns, std_logic_vector(to_unsigned(3, tb_a'length)) after 10 ns;--, std_logic_vector() after ns;
  tb_b <= std_logic_vector(to_unsigned(2, tb_b'length)), std_logic_vector(to_unsigned(5, tb_b'length)) after 5 ns, std_logic_vector(to_unsigned(3, tb_b'length)) after 10 ns;--, std_logic_vector() after ns;

end architecture;
