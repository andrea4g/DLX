library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity tb_sign_extension is
end entity;

architecture test_sign_extension of tb_sign_extension is

  component sign_extension is
    generic(s : integer := 2; f : integer := 3);
    port(
      x : in  std_logic_vector(s - 1 downto 0);
      y : out std_logic_vector(f - 1 downto 0)
    );
  end component; -- end sign_extension

  --constant stb : integer := 8;
  --constant ftb : integer := 16;

  signal tb_x : std_logic_vector(8 - 1 downto 0);
  signal tb_y : std_logic_vector(16 - 1 downto 0);

begin

  dut : sign_extension
  generic map(8, 16)
  port map(tb_x, tb_y);

  tb_x <= "00001111", "10010111" after 20 ns;

end architecture;
