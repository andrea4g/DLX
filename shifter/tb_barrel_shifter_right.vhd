library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;
use work.all;

entity tb_barrel_shifter_right is
end entity;

architecture test_barrel_shifter_right of tb_barrel_shifter_right is

  component barrel_shifter_right is
    generic(
      n : integer := 2
    );
    port (
      -- Inputs
      x          : in  std_logic_vector(n - 1 downto 0);
      pos        : in  std_logic_vector(log2(n) - 1 downto 0); -- number of shifts
      shift_type : in  std_logic;                              -- logic or arithmetic
      -- Outputs
      y          : out std_logic_vector(n - 1 downto 0)
    );
  end component;

  constant nbit : integer := 4;

  signal tb_x, tb_y : std_logic_vector(nbit - 1 downto 0);
  signal tb_pos     : std_logic_vector(log2(nbit) - 1 downto 0);

begin

  dut : barrel_shifter_right
  generic map(nbit)
  port map(tb_x, tb_pos, '0', tb_y);

  tb_x   <= "1111";
  tb_pos <= "11";

end architecture;
