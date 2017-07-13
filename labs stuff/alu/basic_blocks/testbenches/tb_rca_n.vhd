library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_rca_n is
end tb_rca_n;

architecture test of tb_rca_n is

  constant n : integer := 4;

  component rca_n is
    generic(n : integer := 1);
    port(
      a, b  : in  std_logic_vector(n - 1 downto 0);
      c_in  : in  std_logic;
      sum   : out std_logic_vector(n - 1 downto 0);
      c_out : out std_logic
    );
  end component;

  signal a_tb, b_tb : std_logic_vector(n - 1 downto 0);
  signal c_in_tb    : std_logic;
  signal sum_tb     : std_logic_vector(n - 1 downto 0);
  signal c_out_tb   : std_logic;

begin

  rca_n_tb : rca_n
  generic map(4)
  port map(a_tb, b_tb, c_in_tb, sum_tb, c_out_tb);

  test : process is
  begin
    -- 0000 + 0000 + 0 = 0000 _ 0
    wait for 1 ns;
    c_in_tb <= '0';
    a_tb    <= "0000";
    b_tb    <= "0000";
    -- 0010 + 1101 + 0 = 1111 _ 0
    wait for 1 ns;
    c_in_tb <= '0';
    a_tb    <= "0010";
    b_tb    <= "1101";
    -- 0101 + 0011 + 0 = 1000 _ 0
    wait for 1 ns;
    c_in_tb <= '0';
    a_tb    <= "0101";
    b_tb    <= "0011";
    -- 0111 + 0000 + 1 = 1000 _ 0
    wait for 1 ns;
    c_in_tb <= '1';
    a_tb    <= "0111";
    b_tb    <= "0000";
    -- 1001 + 1100 + 1 = 0110 _ 1
    wait for 1 ns;
    c_in_tb <= '1';
    a_tb    <= "1001";
    b_tb    <= "1100";
    -- 1101 + 1111 + 0 = 1100 _ 1
    wait for 1 ns;
    c_in_tb <= '0';
    a_tb    <= "1101";
    b_tb    <= "1111";
    -- 1111 + 1111 + 1 = 1111 _ 1
    wait for 1 ns;
    c_in_tb <= '1';
    a_tb    <= "1111";
    b_tb    <= "1111";
  end process;

end test;
