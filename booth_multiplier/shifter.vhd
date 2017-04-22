library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity SingleShifter is
  generic (
    N : natural := 32
  );
  port (
    a : in    std_logic_vector (N-1 downto 0);
    y : out   std_logic_vector (N   downto 0)
  );
end entity; -- SingleShifter


architecture behavioral of SingleShifter is

begin

  y <= a & '0';

end architecture; -- behavioral
