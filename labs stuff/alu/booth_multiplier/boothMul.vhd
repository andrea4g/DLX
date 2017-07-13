library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;


entity boothMul is
  generic (
    N : natural := 32
  );
  port (
    a : in    std_logic_vector (  N - 1 downto 0);
    b : in    std_logic_vector (  N - 1 downto 0);
    p : out   std_logic_vector (2*N - 1 downto 0)
  );
end entity; -- boothMul


architecture structural of boothMul is

  -- Encoder output
  type fromEnc    is array (N/2 - 2 downto 0) of std_logic_vector (      2 downto 0);

  -- Values to be added (toSum[i] + toSum[i+1] = toSum[i+2])
  -- toSum[0] is the mux0 output
  -- toSum[i+1] is the LoopMux[i] output
  -- toSum[i+2] is loopSum[i] output
  type toSum      is array (N   - 2 downto 0) of std_logic_vector (2*N     downto 0);

  -- SHIFT
  type fromShift  is array (N   - 2 downto 0) of std_logic_vector (2*N - 1 downto 0);

  -- SHIFT
  component SingleShifter is
    generic (
      N : natural := 32
    );
    port (
      a : in    std_logic_vector (N-1 downto 0);
      y : out   std_logic_vector (N   downto 0)
    );
  end component; -- SingleShifter

  --2's Complement
  component negate is
    generic (
      N : natural := 32
    );
    port (
      a : in    std_logic_vector (N-1 downto 0);
      o : out   std_logic_vector (N-1 downto 0)
    );
  end component; -- negate

  -- MUX
  component boothMux is
    generic (
      n : natural := 32
    );
    port (
      zero : in    std_logic_vector (N downto 0);
      posA : in    std_logic_vector (N downto 0);
      negA : in    std_logic_vector (N downto 0);
      po2A : in    std_logic_vector (N downto 0);
      ne2A : in    std_logic_vector (N downto 0);
      selb : in    std_logic_vector (2 downto 0);
      outp : out   std_logic_vector (N downto 0)
    );
  end component; -- boothMux

  component adder_bhv is
    generic (
      N : natural := 32
    );
    port (
      a : in    std_logic_vector (N-2 downto 0);
      b : in    std_logic_vector (N-1 downto 0);
      s : out   std_logic_vector (N   downto 0)
    );
  end component; -- adder_bhv

  component boothEncoder is
    port (
      b : in    std_logic_vector (2 downto 0);
      o : out   std_logic_vector (2 downto 0)
    );
  end component; -- boothEncoder

  -- signals used only for the first loop, done outside the for .. generate
  -- 2's Complement
  signal outNegate      : std_logic_vector (N downto 0)   := (others => 'X');
  -- first Encoder
  signal outEnc0        : std_logic_vector (2 downto 0)   := (others => 'X');
  -- to perform the sign extension of A
  signal a_in           : std_logic_vector (N downto 0)   := (others => 'X');
  signal am_in, oNm_in  : std_logic_vector (N+1 downto 0) := (others => 'X');

  -- signals used in the mainloop
  signal outEnc         : fromEnc   := ((others=> (others=>'X')));
  signal inSum          : toSum     := ((others=> (others=>'X')));
  signal outPShift      : fromShift := ((others=> (others=>'X')));
  signal outNShift      : fromShift := ((others=> (others=>'X')));

  signal firstIteration : std_logic_vector (2 downto 0) := (others => 'X');

begin

  firstIteration <= b(1 downto 0) & '0';

  enc0 : boothEncoder
    port map (
      firstIteration,
      outEnc0
    );

  a_in <= a(N-1) & a;   -- posA

  neg0 : negate
    generic map (N+1)
    port map (
      a_in,
      outNegate
    );

  shiftP0 : SingleShifter
    generic map (N+1)
    port map (
      a_in,
      outPShift(0)(N+1 downto 0)
    );


  shiftN0 : SingleShifter
    generic map (N+1)
    port map (
      outNegate,
      outNShift(0)(N+1 downto 0)
    );

  am_in  <= a_in(N)  & a_in;
  oNm_in <= outNegate(N) & outNegate;

  mux0 : boothMux
    generic map (N+1)
    port map (
      (others => '0'),             -- zero
      am_in,                       -- posA
      oNm_in,                      -- negA
      outPShift(0)(N+1 downto 0),  -- po2A
      outNShift(0)(N+1 downto 0),  -- ne2A
      outEnc0,                     -- selb
      inSum(0)(N+1 downto 0)       -- outp
  );

  inSum(0)(N+2) <= inSum(0)(N+1);

  encloop: for k in 0 to (N/2 - 2) generate
    enc : boothEncoder
      port map (
        b((2*k+3) downto (2*k+1)),
        outEnc(k)
      );
  end generate; -- encloop

  shiftloop: for j in 0 to (N-3) generate
    shiftP : SingleShifter
      generic map (N+j+2)
      port map (
        outPShift(j)(N+j+1 downto 0),
        outPShift(j+1)(N+j+2 downto 0)
      );

    shiftN : SingleShifter
      generic map (N+j+2)
      port map (
        outNShift(j)(N+j+1 downto 0),
        outNShift(j+1)(N+j+2 downto 0)
      );
  end generate; -- shiftloop

  mainloop : for i in 0 to (N/2 - 2) generate

    outPShift(2*i+1)(N+2*(i+1)+1) <= outPShift(2*i+1)(N+2*(i+1));   -- posA
    outNShift(2*i+1)(N+2*(i+1)+1) <= outNShift(2*i+1)(N+2*(i+1));   -- negA

    mux : boothMux
      generic map (N+2*i+3)
      port map (
        (others => '0'),                          -- zero
        outPShift(2*i+1)(N+2*(i+1)+1 downto 0),   -- posA
        outNShift(2*i+1)(N+2*(i+1)+1 downto 0),   -- negA
        outPShift(2*i+2)(N+2*(i+1)+1 downto 0),   -- po2A
        outNShift(2*i+2)(N+2*(i+1)+1 downto 0),   -- ne2A
        outEnc(i),                                -- selb
        inSum(2*i+1)(N+2*i+3     downto 0)        -- outp
      );

    sum : adder_bhv
      generic map (N+2*i+4)
      port map (
        inSum(2*i)(N+2*i+2 downto 0),
        inSum(2*i+1)(N+2*i+3 downto 0),
        inSum(2*(i+1))(N+2*i+4 downto 0)
      );

  end generate; -- mainloop

  p <= inSum(N - 2)(2*N-1 downto 0);

end architecture; -- structural
