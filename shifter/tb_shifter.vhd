library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity tb_shifter is
end entity;

architecture test_shifter of tb_shifter is

  component shifter is
    generic(
      n : integer := 2;   -- number of bits
      p : integer := 5   -- number of bits for the signal that carries the number of shifts
    );
    port(
      -- Inputs
      x   : in  std_logic_vector(n - 1 downto 0);
      dir : in  std_logic;                        -- if 0 shift left, if 1 shift right
      pos : in  std_logic_vector(p - 1 downto 0); -- number of shifts
      -- Outputs
      y   : out std_logic_vector(n - 1 downto 0)
    );
  end component;

  constant n : integer := 4;
  constant p : integer := 2;

  signal tb_x, tb_y : std_logic_vector(n - 1 downto 0);
  signal tb_pos     : std_logic_vector(p - 1 downto 0);
  signal tb_dir     : std_logic;

begin

  dut : shifter
  generic map(n, p)
  port map(tb_x, tb_dir, tb_pos, tb_y);

end architecture;
