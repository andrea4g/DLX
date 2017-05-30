library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.functions.all;
use work.all;

entity tb_datapath is
end entity;

architecture test_datapath of tb_datapath is

  component datapath is
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
      -- stage 1
      en1  : in  std_logic;  -- enables the register le and the pipeline registers
      rf1  : in  std_logic;  -- enables the read port 1 of the register ﬁle
      rf2  : in  std_logic;  -- enables the read port 2 of the register ﬁle
      -- stage 2
      en2  : in  std_logic;  -- enables the pipe registers
      s1   : in  std_logic;  -- input selection of the ﬁrst multiplexer
      s2   : in  std_logic;  -- input selection of the second multiplexer
      alu1 : in  std_logic;  -- alu control bit 1
      alu2 : in  std_logic;  -- alu control bit 2
      alu3 : in  std_logic;  -- alu control bit 3
      -- stage 3
      en3  : in  std_logic;  -- enables the memory and the pipeline register
      rm   : in  std_logic;  -- enables the read-out of the memory
      wm   : in  std_logic;  -- enables the write-in of the memory
      s3   : in  std_logic;  -- input selection of the multiplexer
      wf1  : in  std_logic;  -- enables the write port of the register ﬁle
    -- output
      o    : out std_logic_vector (nbit - 1 downto 0)
    );
  end component;

  constant tb_n : integer := 4;

  signal tb_inp1, tb_inp2, tb_o : std_logic_vector(tb_n - 1 downto 0);
  signal tb_rd1, tb_rd2, tb_rd  : std_logic_vector(log2(tb_n) - 1 downto 0);
  signal tb_clk, tb_rst, tb_en1, tb_rf1, tb_rf2, tb_en2, tb_s1, tb_s2, tb_alu1, tb_alu2, tb_alu3, tb_en3, tb_rm, tb_wm, tb_s3, tb_wf1 : std_logic := '0';

begin

  dut : datapath
  generic map(tb_n)
  port map(tb_inp1, tb_rd1, tb_rd2, tb_inp2, tb_rd, tb_clk, tb_rst, tb_en1, tb_rf1, tb_rf2, tb_en2, tb_s1, tb_s2, tb_alu1, tb_alu2, tb_alu3, tb_en3, tb_rm, tb_wm, tb_s3, tb_wf1, tb_ou, tb_o);

  clock_process : process
  begin
    tb_clk <= not tb_clk;
    wait for 0.5 ns;
  end process;

  tb_reset <= '1', '0' after 3 ns, '1' after 5 ns;
  


end architecture;
