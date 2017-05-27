library ieee;
use ieee.std_logic_1164.all;
-- use work.all;

-- no delays present

-- Block PG_network of CLA Sparse tree of P4 Adder
entity PG_network is
  generic(n : integer := 4);
  port (
    -- Inputs
    a_n     :  in  std_logic_vector(n - 1 downto 0);
    b_n     :  in  std_logic_vector(n - 1 downto 0);
    -- Outputs
    g_n     :  out std_logic_vector(n - 1 downto 0);
    p_n     :  out std_logic_vector(n - 1 downto 0)
  );
end entity;

architecture structural of PG_network is

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

begin

  PG_net : for i in 0 to n - 1 generate
    PG_i : PG
    port map(a_n(i), b_n(i), g_n(i), p_n(i));
  end generate;

end architecture;
