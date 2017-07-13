library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity tb_ffd is
end tb_ffd;

architecture test of tb_ffd is

  signal clk_tb   : std_logic := '0';
  signal reset_tb : std_logic;
  signal d_tb     : std_logic;
  signal qsynch   :	std_logic;
	signal qasynch  :	std_logic;

  component ffd is
    port (d     : in	std_logic;
          clk   :	in	std_logic;
          reset :	in	std_logic;
          q     : out	std_logic);
  end component;

begin

  ffd1 : ffd
  port map(d_tb, clk_tb, reset_tb, qsynch);

  ffd2 : ffd
  port map(d_tb, clk_tb, reset_tb, qasynch);

  clk_p : process
  begin
    clk_tb <= not(clk_tb);
    wait for 10 ns;
  end process;

  reset_p : process
  begin
    reset_tb <= '1';
    wait for 52 ns;
    reset_tb <= '0';
    wait for 100 ns;
    reset_tb <= '1';
    wait for 5 ms;
  end process;

  ffd_p : process
  begin
    -- 0
    d_tb <= '0';
    wait for 33 ns;
    -- 1
    d_tb <= '1';
    wait for 23 ns;
    d_tb <= '0';
    wait for 100 ns;
    -- 0
    d_tb <= '0';
    wait for 23 ns;
    -- 1
    d_tb <= '1';
    wait for 100 ns;
  end process;

end test;

configuration FD_test of tb_ffd is
   for test
      for ffd1 : ffd
        use configuration work.cfg_ffd_synch_behavioral; -- synchronous
      end for;
      for ffd2 : ffd
        use configuration work.cfg_ffd_asynch_behavioral; -- asynchronous
      end for;
   end for;
end FD_test;
