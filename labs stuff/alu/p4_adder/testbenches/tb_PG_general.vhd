library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench of PG_general
entity tb_PG_general is
end entity;

architecture test_PG_general of tb_PG_general is

  component PG_general is
    port (
      -- Inputs
      gkminj  :  in  std_logic; -- G_{k-1:j}
      pkminj  :  in  std_logic; -- P_{k-1:j}
      --
      gik     :  in  std_logic; -- G_{i:k}
      pik     :  in  std_logic; -- P_{i:k}
      -- Outputs
      gij     :  out std_logic; -- G_{i:j}
      pij     :  out std_logic  -- P_{i:j}
    );
  end component;

  -- Inputs tb
  signal tb_gkminj, tb_pkminj, tb_gik, tb_pik : std_logic := '0';
  -- Outputs tb
  signal tb_gij, tb_pij                       : std_logic;

begin

  dut : PG_general
  port map(tb_gkminj, tb_pkminj, tb_gik, tb_pik, tb_gij, tb_pij);

  tb_process_PG_general : process
  begin

    tb_gkminj <= not tb_gkminj after 5 ns;
    tb_pkminj <= not tb_pkminj after 10 ns;
    tb_gik    <= not tb_gik    after 20 ns;
    tb_pik    <= not tb_pik    after 40 ns;
    wait for 50 ns;

  end process;

end architecture;
