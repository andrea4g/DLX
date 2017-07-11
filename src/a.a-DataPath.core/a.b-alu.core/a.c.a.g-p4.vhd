library ieee;
use ieee.std_logic_1164.all;

-- n only power of 2 starting from 4
entity p4 is
  generic(n : integer := 4);
  port (
    -- inputs
    a, b : in  std_logic_vector(n - 1 downto 0);
    cin  : in std_logic;
    -- outputs
    s    : out std_logic_vector(n - 1 downto 0);
    cout : out std_logic
  );
end entity;

architecture structural of p4 is

  component sum_generator is
    generic(n : integer := 4);
    port (
      -- inputs
      a, b, c : in  std_logic_vector(n - 1 downto 0);
      cin     : in  std_logic;
      -- outputs
      s       : out std_logic_vector(n - 1 downto 0);
      cout    : out std_logic
    );
  end component;

  component sparse_tree_carry_gen is
    generic(n : integer := 4);
    port (
      -- inputs
      a, b : in  std_logic_vector(n - 1 downto 0);
      -- outputs
      c    : out std_logic_vector(n - 1 downto 0)
    );
  end component;

  signal c_p4    : std_logic_vector(n - 1 downto 0) := (others => '0');

begin

  sparse_tree_carry_gen_p4 : sparse_tree_carry_gen
  generic map(n)
  port map(a, b, c_p4);

  sum_generator_p4 : sum_generator
  generic map(n)
  port map(a, b, c_p4, cin, s, cout);

end architecture;
