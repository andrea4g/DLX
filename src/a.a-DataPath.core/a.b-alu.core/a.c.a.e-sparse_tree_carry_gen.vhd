library ieee;
use ieee.std_logic_1164.all;
use work.functions.all;

-- at least 4 bit
-- only 4, 8, 16, 32, 64, 128, ecc bits
entity sparse_tree_carry_gen is
  generic(n : integer := 4);
  port (
    -- inputs
    a, b : in  std_logic_vector(n - 1 downto 0);
    -- outputs
    c    : out std_logic_vector(n - 1 downto 0)
  );
end entity;

architecture structural of sparse_tree_carry_gen is

  component PG_network is
    generic(n : integer := 4);
    port (
      -- Inputs
      a_n     :  in  std_logic_vector(n - 1 downto 0);
      b_n     :  in  std_logic_vector(n - 1 downto 0);
      -- Outputs
      g_n     :  out std_logic_vector(n - 1 downto 0);
      p_n     :  out std_logic_vector(n - 1 downto 0)
    );
  end component;

  component G_general is
    port (
      -- Inputs
      gkminj  :  in  std_logic; -- G_{k-1:j}
      --
      gik     :  in  std_logic; -- G_{i:k}
      pik     :  in  std_logic; -- P_{i:k}
      -- Outputs
      gij     :  out std_logic  -- G_{i:j}
    );
  end component;

  component PG_general is
    port (
      -- Inputs
      gkminj  :  in  std_logic; -- G_{k-1:j}
      pkminj  :  in  std_logic; -- P_{k-1:j}
      --
      gik     :  in  std_logic; -- G_{i:k}
      pik     :  in  std_logic; -- P_{i:k}
      -- Outputs
      gij     :  out std_logic; -- G_{i:j}
      pij     :  out std_logic  -- P_{i:j}
    );
  end component;

  -- type SignalVector is array (n − 1 downto 0) of std_logic_vector ((log2(n) − 1) * 2 - 1 downto 0);
  type signalvector is array (((log2(n) + 1) * 2) - 1 downto 0) of std_logic_vector (n - 1 downto 0);

  -- signal declaration
  signal temp : signalvector := ((others=> (others=>'0')));

begin

  -- pg network
  pg_net : PG_network
  generic map(n)
  port map(a, b, temp(0), temp(1));
  -- temp(0) is g_n out of PG network
  -- temp(1) is p_n out of PG network

--------------------------------------------------------------------------------
  -- loop on the number of rows of the structure (#rows = log2(n))
  rows : for i in 0 to log2(n) - 1 generate

    -- if we are in the first 3 rows
    -- 1 G block, others PG blocks
    row_i : if(i < 2) generate
      -- first G block on each row
      gen_in_i : G_general
      --       Input                                            | Output
      --       gkminj          gik             pik                gij
      port map(temp(i * 2)(0), temp(i * 2)(1), temp(i * 2 + 1)(1), temp(i * 2 + 2)(0));
      -- other pg blocks
      pg_row_i : for j in 0 to (n / ((i + 1) * 2)) - 2 generate
        pg_j : PG_general
        --       Input
        --       gkminj                  pkminj                      gik                     pik
        port map(temp(i * 2)(j * 2 + 2), temp(i * 2 + 1)(j * 2 + 2), temp(i * 2)(j * 2 + 3), temp(i * 2 + 1)(j * 2 + 3),
        --Output
        --gij                     pij
          temp(i * 2 + 2)(j + 1), temp(i * 2 + 3)(j + 1));
      end generate; -- end generate pg

    end generate; -- end if generate of first 2 rows
--------------------------------------------------------------------------------
    -- from the third row to the end
    other_row_i : if i > 1 generate

      -- fill with spaces
      space_g_q : for q in 0 to pow2(i - 2) - 1 generate
      begin
        -- link the g of the previous row with the one of following
        temp(i * 2 + 2)(q) <= temp(i * 2)(q);
        -- link the p of the previous row with the one of following
        temp(i * 2 + 3)(q) <= temp(i * 2 + 1)(q);
      end generate; -- end generate spaces before g

      g_r :  for r in 0 to pow2(i - 2) - 1 generate
      begin
        -- G block
        gen_r : G_general
        --       Input
        --       gkminj                        gik                           pik
        port map(temp(i * 2)(pow2(i - 2) - 1), temp(i * 2)(r + pow2(i - 2)), temp(i * 2 + 1)(r + pow2(i - 2)),
        --Output
        --gij
          temp(i * 2 + 2)(r + pow2(i - 2)));
      end generate; -- end generate g

      pg_blocks_p : for p in 0 to (n / pow2(i + 1)) - 2 generate
      begin
        -- fill with spaces
        space_pg_d : for d in 0 to pow2(i - 2) - 1 generate
        begin
          -- link the g of the previous row with the one of following
          temp(i * 2 + 2)(p * pow2(i - 1) + pow2(i - 1) + d) <= temp(i * 2)(p * pow2(i - 1) + pow2(i - 1) + d);
          -- link the p of the previous row with the one of following
          temp(i * 2 + 3)(p * pow2(i - 1) + pow2(i - 1) + d) <= temp(i * 2 + 1)(p * pow2(i - 1) + pow2(i - 1) + d);
        end generate; -- end generate spaces before pg

        pg_i :  for e in 0 to pow2(i - 2) - 1 generate
        begin
          pg_e : PG_general
          --       Input
          --       gkminj                                      pkminj
          port map(temp(i * 2)(p * pow2(i - 1) + pow2(i - 1)), temp(i * 2 + 1)(p * pow2(i - 1) + pow2(i - 1)),
          --gik                                                           pik
            temp(i * 2)(p * pow2(i - 1) + pow2(i - 1) + pow2(i - 2) + e), temp(i * 2 + 1)(p * pow2(i - 1) + pow2(i - 1) + pow2(i - 2) + e),
          --Output
          --gij                                                               pij
            temp(i * 2 + 2)(p * pow2(i - 1) + pow2(i - 1) + pow2(i - 2) + e), temp(i * 2 + 3)(p * pow2(i - 1) + pow2(i - 1) + pow2(i - 2) + e));
        end generate; -- end generate pg

      end generate; -- end generate of the number of times spaces + pg

    end generate; -- end generate if i > 2

  end generate; -- end big generate of the rows

  -- assign to the output the second to last line of the big matrix of signals
  -- (the one which contains the generate signals output of the last lines of blocks)
  c <= temp(log2(n) * 2);
------------------------------------------------------------------------------------------------------------------------------
end architecture;
