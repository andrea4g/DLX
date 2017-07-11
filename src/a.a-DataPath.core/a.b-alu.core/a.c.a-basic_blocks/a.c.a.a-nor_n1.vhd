library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity nor_n1 is
  generic(n : integer := 2);
  port(a : in  std_logic_vector(n - 1 downto 0);
       y : out std_logic
      );
end entity;

architecture behavioral of nor_n1 is

  begin
    output : process(a)
    begin
      if to_integer(unsigned(a)) = 0 then
        y <= '0';
      else
        y <= '1';
      end if;
    end process;
end architecture;
