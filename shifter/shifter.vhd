library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity shifter is
  generic(
    n : integer := 2;   -- number of bits
    p : integer := 5   -- number of bits for the signal that carries the number of shifts
  );
  port(
    -- Inputs
    x   : in  std_logic_vector(n - 1 downto 0);
    dir : in  std_logic;                        -- if 0 shift left, if 1 shift right
    pos : in  std_logic_vector(p - 1 downto 0); -- number of shifts
    -- Outputs
    y   : out std_logic_vector(n - 1 downto 0)
  );
end entity;

architecture structural of shifter is

begin



end architecture;
