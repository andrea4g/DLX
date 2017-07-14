library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
--use work.Control_Unit_Type.all;
use work.globals.all;

entity CU_HW is
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
end entity;

architecture cu_rtl of CU_HW is

  signal IR_opcode : std_logic_vector(OP_CODE_SIZE -1 downto 0) := (others => '0');  -- OpCode part of IR
  signal IR_func   : std_logic_vector(FUNC_SIZE - 1 downto 0) := (others => '0');   -- Func part of IR when Rtype
  signal CW        : std_logic_vector(CW_SIZE - 1 downto 0) := (others => '0'); -- full control word read from cw_mem

begin  -- cu_rtl

  IR_opcode(op_size   - 1 downto 0)  <= IR_IN(opcode_up downto opcode_down);
  IR_func  (FUNC_SIZE - 1 downto 0)  <= IR_IN(FUNC_SIZE - 1 downto 0);

  -- Process assigning the control word values
  process (IR_opcode, IR_func) is
  begin
    if Rst = '0'                                  then CW <= (others => '0'); -- Reset
    elsif IR_opcode = J                           then CW <= "1100101000010000"; -- J
    elsif IR_opcode = J_JAL                       then CW <= "0000000000000000"; -- JAL
    elsif IR_opcode = J_BEQZ                      then CW <= "1110101000010000"; -- I_BEQZ
    elsif IR_opcode = J_BNEZ                      then CW <= "0000000000000000"; -- I_BNEZ
    elsif IR_opcode = NOP                         then CW <= "1100000000000000"; -- NOP
    elsif (IR_opcode = RTYPE and IR_func = R_ADD) then CW <= "1111110000010011"; -- R_ADD
    elsif (IR_opcode = RTYPE and IR_func = R_SUB) then CW <= "1111110111110011"; -- R_SUB
    elsif (IR_opcode = RTYPE and IR_func = R_AND) then CW <= "1111110100010011"; -- R_AND
    elsif (IR_opcode = RTYPE and IR_func = R_OR ) then CW <= "1111110111010011"; -- R_OR
    elsif (IR_opcode = RTYPE and IR_func = R_XOR) then CW <= "1111110011010011"; -- R_XOR
    elsif (IR_opcode = RTYPE and IR_func = R_SGE) then CW <= "1111110101010011"; -- R_SGE
    elsif (IR_opcode = RTYPE and IR_func = R_SLE) then CW <= "1111110101010011"; -- R_SLE
    elsif (IR_opcode = RTYPE and IR_func = R_SLL) then CW <= "1111110001010011"; -- R_SLL
    elsif (IR_opcode = RTYPE and IR_func = R_SRL) then CW <= "1111110010010011"; -- R_SRL
    elsif (IR_opcode = RTYPE and IR_func = R_SRA) then CW <= "1111110010110011"; -- R_SRL
    elsif (IR_opcode = RTYPE and IR_func = R_SNE) then CW <= "1111110001110011"; -- R_SNE
    elsif IR_opcode = I_ADDI                      then CW <= "1110111000010011"; -- I_ADDI
    elsif IR_opcode = I_SUBI                      then CW <= "1110111111110011"; -- I_SUBI
    elsif IR_opcode = I_ANDI                      then CW <= "1110111100010011"; -- I_ANDI
    elsif IR_opcode = I_ORI                       then CW <= "1110111111010011"; -- I_ORI
    elsif IR_opcode = I_XOR                       then CW <= "1110111011010011"; -- I_XOR
    elsif IR_opcode = I_SLLI                      then CW <= "1110111001010011"; -- I_SLLI
    elsif IR_opcode = I_SRLI                      then CW <= "1110111010010011"; -- I_SRLI
    elsif IR_opcode = I_SRAI                      then CW <= "1110111010110011"; -- I_SRAI
    elsif IR_opcode = I_SNEI                      then CW <= "1110111001110011"; -- I_SNEI
    elsif IR_opcode = I_SLEI                      then CW <= "1110111101010011"; -- I_SLEI
    elsif IR_opcode = I_SGEI                      then CW <= "1110111101010011"; -- I_SGEI
    elsif IR_opcode = I_LW                        then CW <= "1110111000011001"; -- LW
    elsif IR_opcode = I_SW                        then CW <= "0000000000000000"; -- SW
    else                                               CW <= (others => '0');
    end if;
  end process;

  -- process handling the output
  CW_PIPE: process (Clk, Rst)
  begin  -- process Clk
    if (Clk'event and Clk = '1') or Rst = '0' then  -- rising clock edge
      EN0  <= CW(CW_SIZE - 1);
      EN1  <= CW(CW_SIZE - 2);
      RF1  <= CW(CW_SIZE - 3);
      RF2  <= CW(CW_SIZE - 4);
      EN2  <= CW(CW_SIZE - 5);
      S1   <= CW(CW_SIZE - 6);
      S2   <= CW(CW_SIZE - 7);
      ALU1 <= CW(CW_SIZE - 8);
      ALU2 <= CW(CW_SIZE - 9);
      ALU3 <= CW(CW_SIZE - 10);
      ALU4 <= CW(CW_SIZE - 11);
      EN3  <= CW(CW_SIZE - 12);
      DEN  <= CW(CW_SIZE - 13);
      RW   <= CW(CW_SIZE - 14);
      S3   <= CW(CW_SIZE - 15);
      WF1  <= CW(CW_SIZE - 16);
    end if;
      -- if Rst = 0, CW will be all 0s and doing so every output will be reset
  end process CW_PIPE;

end architecture;
