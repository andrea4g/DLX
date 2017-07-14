library IEEE;
use IEEE.std_logic_1164.all;
use work.ROCACHE_PKG.all;
use work.RWCACHE_PKG.all;
--use work.myTypes.all;

entity DLX is
  generic (
    IR_SIZE      : integer := 32;      -- Instruction Register Size
    PC_SIZE      : integer := 32       -- Program Counter Size
  );
  port (
    -- Inputs
    CLK               : in    std_logic;    -- Clock
    RST               : in    std_logic;    -- Reset: Active-High
    -- Instr_size = 32, Data_size = 32
    IRAM_ADDRESS      : out   std_logic_vector(Instr_size - 1 downto 0);
    --IRAM_ISSUE        : out   std_logic;
    --IRAM_READY        : in    std_logic;
    IRAM_DATA         : in    std_logic_vector(Data_size - 1 downto 0);

    DRAM_ADDRESS      : out   std_logic_vector(Instr_size - 1 downto 0);
    DRAM_ISSUE        : out   std_logic;
    DRAM_READNOTWRITE : out   std_logic;
    --DRAM_READY        : in    std_logic;
    DRAM_DATA         : inout std_logic_vector(Data_size - 1 downto 0)
  );
end DLX;

-- This architecture is currently not complete
-- it just includes:
-- instruction register (complete)
-- program counter (complete)
-- instruction ram memory (complete)
-- control unit (UNCOMPLETE)
-- datapath

architecture dlx_rtl of DLX is

--------------------------------------------------------------------
-- Components Declaration
--------------------------------------------------------------------

-- Instruction Ram And Data Ram are in the TestBench and you must connect it using

--    IRAM_ADDRESS      : out std_logic_vector(Instr_size - 1 downto 0);
--    IRAM_ISSUE        : out std_logic;
--    IRAM_READY        : in std_logic;
--    IRAM_DATA         : in std_logic_vector(Data_size-1 downto 0);
--
--    DRAM_ADDRESS      : out std_logic_vector(Instr_size-1 downto 0);
--    DRAM_ISSUE        : out std_logic;
--    DRAM_READNOTWRITE : out std_logic;
--    DRAM_READY        : in std_logic;
--    DRAM_DATA         : inout std_logic_vector(Data_size-1 downto 0)

  -- Control Unit
  component CU_HW is
    generic (
      OP_CODE_SIZE                  : integer := op_size;           -- Op Code Size
      IR_SIZE                       : integer := instruction_size;  -- Instruction Register Size
      FUNC_SIZE                     : integer := function_size;     -- Func Field Size for R-Type Ops
      CW_SIZE                       : integer := control_word_size  -- Control Word Size
    ); -- Control Word Size
    port (
      Clk                : in  std_logic;  -- Clock
      Rst                : in  std_logic;  -- Reset: Active-Low
      -- Instruction Register
      IR_IN              : in  std_logic_vector(IR_SIZE - 1 downto 0);
      -- Pipeline stage 1
      EN0                : out std_logic;
      -- Pipeline stage 2
      EN1                : out std_logic;  -- enables the register le and the pipeline registers
      RF1                : out std_logic;  -- enables the read port 1 of the register ﬁle
      RF2                : out std_logic;  -- enables the read port 2 of the register ﬁle
      -- Pipeline stage 3
      EN2                : out std_logic;  -- enables the pipe registers
      S1                 : out std_logic;  -- input selection of the first multiplexer
      S2                 : out std_logic;  -- input selection of the second multiplexer
      ALU1               : out std_logic;  -- alu control bit 1
      ALU2               : out std_logic;  -- alu control bit 2
      ALU3               : out std_logic;  -- alu control bit 3
      ALU4               : out std_logic;  -- alu control bit 4
      -- Pipeline stage 4
      EN3                : out std_logic;  -- enables the memory and the pipeline register
      DEN                : out std_logic;  -- enables the ram memory
      RW                 : out std_logic;  -- enables the read-out (1) or the write-in (0) of the memory
      -- Pipeline stage 5
      S3                 : out std_logic;  -- input selection of the multiplexer
      WF1                : out std_logic   -- enables the write port of the register ﬁle
    );
  end component;

  component datapath is
    port (
    -- inputs
      -- control signals
      clk     : in  std_logic;  -- clock
      rst     : in  std_logic;  -- reset: active-low
      -- stage 1
      en0     : in  std_logic;
      ir      : in  std_logic_vector(instruction_size - 1 downto 0);
      pc_in   : in  std_logic_vector(word_size - 1 downto 0);
      -- stage 2
      en1     : in  std_logic;  -- enables the register file and the pipeline registers
      rf1     : in  std_logic;  -- enables the read port 1 of the register file
      rf2     : in  std_logic;  -- enables the read port 2 of the register file
      -- stage 3
      en2     : in  std_logic;  -- enables the pipe registers
      s1      : in  std_logic;  -- input selection of the first multiplexer
      s2      : in  std_logic;  -- input selection of the second multiplexer
      alu1    : in  std_logic;  -- alu control bit 1
      alu2    : in  std_logic;  -- alu control bit 2
      alu3    : in  std_logic;  -- alu control bit 3
      alu4    : in  std_logic;  -- alu control bit 4
      -- stage 4
      en3     : in  std_logic;  -- enables the dram and the pipeline register
      rw      : in  std_logic;  -- enables the read-out (1) or the write-in (0) of the memory
      den     : in  std_logic;
      dram_rw_en   : out std_logic;
      dram_enable  : out std_logic;
      dram_rd_data : in  std_logic_vector(word_size - 1 downto 0);      -- from dram output
      dram_addr    : out std_logic_vector(dram_addr_size - 1 downto 0); -- to dram address
      dram_wr_data : out std_logic_vector(word_size - 1 downto 0);      -- to dram input
      pc_out       : out std_logic_vector(word_size - 1 downto 0);
      -- stage 5
      s3    : in  std_logic;  -- input selection of the multiplexer
      wf1   : in  std_logic   -- enables the write port of the register ﬁle
    );
  end component; -- datapath


  ----------------------------------------------------------------
  -- Signals Declaration
  ----------------------------------------------------------------

  -- Instruction Register (IR) and Program Counter (PC) declaration
  signal IR : std_logic_vector(IR_SIZE - 1 downto 0);
  signal PC : std_logic_vector(PC_SIZE - 1 downto 0);

  -- Instruction Ram Bus signals
  -- signal IRam_Dout : std_logic_vector(IR_SIZE - 1 downto 0);

  -- Datapath Bus signals
  signal PC_BUS : std_logic_vector(PC_SIZE -1 downto 0);

  -- Control Unit Bus signals
  signal EN0_int  : std_logic;
  signal EN1_int  : std_logic;
  signal RF1_int  : std_logic;
  signal RF2_int  : std_logic;
  signal EN2_int  : std_logic;
  signal S1_int   : std_logic;
  signal S2_int   : std_logic;
  signal ALU1_int : std_logic;
  signal ALU2_int : std_logic;
  signal ALU3_int : std_logic;
  signal ALU4_int : std_logic;
  signal EN3_int  : std_logic;
  signal DEN_int  : std_logic;
  signal RW_int   : std_logic;
  signal S3_int   : std_logic;
  signal WF1_int  : std_logic;

  -- Data Ram Bus signals


  begin  -- DLX

    -- This is the input to program counter: currently zero
    -- so no updade of PC happens
    -- TO BE REMOVED AS SOON AS THE DATAPATH IS INSERTED!!!!!
    -- a proper connection must be made here if more than one
    -- instruction must be executed
    --PC_BUS <= (others => '0');


    -- purpose: Instruction Register Process
    -- type   : sequential
    -- inputs : Clk, Rst, IRam_DOut, IR_LATCH_EN_i
    -- outputs: IR_IN_i
    IR_P: process (Clk, Rst)
    begin  -- process IR_P
      if Rst = '0' then                 -- asynchronous reset (active low)
        IR <= (others => '0');
      elsif Clk'event and Clk = '1' then  -- rising clock edge
        if (IR_LATCH_EN_i = '1') then
          IR <= IRAM_DATA;
        end if;
      end if;
    end process IR_P;

    -- COMPLETE WITH CACHE TO CONNECT IRAM and DRAM in the testbench...
    IRAM_ADDRESS <= PC_BUS;

    -- purpose: Program Counter Process
    -- type   : sequential
    -- inputs : Clk, Rst, PC_BUS
    -- outputs: IRam_Addr
    PC_P: process (Clk, Rst)
    begin  -- process PC_P
      if Rst = '0' then                 -- asynchronous reset (active low)
        PC <= (others => '0');
      elsif Clk'event and Clk = '1' then  -- rising clock edge
        if (PC_LATCH_EN_i = '1') then
          PC <= PC_BUS;
        end if;
      end if;
    end process PC_P;

    -- Control Unit Instantiation
    CU : CU_HW
    port map (
      Clk   => Clk,
      Rst   => Rst,
      IR_I  => IR,
      EN0   => EN0_int,
      EN1   => EN1_int,
      RF1   => RF1_int,
      RF2   => RF2_int,
      EN2   => EN2_int,
      S1    => S1_int ,
      S2    => S2_int ,
      ALU1  => ALU1_in,
      ALU2  => ALU2_in,
      ALU3  => ALU3_in,
      ALU4  => ALU4_in,
      EN3   => EN3_int,
      DEN   => DEN_int,
      RW    => RW_int ,
      S3    => S3_int ,
      WF1   => WF1_int
    );

  -- DATAPATH

  dp : datapath
  port map(
    clk           => Clk,
    rst           => Rst,
    -- stage 1
    en0           => EN0_int,
    ir            => IR,
    pc_in         => PC_BUS,
    -- stage 2
    en1           => EN1_int,
    rf1           => RF1_int,
    rf2           => RF2_int,
    -- stage 3
    en2           => EN2_int,
    s1            => S1_int ,
    s2            => S2_int ,
    alu1          => ALU1_in,
    alu2          => ALU2_in,
    alu3          => ALU3_in,
    alu4          => ALU4_in,
    -- stage 4
    en3           => EN3_int,
    rw            => RW_int,
    den           => DEN_int,
    dram_rw_en    => DRAM_READNOTWRITE,
    dram_enable   => ,
    dram_rd_data  => DRAM_DATA,
    dram_addr     => DRAM_ADDRESS,
    dram_wr_data  => DRAM_DATA,
    pc_out        => PC_BUS,
    -- stage 5
    s3            => S3_int ,
    wf1           => WF1_int
  );

end dlx_rtl;
