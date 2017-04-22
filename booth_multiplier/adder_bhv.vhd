library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity adder_bhv is
  generic (
    N : natural := 32
  );
  port (
    a : in    std_logic_vector (N-2 downto 0);
    b : in    std_logic_vector (N-1 downto 0);
    s : out   std_logic_vector (N   downto 0)
  );
end entity; -- adder_bhv


architecture behavioral of adder_bhv is

begin

  s <= std_logic_vector(signed(a(N-2) & a(N-2) & a) + signed(b(N-1) & b));

end architecture; -- behavioral
