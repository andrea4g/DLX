library ieee;
use ieee.std_logic_1164.all;

entity fa_2 is
  port(
    a, b, c_in : in  std_logic;
    sum, c_out : out std_logic
  );
end fa_2;

-- architecture behavioral of fa_2 is
--
--   signal s1 : std_logic;
--   signal s2 : std_logic;
--   signal s3 : std_logic;
--
-- begin
--   -- sum
--   s1  <= a xor b;
--   sum <= s1 xor c_in;
--   -- carry
--   s3    <= a and b;
--   s2    <= s1 and c_in;
--   c_out <= s2 or s3;
-- end behavioral;

architecture structural of fa_2 is

  signal s1 : std_logic;
  signal s2 : std_logic;
  signal s3 : std_logic;

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

  component xor_2
    port(
      a, b : in  std_logic;
      y    : out std_logic
    );
	end component;

begin

  xor1 : xor_2
  port map(a, b, s1);

  xor2 : xor_2
  port map(s1, c_in, sum);

  and1 : and_2
  port map(a, b, s3);

  and2 : and_2
  port map(s1, c_in, s2);

  or1 : or_2
  port map(s2, s3, c_out);

end structural;
