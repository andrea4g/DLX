library ieee;
use ieee.std_logic_1164.all;
-- use work.all;

-- no delays present

-- Block PG_general of CLA Sparse tree of P4 Adder
entity PG_general is
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
end entity;

architecture structural of PG_general is

  component or_2 is
    port(
      a, b : in  std_logic;
      y    : out std_logic
    );
  end component;

  component and_2 is
    port(
      a, b : in  std_logic;
      y    : out std_logic
    );
  end component;

  signal and_out : std_logic := '0';

begin

  -- GENERATE part
  -- G_{i:j} <= G_{i:k} or P_{i:k} and G_{k-1:j}
  -- so and_out <= P_{i:k} and G_{k-1:j}
  -- G_{i:j} <= G_{i:k} or and_out

  and_gen : and_2
  port map(pik, gkminj, and_out);

  or_gen : or_2
  port map(gik, and_out, gij);

  -- PROPAGATE part
  -- P_{i:j} <= P_{i:k} and P_{k-1:j}

  and_prop : and_2
  port map(pik, pkminj, pij);

end architecture;
