library IEEE;
use IEEE.std_logic_1164.all;
--use work.all;

entity ffd_async is
  port (d     : in  std_logic;
        clk   : in  std_logic;
        reset : in  std_logic;
        en    : in  std_logic;
        q     : out std_logic);
end entity;

architecture behavioral of ffd_async is
begin
  pasynch : process(clk, reset, en)
  begin
    if reset = '0' then -- active low
      q <= '0';
    elsif en = '1' then
      if clk'EVENT and clk = '1' then
        q <= d;
      end if;
    end if;
  end process;
end architecture;
