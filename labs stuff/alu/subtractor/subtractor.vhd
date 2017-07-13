library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity subtractor is
  generic(n : integer := 2);
  port (
    -- inputs
    a    : in  std_logic_vector (n - 1 downto 0);
    b    : in  std_logic_vector (n - 1 downto 0);
    cin  : in  std_logic;
    -- outputs
    y    : out std_logic_vector (n - 1 downto 0);
    cout : out std_logic;
  );
end entity; -- subtractor


architecture behavioral of subtractor is

  component p4 is
     generic(n : integer := 4);
     port ( --inputs
            a, b : in  std_logic_vector(n - 1 downto 0);
            cin  : in  std_logic;
            -- outputs
            s    : out std_logic_vector(n - 1 downto 0);
            cout : out std_logic
          );
  end component;

  component not_n is
    generic(n : integer := 1);
    port (a : in  std_logic_vector (n - 1 downto 0);
          y : out std_logic_vector (n - 1 downto 0)
         );
  end component;

  signal b_not : std_logic_vector (n - 1 downto 0);

begin
    
  inv : not_n
  generic map (n)
  port map (b, b_not);

  sub : p4
  generic map (n)
  port map (a, b_not, '1', y, cout);
    
  );
    
  );
    
    
    

end architecture; -- behavioral
