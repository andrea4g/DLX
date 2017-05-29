library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;
use work.all;

entity datapath is
  generic(
    nbit : integer := 32
  );
  port (
  -- inputs
    -- addresses
    inp1 : in  std_logic_vector(nbit - 1 downto 0);        -- signal containing the value of the first immediate
    rd1  : in  std_logic_vector(log2(nbit) - 1 downto 0);  -- signal containing the address of the first read port of rf
    rd2  : in  std_logic_vector(log2(nbit) - 1 downto 0);  -- signal containing the address of the second read port of rf
    inp2 : in  std_logic_vector(nbit - 1 downto 0);        -- signal containing the value of the second immediate
    rd   : in  std_logic_vector(log2(nbit) - 1 downto 0);  -- signal containing the address of the write port of the rf
    -- control signals
    clk  : in  std_logic;  -- clock
    rst  : in  std_logic;  -- reset : active-low
    en   : in  std_logic;
    -- stage 1
    en1  : out std_logic;  -- enables the register le and the pipeline registers
    rf1  : out std_logic;  -- enables the read port 1 of the register ﬁle
    rf2  : out std_logic;  -- enables the read port 2 of the register ﬁle
    wf1  : out std_logic;  -- enables the write port of the register ﬁle
    -- stage 2
    en2  : out std_logic;  -- enables the pipe registers
    s1   : out std_logic;  -- input selection of the ﬁrst multiplexer
    s2   : out std_logic;  -- input selection of the second multiplexer
    alu1 : out std_logic;  -- alu control bit 1
    alu2 : out std_logic;  -- alu control bit 2
    alu3 : out std_logic;  -- alu control bit 3
    -- stage 3
    en3  : out std_logic;  -- enables the memory and the pipeline register
    rm   : out std_logic;  -- enables the read-out of the memory
    wm   : out std_logic;  -- enables the write-in of the memory
    s3   : out std_logic;  -- input selection of the multiplexer
  -- output
    o                  : out   std_logic_vector (n - 1 downto 0)
  );
end entity; -- datapath


architecture structural of datapath is

  component alu is
    generic(n : integer := 2);
    port (
      a, b      : in  std_logic_vector(n - 1 downto 0);
      unit_sel  : in  std_logic_vector(3 downto 0);
      cout      : out std_logic;
      z         : out std_logic;
      y         : out std_logic_vector(2 * n - 1 downto 0)
    );
  end component;

  component register_file is
    generic (n : natural := 32);
    port (
      -- inputs
      clk     : in  std_logic;
      reset   : in  std_logic;
      enable  : in  std_logic;
      rd1     : in  std_logic;
      rd2     : in  std_logic;
      wr      : in  std_logic;
      add_wr  : in  std_logic_vector(4  downto 0);
      add_rd1 : in  std_logic_vector(4  downto 0);
      add_rd2 : in  std_logic_vector(4  downto 0);
      datain  : in  std_logic_vector(63 downto 0);
      -- outputs
      out1    : out std_logic_vector(63 downto 0);
      out2    : out std_logic_vector(63 downto 0)
    );
  end component;

  component mux21_generic is
    generic(n : integer := 1);
    port (
      a   : in  std_logic_vector(n - 1 downto 0);
      b   : in  std_logic_vector(n - 1 downto 0);
      sel : in  std_logic;
      y   : out std_logic_vector(n - 1 downto 0)
    );
  end component;

  component ffd_async is
    port (d     : in  std_logic;
          clk   : in  std_logic;
          reset : in  std_logic;
          q     : out std_logic
    );
  end component;

  component reg_n is
    generic(n : integer := 1);
    port (
      clock  : in  std_logic;
      reset  : in  std_logic;
      enable : in  std_logic;
      x      : in  std_logic_vector (n - 1 downto 0)
      y      : out std_logic_vector (n - 1 downto 0)
    );
  end component; -- reg_n

begin

  -- stage 1 structure

  rf : register_file
  generic map (nbit)
  port map(clk, rst, en1, rf1, rf2, wf1, rd, rs1. rs2, data_out, rf_out1, rf_out2);

  in1 : reg_n
  generic map(nbit)
  port map(clk, rst, en, inp1, out_inp1);

  a : reg_n
  generic map(nbit)
  port map(clk, rst, en, rf_out1, out_a);

  b : reg_n
  generic map(nbit)
  port map(clk, rst, en, rf_out2, out_b);

  in2 : reg_n
  generic map(nbit)
  port map(clk, rst, en, inp2, out_inp2);

  rd1 : reg_n
  generic map(nbit)
  port map(clk, rst, en, rd1, out_rd1);

  -- stage 2 structure



end architecture; -- structural
