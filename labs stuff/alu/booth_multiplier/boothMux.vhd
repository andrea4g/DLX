library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

library WORK;
use WORK.constants.all;

entity boothMux is
  generic (
    n : natural := 32
  );
  port (
    zero : in    std_logic_vector (n   downto 0);
    posA : in    std_logic_vector (n   downto 0);
    negA : in    std_logic_vector (n   downto 0);
    po2A : in    std_logic_vector (n   downto 0);
    ne2A : in    std_logic_vector (n   downto 0);
    selb : in    std_logic_vector (  2 downto 0);
    outp : out   std_logic_vector (n   downto 0)
  );
end entity; -- boothMux


architecture behavioral of boothMux is

begin

  outp <= zero when selb = P0A else
          zero when selb = N0A else
          posA when selb = P1A else
          negA when selb = N1A else
          po2A when selb = P2A else
          ne2A when selb = N2A else
          (others => 'X');

end architecture; -- behavioral
