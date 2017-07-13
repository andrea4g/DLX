library IEEE;
use IEEE.std_logic_1164.all;
--use work.all;

entity ffd_synch is
	port (d     : in	std_logic;
		    clk   :	in	std_logic;
		    reset :	in	std_logic;
		    q     : out	std_logic);
end entity;

architecture behavioral of ffd_synch is
begin
  psynch : process(clk, reset)
  begin
    if(clk'EVENT and clk = '1') then
      if(reset = '0') then
        q <= '0';
      else
        q <= d;
      end if;
    end if;
  end process;
end architecture;
