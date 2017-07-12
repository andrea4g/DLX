library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.globals.all;
use work.all;

entity datapath is
  port (
  -- inputs
    -- control signals
    clk   : in  std_logic;  -- clock
    rst   : in  std_logic;  -- reset : active-low
    -- stage 1
    ir    : in  std_logic_vector(instruction_size - 1 downto 0);
    pc_in : in  std_logic_vector(word_size - 1 downto 0);
    en0   : in  std_logic;
    -- stage 2
    en1   : in  std_logic;  -- enables the register le and the pipeline registers
    rf1   : in  std_logic;  -- enables the read port 1 of the register ﬁle
    rf2   : in  std_logic;  -- enables the read port 2 of the register ﬁle
    -- stage 3
    en2   : in  std_logic;  -- enables the pipe registers
    s1    : in  std_logic;  -- input selection of the ﬁrst multiplexer
    s2    : in  std_logic;  -- input selection of the second multiplexer
    alu1  : in  std_logic;  -- alu control bit 1
    alu2  : in  std_logic;  -- alu control bit 2
    alu3  : in  std_logic;  -- alu control bit 3
    alu4  : in  std_logic;  -- alu control bit 3
    -- stage 4
    en3   : in  std_logic;  -- enables the dram and the pipeline register
    rm    : in  std_logic;  -- enables the read-out of the dram
    wm    : in  std_logic;  -- enables the write-in of the dram
    dram_rd_data : in  std_logic_vector(word_size - 1 downto 0);      -- from dram output
    dram_addr    : out std_logic_vector(dram_addr_size - 1 downto 0); -- to dram address
    dram_wr_data : out std_logic_vector(word_size - 1 downto 0);      -- to dram input
    pc_out       : out std_logic_vector(word_size - 1 downto 0);
    -- stage 5
    s3    : in  std_logic;  -- input selection of the multiplexer
    wf1   : in  std_logic   -- enables the write port of the register ﬁle
  );
end entity; -- datapath


architecture structural of datapath is

  component alu is
    generic(n : integer := 2);
    port (
      a, b      : in  std_logic_vector(n - 1 downto 0);
      unit_sel  : in  std_logic_vector(3 downto 0);
      y         : out std_logic_vector(n - 1 downto 0);
      cout      : out std_logic;
      z         : out std_logic
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
      datain  : in  std_logic_vector(word_size - 1 downto 0);
      -- outputs
      out1    : out std_logic_vector(word_size - 1 downto 0);
      out2    : out std_logic_vector(word_size - 1 downto 0)
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
          en    : in  std_logic;
          q     : out std_logic);
  end component;

  component reg_n is
    generic(n : integer := 1);
    port (
      clock  : in  std_logic;
      reset  : in  std_logic;
      enable : in  std_logic;
      x      : in  std_logic_vector (n - 1 downto 0);
      y      : out std_logic_vector (n - 1 downto 0)
    );
  end component; -- reg_n

  component zero_comp is
    generic(n : integer := 1);
    port (x : in  std_logic_vector (n - 1 downto 0);
          y : in  std_logic
    );
  end component; -- zero_comp

  component sign_extension is
    generic(s : integer := 2; f : integer := 3);
    port(
      x : in  std_logic_vector(s - 1 downto 0);
      y : out std_logic_vector(f - 1 downto 0)
    );
  end component; -- end sign_extension

  -- signals stage 1
  constant c4    : std_logic_vector (3 downto 0) := X"4";
  signal four    : std_logic_vector (word_size - 1 downto 0) := (others => '0');
  signal next_pc : std_logic_vector (word_size - 1 downto 0);
  signal npc     : std_logic_vector (word_size - 1 downto 0);

  -- signals stage 2
  signal data_out, rf_out1, rf_out2, out_inp1, out_a, out_b, inp2_32, out_inp2 : std_logic_vector(word_size - 1 downto 0);
  signal rd1, rd2, rd : std_logic_vector(add_size - 1 downto 0);
  signal inp2         : std_logic_vector(inp2_up downto 0);
  signal out_rd1      : std_logic_vector(add_size - 1 downto 0);

  -- signals stage 3
  signal out_mux1, out_mux2, out_alu, out_aluout, out_me, npc_st3 : std_logic_vector(word_size - 1 downto 0);
  signal out_rd2  : std_logic_vector(add_size - 1 downto 0);
  signal alu_bit  : std_logic_vector(3 downto 0);
  signal cond     : std_logic;

  -- signals stage 4
  signal out_val, out_alu_st4, out_dram : std_logic_vector(word_size - 1 downto 0);
  signal out_rd3 : std_logic_vector(add_size - 1 downto 0);

  -- signals stage 5
  signal wb : std_logic_vector(word_size - 1 downto 0);

  -- signals to delay the control word
  signal out_en2  : std_logic;
  signal out_s1   : std_logic;
  signal out_s2   : std_logic;
  signal out_alu1 : std_logic;
  signal out_alu2 : std_logic;
  signal out_alu3 : std_logic;
  signal out_alu4 : std_logic;
  signal out_en3  : std_logic;
  signal out_rm   : std_logic;
  signal out_wm   : std_logic;
  signal out_s3   : std_logic;
  signal out_wf1  : std_logic;

begin

-----------------------------------------------------------------------------------------
-- stage 1
-----------------------------------------------------------------------------------------

  four(3 downto 0) <=  c4;

  pc_add : rca_n
  generic map (word_size)
  port map (pc_in, four, '0', next_pc);

  npc_reg : reg_n
  generic map (word_size)
  port map (clk, rst, '1', next_pc, npc);

-----------------------------------------------------------------------------------------
-- stage 2
-----------------------------------------------------------------------------------------

  rd1  <= ir(r1_up   downto r1_down);
  rd2  <= ir(r2_up   downto r2_down);
  rd   <= ir(r3_up   downto r3_down);
  inp2 <= ir(inp2_up downto inp2_down);

  rf : register_file
  generic map (word_size)
  port map(clk, rst, en1, rf1, rf2, wf1, out_rd3, rd1, rd2, wb, rf_out1, rf_out2);

  npc_1 : reg_n
  generic map(word_size)
  port map(clk, rst, en1, npc, out_inp1);

  a : reg_n
  generic map(word_size)
  port map(clk, rst, en1, rf_out1, out_a);

  b : reg_n
  generic map(word_size)
  port map(clk, rst, en1, rf_out2, out_b);

  -- sign extension of immediate (16 to 32 bits)
  ext : sign_extension
  generic map(16, word_size)
  port map(inp2, inp2_32);

  in2 : reg_n
  generic map(word_size)
  port map(clk, rst, en1, inp2_32, out_inp2);

  rd_1 : reg_n
  generic map(add_size)
  port map(clk, rst, en1, rd, out_rd1);

-----------------------------------------------------------------------------------------
-- stage 3
-----------------------------------------------------------------------------------------
  alu_bit <= out_alu4 & out_alu3 & out_alu2 & out_alu1;

  mux1_alu : mux21_generic
  generic map(word_size)
  port map(out_inp1, out_a, out_s1, out_mux1);

  mux2_alu : mux21_generic
  generic map(word_size)
  port map(out_b, out_inp2, out_s2, out_mux2);

  arith_log_un : alu
  generic map(word_size)
  port map(out_mux1, out_mux2, alu_bit, out_alu);

  alu_out : reg_n
  generic map(word_size)
  port map(clk, rst, out_en2, out_alu, out_aluout);

  me : reg_n
  generic map(word_size)
  port map(clk, rst, en2, out_b, out_me);

  rd_2 : reg_n
  generic map(word_size)
  port map(clk, rst, en2, out_rd1, out_rd2);

  npc_2 : reg_n
  generic map(word_size)
  port map(clk, rst, en1, out_inp1, npc_st3);

  cmp : zero_comp
  generic map(word_size)
  port map(out_a, cond);

-----------------------------------------------------------------------------------------
-- stage 4
-----------------------------------------------------------------------------------------

  mux_j : mux21_generic
  generic map(word_size)
  port map(npc_st3, out_aluout, cond, pc_out);

  dram_addr    <= out_aluout;
  dram_wr_data <= out_me;

  out_value : reg_n
  generic map(word_size)
  port map(clk, rst, out_en3, out_aluout, out_alu_st4);

  lmd : reg_n
  generic map(word_size)
  port map(clk, rst, out_en3, dram_rd_data, out_dram);

  rd_3 : reg_n
  generic map(word_size)
  port map(clk, rst, en3, out_rd2, out_rd3);

-----------------------------------------------------------------------------------------
-- stage 5
-----------------------------------------------------------------------------------------
  mux_out_sel : mux21_generic
  generic map(word_size)
  port map(out_dram, out_alu_st4, out_s3, wb);

-----------------------------------------------------------------------------------------
  -- delay cw
  en2_cw2  : ffd_async
  port map(clk, rst, '1', en2, out_en2);

  s1_cw2   : ffd_async
  port map(clk, rst, '1', s1, out_s1);

  s2_cw2   : ffd_async
  port map(clk, rst, '1', s2, out_s2);

  alu1_cw2 : ffd_async
  port map(clk, rst, '1', alu1, out_alu1);

  alu2_cw2 : ffd_async
  port map(clk, rst, '1', alu2, out_alu2);

  alu3_cw2 : ffd_async
  port map(clk, rst, '1', alu3, out_alu3);

  en3_cw3  : ffd_async
  port map(clk, rst, '1', en3, out_en3);

  rm_cw3   : ffd_async
  port map(clk, rst, '1', rm, out_rm);

  wm_cw3   : ffd_async
  port map(clk, rst, '1', wm, out_wm);

  s3_cw3   : ffd_async
  port map(clk, rst, '1', s3, out_s3);

  wf1_cw3  : ffd_async
  port map(clk, rst, '1', wf1, out_wf1);

end architecture; -- structural
