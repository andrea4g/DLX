library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity tb_and_n1 is
end entity;

architecture test_and_n1 of tb_and_n1 is

  component and_n1 is
    generic(n : integer := 2);
    port(a : in  std_logic_vector(n - 1 downto 0);
         y : out std_logic
        );
  end component;

  constant nbit : integer := 8;

  signal tb_a : std_logic_vector(nbit - 1 downto 0);
  signal tb_y : std_logic;

begin

  dut : and_n1
  generic map(nbit)
  port map(tb_a, tb_y);

  tb_a <= (others => '0'), (others => '1') after 10 ns;

end architecture;
