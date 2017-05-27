library IEEE;
use IEEE.std_logic_1164.all;

entity tb_mux21 is
end entity;

architecture test_mux21 of tb_mux21 is

  component mux21 is
  	port (
  		a	:	in	std_logic;
  		b	:	in	std_logic;
  		s	:	in	std_logic;
  		y	:	out	std_logic
  	);
  end component;

  signal tb_a, tb_b, tb_s, tb_y : std_logic;

begin

  dut : mux21
  port map(tb_a, tb_b, tb_s, tb_y);

  tb_a <= '0', '1' after 10 ns, '0' after 20 ns, '1' after 30 ns;
  tb_b <= '0', '1' after 20 ns;
  tb_s <= '0', '1' after 20 ns;

end architecture;
