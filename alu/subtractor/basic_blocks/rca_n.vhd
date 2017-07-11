library ieee;
use ieee.std_logic_1164.all;

entity rca_n is
  generic(n : integer := 1);
  port(
    a, b  : in  std_logic_vector(n - 1 downto 0);
    c_in  : in  std_logic;
    sum   : out std_logic_vector(n - 1 downto 0);
    c_out : out std_logic
  );
end rca_n;

architecture structural of rca_n is

  component fa_2
    port(
      a, b, c_in : in  std_logic;
      sum, c_out : out std_logic
    );
  end component;

  signal temp : std_logic_vector(n downto 0);

begin
  temp(0) <= c_in;
  c_out   <= temp(n);
  full_adder : for i in 0 to n - 1 generate
    fa_2_i : fa_2
    port map(a(i), b(i), temp(i), sum(i), temp(i + 1));
  end generate;

end structural;
