library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_sum_generator is
end entity;

architecture test_tb_sum_generator of tb_sum_generator is

  component sum_generator is
    generic(n : integer := 4);
    port (
      -- inputs
      a, b, c : in  std_logic_vector(n - 1 downto 0);
      cin     : in  std_logic;
      -- outputs
      s    : out std_logic_vector(n - 1 downto 0);
      cout : out std_logic
    );
  end component;

  constant n4  : integer := 4;
  constant n8  : integer := 8;
  constant n16 : integer := 16;
  constant n32 : integer := 32;
  constant n64 : integer := 64;

  signal tb_a4, tb_b4, tb_c4 : std_logic_vector(n4 - 1 downto 0) := (others => '0');
  signal tb_cin4             : std_logic := '0';
  signal tb_s4               : std_logic_vector(n4 - 1 downto 0) := (others => '0');
  signal tb_cout4            : std_logic := '0';

  signal tb_a8, tb_b8, tb_c8 : std_logic_vector(n8 - 1 downto 0) := (others => '0');
  signal tb_cin8             : std_logic := '0';
  signal tb_s8               : std_logic_vector(n8 - 1 downto 0) := (others => '0');
  signal tb_cout8            : std_logic := '0';

  signal tb_a16, tb_b16, tb_c16 : std_logic_vector(n16 - 1 downto 0) := (others => '0');
  signal tb_cin16               : std_logic := '0';
  signal tb_s16                 : std_logic_vector(n16 - 1 downto 0) := (others => '0');
  signal tb_cout16              : std_logic := '0';

  signal tb_a32, tb_b32, tb_c32 : std_logic_vector(n32 - 1 downto 0) := (others => '0');
  signal tb_cin32               : std_logic := '0';
  signal tb_s32                 : std_logic_vector(n32 - 1 downto 0) := (others => '0');
  signal tb_cout32              : std_logic := '0';

begin

  dut4 : sum_generator
  generic map(n4)
  port map(tb_a4, tb_b4, tb_c4, tb_cin4, tb_s4, tb_cout4);

  tb_sparse_tree_carry_gen_process4 : process
  begin

    tb_cin4 <= '0';
    tb_a4 <= "0000", "0000" after 10 ns, "1111" after 20 ns;
    tb_b4 <= "0000", "1111" after 10 ns, "1111" after 20 ns;
    wait for 50 ns;
    tb_cin4 <= '1';
    tb_a4 <= "0000", "0000" after 10 ns, "1111" after 20 ns;
    tb_b4 <= "0000", "1111" after 10 ns, "1111" after 20 ns;
    wait for 50 ns;
    tb_c4 <= "0001";
    tb_cin4 <= '0';
    tb_a4 <= "0000", "0000" after 10 ns, "1111" after 20 ns;
    tb_b4 <= "0000", "1111" after 10 ns, "1111" after 20 ns;
    wait for 50 ns;

  end process;

  dut8 : sum_generator
  generic map(n8)
  port map(tb_a8, tb_b8, tb_c8, tb_cin8, tb_s8, tb_cout8);

  tb_sparse_tree_carry_gen_process8 : process
  begin

    tb_cin8 <= '0';
    tb_a8 <= "00000000", "00000000" after 10 ns, "11111111" after 20 ns;
    tb_b8 <= "00000000", "11111111" after 10 ns, "11111111" after 20 ns;
    wait for 50 ns;
    tb_cin8 <= '1';
    tb_a8 <= "00000000", "00000000" after 10 ns, "11111111" after 20 ns;
    tb_b8 <= "00000000", "11111111" after 10 ns, "11111111" after 20 ns;
    wait for 50 ns;
    tb_cin8 <= '0';
    tb_c8 <= "00000011";
    tb_a8 <= "00000000", "00000000" after 10 ns, "11111111" after 20 ns;
    tb_b8 <= "00000000", "11111111" after 10 ns, "11111111" after 20 ns;
    wait for 50 ns;

  end process;

end architecture;
