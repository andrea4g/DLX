library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_PG_network is
end entity;

architecture test_PG_network of tb_PG_network is

  constant n : integer := 4;

  component PG_network is
    generic(n : integer := 4);
    port (
      -- Inputs
      a_n     :  in  std_logic_vector(n - 1 downto 0);
      b_n     :  in  std_logic_vector(n - 1 downto 0);
      -- Outputs
      g_n     :  out std_logic_vector(n - 1 downto 0);
      p_n     :  out std_logic_vector(n - 1 downto 0)
    );
  end component;

  signal tb_a_n, tb_b_n : std_logic_vector(n - 1 downto 0) := (others => '0');
  -- Outputs tb
  signal tb_p_n, tb_g_n : std_logic_vector(n - 1 downto 0);

begin

  dut : PG_network
  generic map(n)
  port map(tb_a_n, tb_b_n, tb_g_n, tb_p_n);

  tb_process_PG_network : process
  begin

    for i in 0 to n - 1 loop
      for j in 0 to n - 1 loop
        tb_a_n <= std_logic_vector(to_unsigned(j, n));
        tb_b_n <= std_logic_vector(to_unsigned(i, n));
        wait for 50 ns;
      end loop;
    end loop;

  end process;

end architecture;
