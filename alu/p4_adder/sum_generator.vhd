library ieee;
use ieee.std_logic_1164.all;

entity sum_generator is
  generic(n : integer := 4);
  port (
    -- inputs
    a, b, c : in  std_logic_vector(n - 1 downto 0);
    cin     : in  std_logic;
    -- outputs
    s       : out std_logic_vector(n - 1 downto 0);
    cout    : out std_logic
  );
end entity;

architecture structural of sum_generator is

  component carry_select_block is
    generic(n : integer := 4);
    port (
      -- inputs
      a, b : in  std_logic_vector(n - 1 downto 0);
      cin  : in  std_logic;
      -- outputs
      s    : out std_logic_vector(n - 1 downto 0)
    );
  end component;

begin

  carry_select_block_0 : carry_select_block
  generic map(4)
  port map(a(3 downto 0), b(3 downto 0), cin, s(3 downto 0));

  carry_select_block_i : for i in 1 to (n / 4) - 1 generate
  begin

    carry_select_block_i : carry_select_block
    generic map(4)
    port map(
      a((i * 4 + 3) downto (i * 4)),
      b((i * 4 + 3) downto (i * 4)),
      c(i - 1),
      s((i * 4 + 3) downto (i * 4))
    );

  end generate;

  cout <= c((n / 4) - 1);

end architecture;
