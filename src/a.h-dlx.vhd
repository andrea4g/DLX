library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;
use work.globals.all;

-- problem on PC

entity dlx is
  port(
    clk : in  std_logic;
    rst : in  std_logic;
    dram_rd_data         : in  std_logic_vector(word_size - 1 downto 0);
    iram_rd_data         : in  std_logic_vector(word_size - 1 downto 0);
    dram_wr_data         : out std_logic_vector(word_size - 1 downto 0);
    dram_wr_en           : out std_logic;
    dram_rd_en           : out std_logic;
    dram_addr            : out std_logic_vector(dram_addr_size - 1 downto 0)
    --iram_addr            : out std_logic_vector(iram_addr_size - 1 downto 0)
  );
end entity; -- end dlx

architecture structural of dlx is

  component datapath is
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
      dram_wr_en   : out std_logic;
      dram_rd_en   : out std_logic;
      dram_rd_data : in  std_logic_vector(word_size - 1 downto 0);      -- from dram output
      dram_addr    : out std_logic_vector(dram_addr_size - 1 downto 0); -- to dram address
      dram_wr_data : out std_logic_vector(word_size - 1 downto 0);      -- to dram input
      pc_out       : out std_logic_vector(word_size - 1 downto 0);
      -- stage 5
      s3    : in  std_logic;  -- input selection of the multiplexer
      wf1   : in  std_logic   -- enables the write port of the register ﬁle
    );
  end component; -- datapath

  component CU_HW is
    generic (
      OP_CODE_SIZE                  : integer := op_size;   -- Op Code Size
      IR_SIZE                       : integer := instruction_size;  -- Instruction Register Size
      FUNC_SIZE                     : integer := function_size;  -- Func Field Size for R-Type Ops
      CW_SIZE                       : integer := control_word_size   -- Control Word Size
    ); -- Control Word Size
    port (
      Clk                : in  std_logic;  -- Clock
      Rst                : in  std_logic;  -- Reset : Active-Low
      -- Instruction Register
      IR_IN              : in  std_logic_vector(IR_SIZE - 1 downto 0);
      -- Pipe stage 1
      EN0                : out std_logic;
      -- Pipe stage 2
      EN1                : out std_logic;  -- enables the register le and the pipeline registers
      RF1                : out std_logic;  -- enables the read port 1 of the register ﬁle
      RF2                : out std_logic;  -- enables the read port 2 of the register ﬁle
      -- Pipe stage 3
      EN2                : out std_logic;  -- enables the pipe registers
      S1                 : out std_logic;  -- input selection of the ﬁrst multiplexer
      S2                 : out std_logic;  -- input selection of the second multiplexer
      ALU1               : out std_logic;  -- alu control bit 1
      ALU2               : out std_logic;  -- alu control bit 2
      ALU3               : out std_logic;  -- alu control bit 3
      ALU4               : out std_logic;  -- alu control bit 4
      -- Pipe stage 4
      EN3                : out std_logic;  -- enables the memory and the pipeline register
      RM                 : out std_logic;  -- enables the read-out of the memory
      WM                 : out std_logic;  -- enables the write-in of the memory
      -- Pipe stage 5
      S3                 : out std_logic;  -- input selection of the multiplexer
      WF1                : out std_logic   -- enables the write port of the register ﬁle
    );
  end component;

  signal en0_int, en1_int, rf1_int, rf2_int, en2_int, s1_int, s2_int,
    alu1_int, alu2_int, alu3_int, alu4_int, en3_int, rm_int, wm_int, s3_int, wf1_int : std_logic;

  signal iram_addr_int : std_logic_vector(iram_addr_size - 1 downto 0) := (others => '0');
  signal pc_out_int, pc_in_int : std_logic_vector(word_size - 1 downto 0);

  signal ICount       : integer range 0 to instructions_execution_cycles;

begin

  cu : CU_HW
  generic map(op_size, instruction_size, function_size, control_word_size)
  port map(clk, rst, iram_rd_data, en0_int, en1_int, rf1_int, rf2_int, en2_int, s1_int, s2_int,
    alu1_int, alu2_int, alu3_int, alu4_int, en3_int, rm_int, wm_int, s3_int, wf1_int);

  dp : datapath
  port map(clk, rst, iram_rd_data, pc_in_int, en0_int, en1_int, rf1_int, rf2_int, en2_int, s1_int, s2_int,
    alu1_int, alu2_int, alu3_int, alu4_int, en3_int, rm_int, wm_int, dram_wr_en, dram_rd_en, dram_rd_data, dram_addr,
    dram_wr_data, pc_out_int, s3_int, wf1_int);

  --iram_addr_int(word_size - 1 downto 0) <= pc_out_int;
  --iram_addr <= iram_addr_int;

  pc_proc : process(clk, rst, ICount)
  begin
    if rst = '0' then -- asynchronous reset (active low)
      --iram_addr_int <= (others => '0');
      pc_in_int  <= (others => '0');
      pc_out_int <= (others => '0');
    else
      if ICount = 0 then
        --pc_in_int <= iram_addr_int(word_size - 1 downto 0);
        pc_in_int <= pc_out_int;
      end if; -- end if ICount = 0
    end if; -- end if Rst
  end process; -- end pc_proc

  -- process to implement the counter
  count_proc : process(clk, rst)
  begin
    if rst = '0' then -- asynchronous reset (active low)
      ICount <= 0;
    else
      if clk'event and clk = '0' then  -- rising clock edge
        if ICount < 4 then -- if the counter is not arrived to 5, count up
          ICount <= ICount + 1;
        else -- else restart to 0
          ICount <= 0;
        end if; -- end if ICount
      end if; -- end if Clk
    end if; -- end if Rst
  end process;

end architecture; -- end structural
