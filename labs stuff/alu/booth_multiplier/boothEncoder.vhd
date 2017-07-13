library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

library work;
use work.constants.all;

entity boothEncoder is
  port (
    b : in    std_logic_vector (2 downto 0);
    o : out   std_logic_vector (2 downto 0)
  );
end entity; -- boothEncoder

architecture behavioral of boothEncoder is

begin

  o <= P0A when b = "000" else
       P1A when b = "001" else
       P1A when b = "010" else
       P2A when b = "011" else
       N2A when b = "100" else
       N1A when b = "101" else
       N1A when b = "110" else
       N0A when b = "111" else
       (others => 'X');

end architecture; -- behavioral
