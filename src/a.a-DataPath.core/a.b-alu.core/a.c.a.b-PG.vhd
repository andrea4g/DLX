library ieee;
use ieee.std_logic_1164.all;
-- use work.all;

-- no delays present

-- Block PG (basic block of PG network) of CLA Sparse tree of P4 Adder
entity PG is
  port (
    -- Inputs
    a     :  in  std_logic; -- a_{i}
    b     :  in  std_logic; -- b_{i}
    -- Outputs
    g     :  out std_logic; -- G_{i:j}
    p     :  out std_logic  -- P_{i:j}
  );
end entity;

architecture structural of PG is

  component xor_2 is
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

begin

  -- GENERATE part
  -- g <= a and b

  and_gen : and_2
  port map(a, b, g);

  -- PROPAGATE part
  -- p <= a xor b

  xor_pro : xor_2
  port map(a, b, p);

end architecture;
