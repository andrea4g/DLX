library IEEE;
use IEEE.std_logic_1164.all;
use work.all;

entity ffd is
	port (d     : in	std_logic;
		    clk   :	in	std_logic;
		    reset :	in	std_logic;
		    q     : out	std_logic);
end ffd;

architecture synch_behavioral of ffd is
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
end synch_behavioral;

architecture asynch_behavioral of ffd is
begin
  pasynch : process(clk, reset)
  begin
    if(reset = '0') then
      q <= '0';
    elsif(clk'EVENT and clk = '1') then
      q <= d;
    end if;
  end process;
end asynch_behavioral;

configuration cfg_ffd_synch_behavioral of ffd is
	for synch_behavioral
	end for;
end cfg_ffd_synch_behavioral;

configuration cfg_ffd_asynch_behavioral of ffd is
	for asynch_behavioral
	end for;
end cfg_ffd_asynch_behavioral;
