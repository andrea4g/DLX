library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench of sparse_tree_carry_gen
entity tb_sparse_tree_carry_gen is
end entity;

architecture test_sparse_tree_carry_gen of tb_sparse_tree_carry_gen is

  constant n4  : integer := 4;
  constant n8  : integer := 8;
  constant n16 : integer := 16;
  constant n32 : integer := 32;
  constant n64 : integer := 64;

  component sparse_tree_carry_gen is
    generic(n : integer := 4);
    port (
      -- inputs
      a, b : in  std_logic_vector(n - 1 downto 0);
      -- outputs
      c    : out std_logic_vector(n - 1 downto 0)
    );
  end component;

  signal tb_a4, tb_b4    : std_logic_vector (n4  - 1 downto 0) := (others => '0');
  signal tb_c4 : std_logic_vector (n4  - 1 downto 0) := (others => '0');
  signal tb_a8, tb_b8, tb_c8    : std_logic_vector (n8  - 1 downto 0) := (others => '0');
  signal tb_a16, tb_b16, tb_c16 : std_logic_vector (n16 - 1 downto 0) := (others => '0');
  signal tb_a32, tb_b32, tb_c32 : std_logic_vector (n32 - 1 downto 0) := (others => '0');
  signal tb_a64, tb_b64, tb_c64 : std_logic_vector (n64 - 1 downto 0) := (others => '0');

begin

  dut4 : sparse_tree_carry_gen
  generic map(n4)
  port map(tb_a4, tb_b4, tb_c4);

  tb_sparse_tree_carry_gen_process4 : process
  begin

    -- 0000 - 0000 => c4 = 0
    -- 0000 - 1111 => c4 = 0
    -- 1111 - 1111 => c4 = 1
    tb_a4 <= "0000", "0000" after 10 ns, "1111" after 20 ns;
    tb_b4 <= "0000", "1111" after 10 ns, "1111" after 20 ns;
    wait for 50 ns;

  end process;

  dut8 : sparse_tree_carry_gen
  generic map(n8)
  port map(tb_a8, tb_b8, tb_c8);

  tb_sparse_tree_carry_gen_process8 : process
  begin

    -- 00000000 - 00000000 => c4 = 0 c8 = 0
    -- 00000000 - 11111111 => c4 = 0 c8 = 0
    -- 11111111 - 11111111 => c4 = 1 c8 = 1
    tb_a8 <= "00000000", "00000000" after 10 ns, "11111111" after 20 ns;
    tb_b8 <= "00000000", "11111111" after 10 ns, "11111111" after 20 ns;
    wait for 50 ns;

  end process;

  dut16 : sparse_tree_carry_gen
  generic map(n16)
  port map(tb_a16, tb_b16, tb_c16);

  tb_sparse_tree_carry_gen_process16 : process
  begin

    -- 0000000000000000 - 0000000000000000 => c4 = 0 | c8 = 0 | c12 = 0 | c16 = 0
    -- 0000000000000000 - 1111111111111111 => c4 = 0 | c8 = 0 | c12 = 0 | c16 = 0
    -- 1111111111111111 - 1111111111111111 => c4 = 1 | c8 = 1 | c12 = 1 | c16 = 1
    tb_a16 <= "0000000000000000", "0000000000000000" after 10 ns, "1111111111111111" after 20 ns;
    tb_b16 <= "0000000000000000", "1111111111111111" after 10 ns, "1111111111111111" after 20 ns;
    wait for 50 ns;

  end process;

  dut32 : sparse_tree_carry_gen
  generic map(n32)
  port map(tb_a32, tb_b32, tb_c32);

  tb_sparse_tree_carry_gen_process32 : process
  begin

    -- 00000000000000000000000000000000 - 00000000000000000000000000000000 => c4 = 0 | c8 = 0 | c12 = 0 | c16 = 0 | c20 = 0 | c24 = 0 | c28 = 0 | c32 = 0
    -- 00000000000000000000000000000000 - 11111111111111111111111111111111 => c4 = 0 | c8 = 0 | c12 = 0 | c16 = 0 | c20 = 0 | c24 = 0 | c28 = 0 | c32 = 0
    -- 11111111111111111111111111111111 - 11111111111111111111111111111111 => c4 = 1 | c8 = 1 | c12 = 1 | c16 = 1 | c20 = 1 | c24 = 1 | c28 = 1 | c32 = 1
    tb_a32 <= "00000000000000000000000000000000", "00000000000000000000000000000000" after 10 ns, "11111111111111111111111111111111" after 20 ns;
    tb_b32 <= "00000000000000000000000000000000", "11111111111111111111111111111111" after 10 ns, "11111111111111111111111111111111" after 20 ns;
    wait for 50 ns;

  end process;

  dut64 : sparse_tree_carry_gen
  generic map(n64)
  port map(tb_a64, tb_b64, tb_c64);

  tb_sparse_tree_carry_gen_process64 : process
  begin

    -- "0" - "0" -> all '0'
    -- "0" - "1" -> all '0'
    -- "1" - "1" -> all '0'
    tb_a64 <= "0000000000000000000000000000000000000000000000000000000000000000", "0000000000000000000000000000000000000000000000000000000000000000" after 10 ns, "1111111111111111111111111111111111111111111111111111111111111111" after 20 ns;
    tb_b64 <= "0000000000000000000000000000000000000000000000000000000000000000", "1111111111111111111111111111111111111111111111111111111111111111" after 10 ns, "1111111111111111111111111111111111111111111111111111111111111111" after 20 ns;
    wait for 50 ns;

  end process;

end architecture;
