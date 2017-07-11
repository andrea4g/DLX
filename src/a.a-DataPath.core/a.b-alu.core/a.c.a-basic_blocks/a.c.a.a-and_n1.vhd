library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity and_n1 is
  generic(n : integer := 2);
  port(a : in  std_logic_vector(n - 1 downto 0);
       y : out std_logic
      );
end entity;

architecture behavioral of and_n1 is

  signal a_not : std_logic_vector (n - 1 downto 0);

begin
    output : process(a)
    begin
      a_not <= not a;
      if to_integer(unsigned(a_not)) = 0 then
        y <= '1';
      else
        y <= '0';
      end if;
    end process;
end architecture;
