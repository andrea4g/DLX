library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;

-- testbench of carry block select
entity tb_carry_block_select is
end entity;

architecture test_carry_block_select of tb_carry_block_select is

  constant n : integer := 4;

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

  signal tb_a, tb_b, tb_s : std_logic_vector(n - 1 downto 0);
  signal tb_cin           : std_logic;

begin

  dut : carry_select_block
  generic map(n)
  port map(tb_a, tb_b, tb_cin, tb_s);

  tb_process_carry_select_block : process
  begin

    tb_cin <= '0';
    for i in 0 to pow2(n) - 1 loop
      for j in 0 to pow2(n) - 1 loop
        tb_a <= std_logic_vector(to_unsigned(j, n));
        tb_b <= std_logic_vector(to_unsigned(i, n));
        wait for 5 ns;
      end loop;
    end loop;

    tb_cin <= '1';
    for i in 0 to pow2(n) - 1 loop
      for j in 0 to pow2(n) - 1 loop
        tb_a <= std_logic_vector(to_unsigned(j, n));
        tb_b <= std_logic_vector(to_unsigned(i, n));
        wait for 5 ns;
      end loop;
    end loop;

  end process;

end architecture;
