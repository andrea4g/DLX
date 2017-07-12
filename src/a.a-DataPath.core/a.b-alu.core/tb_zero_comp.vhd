library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity tb_zero_comp is
end entity; -- tb_zero_comp


architecture test_zero_comp of tb_zero_comp is

  component zero_comp is
    generic(n : integer := 1);
    port (x : in  std_logic_vector (n - 1 downto 0);
          y : out  std_logic
    );
  end component;

  constant nbit : integer := 8;
  signal tb_x : std_logic_vector(nbit - 1 downto 0);
  signal tb_y : std_logic;

begin

  dut : zero_comp
  generic map(nbit)
  port map(tb_x, tb_y);

  tb_x <= (others => '1'), (others => '0') after 10 ns;

end architecture; -- test_zero_comp
