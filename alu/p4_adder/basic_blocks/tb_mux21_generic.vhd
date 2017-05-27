library ieee;
use ieee.std_logic_1164.all;

entity tb_mux21_generic is
end tb_mux21_generic;

architecture test_mux21_generic of tb_mux21_generic is

  constant n: integer := 4;

	component mux21_generic
    generic(n : integer := 1);
	  port(
		  a		:	in	std_logic_vector(n - 1 downto 0);
		  b		:	in	std_logic_vector(n - 1 downto 0);
		  sel	:	in	std_logic;
		  y		:	out	std_logic_vector(n - 1 downto 0)
	  );
	end component;

  signal tb_a, tb_b : std_logic_vector(n - 1 downto 0);
  signal tb_sel     : std_logic;
  signal tb_y       : std_logic_vector(n - 1 downto 0);

begin

	dut : mux21_generic
	generic map (n)
	port map (tb_a, tb_b, tb_sel, tb_y);

	tb_a <= "0000";
	tb_b <= "1111";
	tb_sel <= '0', '1' after 5 ns;

end test_mux21_generic;
