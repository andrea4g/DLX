library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;
use work.all;

entity alu is
  generic(n : integer := 2);
  port (
    a, b      : in  std_logic_vector(n - 1 downto 0);
    unit_sel  : in  std_logic_vector(2 downto 0);
    cout      : out std_logic;
    z         : out std_logic;
    y         : out std_logic_vector(n - 1 downto 0)
  );
end entity;

architecture structural of alu is

  component barrel_shifter_left is
    generic(
      n : integer := 2  -- number of bits
    );
    port(
      -- Inputs
      x   : in  std_logic_vector(n - 1 downto 0);
      pos : in  std_logic_vector(log2(n) - 1 downto 0); -- number of shifts
      -- Outputs
      y   : out std_logic_vector(n - 1 downto 0)
    );
  end component;

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

  component p4 is
    generic(n : integer := 4);
    port (
      -- inputs
      a, b : in  std_logic_vector(n - 1 downto 0);
      cin  : in std_logic;
      -- outputs
      s    : out std_logic_vector(n - 1 downto 0);
      cout : out std_logic
    );
  end component;

  component branch_unit is
    generic(
      n : integer := 2
    );
    port (
      a, b : in  std_logic_vector(n - 1 downto 0);
      cout : out std_logic;
      z    : out std_logic
    );
  end component;

  component encoder is
    generic(n : integer := 2);
    port (
      out_add     : in  std_logic_vector(n - 1 downto 0);
      out_sub     : in  std_logic_vector(n - 1 downto 0);
      out_sl      : in  std_logic_vector(n - 1 downto 0);
      out_sr      : in  std_logic_vector(n - 1 downto 0);
      sel         : in  std_logic_vector(2 downto 0);
      o           : out std_logic_vector(n - 1 downto 0)
    );
  end component;

  component xor_2 is
    port(
      a, b : in  std_logic;
      y    : out std_logic
    );
  end component;

  signal out_add, out_sub, out_sl, out_sr : std_logic_vector(n - 1 downto 0);
  signal type_sr                          : std_logic;
  signal pos_s                            : std_logic_vector(log2(n) downto 0) := b(log2(n) downto 0);

begin

  add : p4
  generic map(n)
  port map(a, b, '0', out_add);

  sub : p4
  generic map(n)
  port map(a, b, '0', out_sub);

  sl : barrel_shifter_left
  generic map(n)
  port map(a, pos_s, out_sl);

  sr : barrel_shifter_right
  generic map(n)
  port map(a, pos_s, type_sr, out_sl);

  bu : branch_unit
  generic map(n)
  port map(a, b, cout, z);

  sh : xor_2
  port map(unit_sel(2), unit_sel(0), type_sr);

  enc : encoder
  generic map(n)
  port map(out_add, out_sub, out_sl, out_sr, unit_sel, y);

end architecture;
