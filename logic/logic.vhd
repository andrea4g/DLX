library ieee;
use ieee.std_logic_1164.all;

-- unit to do AND, NAND, OR, NOR, XOR, XNOR
entity logic is
  port (
    -- inputs
    r1, r2         : in  std_logic; -- operands
    s0, s1, s2, s3 : in  std_logic; -- signal for select the operation
    -- output
    y              : out std_logic
  );
end entity;

architecture behavioral of logic is

  signal l0, l1, l2, l3 : std_logic;

begin

  -- first stage
  l0 <= (s0) nand (not r1) nand (not r2);
  l1 <= (s1) nand (not r1) nand (r2);
  l2 <= (s2) nand (r1)     nand (not r2);
  l3 <= (s3) nand (r1)     nand (r2);

  -- second stage
  y <= l0 nand l1 nand l2 nand l3;

end architecture;
