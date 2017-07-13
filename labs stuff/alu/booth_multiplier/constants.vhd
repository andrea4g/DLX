library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

package constants is
  constant P0A : std_logic_vector (2 downto 0) := "000";
  constant P1A : std_logic_vector (2 downto 0) := "001";
  constant P2A : std_logic_vector (2 downto 0) := "010";
  constant N2A : std_logic_vector (2 downto 0) := "101";
  constant N1A : std_logic_vector (2 downto 0) := "110";
  constant N0A : std_logic_vector (2 downto 0) := "000";
end; -- constants
