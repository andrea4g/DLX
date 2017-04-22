library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

--------------------------------------------------------------------------------

entity MULTIPLIER_tb is
end MULTIPLIER_tb;

--------------------------------------------------------------------------------

architecture TEST of MULTIPLIER_tb is

  --  MUL Component Declaration
  component boothMul is
    generic (
      N : natural := 32
    );
    port (
      a : in    std_logic_vector (  N - 1 downto 0);
      b : in    std_logic_vector (  N - 1 downto 0);
      p : out   std_logic_vector (2*N - 1 downto 0)
    );
  end component; -- boothMul

  constant numBit : integer := 8;    -- Values: 4, 8, 16

  --  INPUT
  signal  A_mp_i : std_logic_vector(  numBit-1 downto 0) := (others => '0');
  signal  B_mp_i : std_logic_vector(  numBit-1 downto 0) := (others => '0');

  --  OUTPUT
  signal  Y_mp_i : std_logic_vector(2*numBit-1 downto 0);
  signal  Y_test : std_logic_vector(2*numBit-1 downto 0);

begin

  --  MUL Instantiation
  bm : boothMul
    generic map (numBit)
    port    map (A_mp_i, B_mp_i, Y_mp_i);

  Y_test <= A_mp_i * B_mp_i;

  --  PROCESS FOR TESTING TEST - COMLETE CYCLE  ------------------------------
  stimuli : process
  begin

    -- Cycle for Operand A
    NumROW : for i in 0 to 2**(NumBit)-1 loop

      -- Cycle for Operand B
      NumCOL : for i in 0 to 2**(NumBit)-1 loop

        wait for 5 ns;
        assert Y_mp_i = Y_test
          report    "ERROR! Wrong result!"
          severity  warning;
        wait for 5 ns;

        B_mp_i <= B_mp_i + '1';

      end loop; -- NumCOL

      A_mp_i <= A_mp_i + '1';

    end loop; -- NumROW

    wait;
  end process stimuli;

end architecture TEST;

