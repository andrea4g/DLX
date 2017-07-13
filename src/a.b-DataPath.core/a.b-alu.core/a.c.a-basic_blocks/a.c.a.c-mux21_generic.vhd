library IEEE;
use IEEE.std_logic_1164.all;

--mux 2 input 1 output (n bits)
-- if (sel == 0)
--   y = a;
-- else
--   y = b;
entity mux21_generic is
	generic(n : integer := 1);
	port (
		a		:	in	std_logic_vector(n - 1 downto 0);
		b		:	in	std_logic_vector(n - 1 downto 0);
		sel	:	in	std_logic;
		y		:	out	std_logic_vector(n - 1 downto 0)
	);
end mux21_generic;

architecture structural of mux21_generic is

	component mux21
	port (
		a :	in	std_logic;
		b :	in	std_logic;
		s :	in	std_logic;
		y :	out	std_logic
	);
	end component;

begin
	  mux_vector: for i in 0 to n - 1 generate
	    mux21_i : mux21  Port Map (a(i), b(i), sel, y(i));
	  end generate;

end structural;
