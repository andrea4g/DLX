library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_p4 is
end entity;

architecture test_tb_p4 of tb_p4 is

  constant n4   : integer := 4;
  constant n8   : integer := 8;
  constant n16  : integer := 16;
  constant n32  : integer := 32;
  constant n64  : integer := 64;
  constant n128 : integer := 128;

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

  signal tb_a4,  tb_b4,  tb_s4     : std_logic_vector (n4  - 1 downto 0) := (others => '0');
  signal tb_cin4, tb_cout4         : std_logic := '0';

  signal tb_a8,  tb_b8,  tb_s8     : std_logic_vector (n8  - 1 downto 0) := (others => '0');
  signal tb_cin8, tb_cout8         : std_logic := '0';

  signal tb_a16, tb_b16, tb_s16    : std_logic_vector (n16 - 1 downto 0) := (others => '0');
  signal tb_cin16, tb_cout16       : std_logic := '0';

  signal tb_a32, tb_b32, tb_s32    : std_logic_vector (n32 - 1 downto 0) := (others => '0');
  signal tb_cin32, tb_cout32       : std_logic := '0';

  signal tb_a64, tb_b64, tb_s64    : std_logic_vector (n64 - 1 downto 0) := (others => '0');
  signal tb_cin64, tb_cout64       : std_logic := '0';

  signal tb_a128, tb_b128, tb_s128 : std_logic_vector (n128 - 1 downto 0) := (others => '0');
  signal tb_cin128, tb_cout128     : std_logic := '0';

begin
  ------------------------------------------------------------------------------
  -- 4-bit
  dut4 : p4
  generic map(n4)
  port map(tb_a4, tb_b4, tb_cin4, tb_s4, tb_cout4);

  tb_sparse_tree_carry_gen_process4 : process
  begin

    tb_a4 <= "0000", "0000" after 10 ns, "1000" after 20 ns, "1111" after 30 ns;
    tb_b4 <= "0000", "1111" after 10 ns, "1111" after 20 ns, "1111" after 30 ns;
    wait for 50 ns;

  end process;

  ------------------------------------------------------------------------------
  -- 8-bit
  dut8 : p4
  generic map(n8)
  port map(tb_a8, tb_b8, tb_cin8, tb_s8, tb_cout8);

  tb_sparse_tree_carry_gen_process8 : process
  begin

    tb_a8 <= "00000000", "00000000" after 10 ns, "10000000" after 20 ns, "11111111" after 30 ns;
    tb_b8 <= "00000000", "11111111" after 10 ns, "11111111" after 20 ns, "11111111" after 30 ns;
    wait for 50 ns;

  end process;

  ------------------------------------------------------------------------------
  -- 16-bit
  dut16 : p4
  generic map(n16)
  port map(tb_a16, tb_b16, tb_cin16, tb_s16, tb_cout16);

  tb_sparse_tree_carry_gen_process16 : process
  begin

    tb_a16 <= "0000000000000000", "0000000000000000" after 10 ns, "1000000000000000" after 20 ns, "1111111111111111" after 30 ns;
    tb_b16 <= "0000000000000000", "1111111111111111" after 10 ns, "1111111111111111" after 20 ns, "1111111111111111" after 30 ns;
    wait for 50 ns;

  end process;

  ------------------------------------------------------------------------------
  -- 32-bit
  dut32 : p4
  generic map(n32)
  port map(tb_a32, tb_b32, tb_cin32, tb_s32, tb_cout32);

  tb_sparse_tree_carry_gen_process32 : process
  begin

    tb_a32 <= "00000000000000000000000000000000", "00000000000000000000000000000000" after 10 ns, "10000000000000000000000000000000" after 20 ns, "11111111111111111111111111111111" after 30 ns;
    tb_b32 <= "00000000000000000000000000000000", "11111111111111111111111111111111" after 10 ns, "11111111111111111111111111111111" after 20 ns, "11111111111111111111111111111111" after 30 ns;
    wait for 50 ns;

  end process;

  ------------------------------------------------------------------------------
  -- 64-bit
  dut64 : p4
  generic map(n64)
  port map(tb_a64, tb_b64, tb_cin64, tb_s64, tb_cout64);

  tb_sparse_tree_carry_gen_process64 : process
  begin

    tb_a64 <= "0000000000000000000000000000000000000000000000000000000000000000", "0000000000000000000000000000000000000000000000000000000000000000" after 10 ns, "1000000000000000000000000000000000000000000000000000000000000000" after 20 ns, "1111111111111111111111111111111111111111111111111111111111111111" after 30 ns;
    tb_b64 <= "0000000000000000000000000000000000000000000000000000000000000000", "1111111111111111111111111111111111111111111111111111111111111111" after 10 ns, "1111111111111111111111111111111111111111111111111111111111111111" after 20 ns, "1111111111111111111111111111111111111111111111111111111111111111" after 30 ns;
    wait for 50 ns;

  end process;

  ------------------------------------------------------------------------------
  -- 128-bit
  dut128 : p4
  generic map(n128)
  port map(tb_a128, tb_b128, tb_cin128, tb_s128, tb_cout128);

  tb_sparse_tree_carry_gen_process128: process
  begin

    tb_a128 <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" after 10 ns, "10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" after 20 ns,  "11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" after 30 ns;
    tb_b128 <= "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", "11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" after 10 ns, "11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" after 20 ns,  "11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111" after 30 ns;
    wait for 50 ns;

  end process;

end architecture;
