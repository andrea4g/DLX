library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity tb_alu is
end entity;

architecture test_alu of tb_alu is

  constant nbit : integer := 8

  component alu is
    generic(n : integer := 2);
    port (
      a, b      : in  std_logic_vector(n - 1 downto 0);
      unit_sel  : in  std_logic_vector(2 downto 0);
      cout      : out std_logic;
      z         : out std_logic;
      y         : out std_logic_vector(n - 1 downto 0)
    );
  end component;

  signal tb_a, tb_b, tb_y : std_logic_vector(nbit - 1 downto 0);
  signal tb_unit_sel      : std_logic_vector(2 downto 0);
  signal tb_cout, z       : std_logic;

begin

  dut : alu
  generic map(nbit)
  port map(tb_a, tb_b, tb_unit_sel, tb_cout, tb_z, tb_y);

  alu_process : process
  begin
    tb_a =>
  end process; -- end alu_process

end architecture;
