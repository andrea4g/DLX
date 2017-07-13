library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;
use work.all;

entity tb_barrel_shifter_left is
end entity;

architecture test_barrel_shifter_left of tb_barrel_shifter_left is

  component barrel_shifter_left is
    generic(
      n : integer := 2  -- number of bits
    );
    port(
      -- Inputs
      x   : in  std_logic_vector(n - 1 downto 0);
      --dir : in  std_logic;                            -- if 0 shift left, if 1 shift right
      pos : in  std_logic_vector(log2(n) - 1 downto 0); -- number of shifts
      -- Outputs
      y   : out std_logic_vector(n - 1 downto 0)
    );
  end component;

  constant nbit : integer := 4;

  signal tb_x, tb_y : std_logic_vector(nbit - 1 downto 0);
  signal tb_pos     : std_logic_vector(log2(nbit) - 1 downto 0);

begin

  dut : barrel_shifter_left
  generic map(nbit)
  port map(tb_x, tb_pos, tb_y);

  tb_x   <= "1111";
  tb_pos <= "11";

end architecture;
