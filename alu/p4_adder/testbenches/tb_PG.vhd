library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Testbench of PG
entity tb_PG is
end entity;

architecture test_PG of tb_PG is

  component PG is
    port (
      -- Inputs
      a     :  in  std_logic; -- a_{i}
      b     :  in  std_logic; -- b_{i}
      -- Outputs
      g     :  out std_logic; -- G_{i:j}
      p     :  out std_logic  -- P_{i:j}
    );
  end component;

  -- Inputs tb
  signal tb_a, tb_b : std_logic := '0';
  -- Outputs tb
  signal tb_g, tb_p : std_logic;

begin

  dut : PG
  port map(tb_a, tb_b, tb_g, tb_p);

  tb_process_PG : process
  begin

    tb_a <= not tb_a after 10 ns;
    tb_b <= not tb_b after 20 ns;
    wait for 50 ns;

  end process;

end architecture;
