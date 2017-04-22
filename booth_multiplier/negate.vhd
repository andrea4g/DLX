library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity negate is
  generic (
    N : natural := 32
  );
  port (
    a : in    std_logic_vector (N-1 downto 0);
    o : out   std_logic_vector (N-1 downto 0)
  );
end entity; -- negate


architecture behavior of negate is

begin

  o <= std_logic_vector(unsigned(not(a)) + 1);

end architecture; -- behavior
