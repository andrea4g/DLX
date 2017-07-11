library ieee;
use ieee.std_logic_1164.all;

-- basic mux 2 input one output (1 bit)
-- if (sel == 0)
--   y = a;
-- else
--   y = b;
entity mux21 is
	port (
		a	:	in	std_logic;
		b	:	in	std_logic;
		s	:	in	std_logic;
		y	:	out	std_logic
	);
end mux21;

architecture structural of mux21 is

	signal y1: std_logic;
	signal y2: std_logic;
	signal sa: std_logic;

	component and_2
		port(
    	a, b : in  std_logic;
    	y    : out std_logic
  	);
	end component;

	component or_2
		port(
    	a, b : in  std_logic;
    	y    : out std_logic
  	);
	end component;

	component not_1
		port(
    	a : in  std_logic;
    	y : out std_logic
  	);
	end component;

begin

	inv : not_1
	port map (s, sa);

	and1 : and_2
	port map (a, sa, y1);

	and2 : and_2
	port map (b, s, y2);

	or1 : or_2
	port map (y1, y2, y);

end structural;
