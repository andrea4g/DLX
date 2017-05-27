library ieee;
use ieee.std_logic_1164.all;

-- carry select block
entity carry_select_block is
  generic(n : integer := 4);
  port (
    -- inputs
    a, b : in  std_logic_vector(n - 1 downto 0);
    cin  : in  std_logic;
    -- outputs
    s    : out std_logic_vector(n - 1 downto 0)
  );
end entity;

architecture structural of carry_select_block is

  component mux21_generic is
  	generic(n : integer := 1);
  	port (
  		a		:	in	std_logic_vector(n - 1 downto 0);
  		b		:	in	std_logic_vector(n - 1 downto 0);
  		sel	:	in	std_logic;
  		y		:	out	std_logic_vector(n - 1 downto 0)
  	);
  end component;

  component rca_n is
    generic(n : integer := 1);
    port(
      a, b  : in  std_logic_vector(n - 1 downto 0);
      c_in  : in  std_logic;
      sum   : out std_logic_vector(n - 1 downto 0);
      c_out : out std_logic
    );
  end component;

  signal sum_first_rca, sum_second_rca : std_logic_vector(n - 1 downto 0);

begin

  first_rca : rca_n
  generic map(n)
  port map(a, b, '0', sum_first_rca);

  second_rca : rca_n
  generic map(n)
  port map(a, b, '1', sum_second_rca);

  mux : mux21_generic
  generic map(n)
  port map(sum_first_rca, sum_second_rca, cin, s);

end architecture;
