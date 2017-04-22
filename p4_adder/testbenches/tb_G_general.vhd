library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench of G_general
entity tb_G_general is
end entity;

architecture test_G_general of tb_G_general is

  component G_general is
    port (
      -- Inputs
      gkminj  :  in  std_logic; -- G_{k-1:j}
      --
      gik     :  in  std_logic; -- G_{i:k}
      pik     :  in  std_logic; -- P_{i:k}
      -- Outputs
      gij     :  out std_logic  -- G_{i:j}
    );
  end component;

  -- Inputs tb
  signal tb_gkminj, tb_gik, tb_pik : std_logic := '0';
  -- Output tb
  signal tb_gij                    : std_logic;

begin

  dut : G_general
  port map(tb_gkminj, tb_gik, tb_pik, tb_gij);

  --tb_process_G_general : process
  --begin

    tb_gkminj <= not tb_gkminj after 5 ns;
    tb_gik    <= not tb_gik    after 10 ns;
    tb_pik    <= not tb_pik    after 20 ns;
    --wait for 50 ns;

  --end process;

end architecture;
