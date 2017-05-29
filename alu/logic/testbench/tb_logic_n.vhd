library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_logic_n is
end entity;

architecture test_tb_logic_n of tb_logic_n is

  constant n : integer := 4;

  component logic_n is
    generic (n : integer := 1);
    port (
      -- inputs
      r1, r2         : in  std_logic_vector(n - 1 downto 0); -- operands
      s0, s1, s2, s3 : in  std_logic; -- signal for select the operation
      -- output
      y              : out std_logic_vector(n - 1 downto 0)
    );
  end component;

  signal tb_r1, tb_r2, tb_y         : std_logic_vector(n - 1 downto 0) := (others => '0');
  signal tb_s0, tb_s1, tb_s2, tb_s3 : std_logic := '0';

begin

  dut : logic_n
  generic map(n)
  port map(tb_r1, tb_r2, tb_s0, tb_s1, tb_s2, tb_s3, tb_y);

  tb_logic_n_input_process : process
  begin

    tb_r1(0) <= not tb_r1(0) after 30   ns;
    tb_r1(1) <= not tb_r1(1) after 60   ns;
    tb_r1(2) <= not tb_r1(2) after 120  ns;
    tb_r1(3) <= not tb_r1(3) after 240  ns;

    tb_r2(0) <= not tb_r2(0) after 480  ns;
    tb_r2(1) <= not tb_r2(1) after 960  ns;
    tb_r2(2) <= not tb_r2(2) after 1920 ns;
    tb_r2(3) <= not tb_r2(3) after 3840 ns;
    wait for 1 ns;
  end process;

  tb_logic_n_select_process : process
  begin
    --       AND  NAND            OR               NOR              XOR             XNOR
    tb_s0 <= '0', '1' after 5 ns, '0' after 10 ns, '1' after 15 ns, '0' after 20 ns, '1' after 25 ns;
    tb_s1 <= '0', '1' after 5 ns, '1' after 10 ns, '0' after 15 ns, '1' after 20 ns, '0' after 25 ns;
    tb_s2 <= '0', '1' after 5 ns, '1' after 10 ns, '0' after 15 ns, '1' after 20 ns, '0' after 25 ns;
    tb_s3 <= '1', '0' after 5 ns, '1' after 10 ns, '0' after 15 ns, '0' after 20 ns, '1' after 25 ns;
    wait for 30 ns;
  end process;

end architecture;
