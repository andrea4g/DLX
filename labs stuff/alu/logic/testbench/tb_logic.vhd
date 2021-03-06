library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_logic is
end entity;

architecture test_tb_logic of tb_logic is

  component logic is
    port (
      -- inputs
      r1, r2         : in  std_logic; -- operands
      s0, s1, s2, s3 : in  std_logic; -- signal for select the operation
      -- output
      y              : out std_logic
    );
  end component;

  signal tb_r1, tb_r2, tb_s0, tb_s1, tb_s2, tb_s3, tb_y : std_logic := '0';

begin

  dut : logic
  port map(tb_r1, tb_r2, tb_s0, tb_s1, tb_s2, tb_s3, tb_y);

  tb_logic_input_process : process
  begin

    tb_r1 <= '0', '1' after 20 ns, '0' after 40 ns, '1' after 60 ns;
    tb_r2 <= '0', '0' after 20 ns, '1' after 40 ns, '1' after 60 ns;
    wait for 70 ns;

  end process;

  tb_logic_select_process : process
  begin
    --       AND  NAND            OR               NOR              XOR             XNOR
    tb_s0 <= '0', '1' after 2 ns, '0' after 4 ns, '1' after 6 ns, '0' after 8 ns, '1' after 10 ns;
    tb_s1 <= '0', '1' after 2 ns, '1' after 4 ns, '0' after 6 ns, '1' after 8 ns, '0' after 10 ns;
    tb_s2 <= '0', '1' after 2 ns, '1' after 4 ns, '0' after 6 ns, '1' after 8 ns, '0' after 10 ns;
    tb_s3 <= '1', '0' after 2 ns, '1' after 4 ns, '0' after 6 ns, '0' after 8 ns, '1' after 10 ns;
    wait for 20 ns;
  end process;

end architecture;
