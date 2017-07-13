library ieee;
use ieee.std_logic_1164.all;
use work.globals.all;

package Control_Unit_Type is

  -- J-Type instruction -> OPCODE field
  constant J       : std_logic_vector(op_size - 1 downto 0) :=  "000010";    -- J (0x02)
  constant J_JAL   : std_logic_vector(op_size - 1 downto 0) :=  "000011";    -- JAL (0x03)
  constant J_BEQZ  : std_logic_vector(op_size - 1 downto 0) :=  "000100";    -- BEQZ (0x04)
  constant J_BNEZ  : std_logic_vector(op_size - 1 downto 0) :=  "000101";    -- BNEZ (0x05)
  --constant J_JR    : std_logic_vector(op_size - 1 downto 0) :=  "010010";    -- JR (0x12)
  --constant J_JALR  : std_logic_vector(op_size - 1 downto 0) :=  "010011";    -- JALR (0x13)
  -- R-Type instruction -> OPCODE field
  constant NOP     : std_logic_vector(op_size - 1 downto 0) :=  "010101";    -- no operation (0X15)
  constant RTYPE   : std_logic_vector(op_size - 1 downto 0) :=  "000001";    -- for ADD, SUB, AND, OR register-to-register operation
  -- I-Type instruction -> OPCODE field
  constant I_ADDI : std_logic_vector(op_size - 1 downto 0) :=  "001000";    -- ADDI  RS1,RD,INP2 (0x08)
  constant I_SUBI : std_logic_vector(op_size - 1 downto 0) :=  "001010";    -- SUBI  RS1,RD,INP2 (0x0A)
  constant I_ANDI : std_logic_vector(op_size - 1 downto 0) :=  "001100";    -- ANDI  RS1,RD,INP2 (0xC)
  constant I_ORI  : std_logic_vector(op_size - 1 downto 0) :=  "001101";    -- ORI   RS1,RD,INP2 (0xD)
  constant I_XOR  : std_logic_vector(op_size - 1 downto 0) :=  "001110";    -- XOR   RS1,RD,INP2 (0xE)
  constant I_SLLI : std_logic_vector(op_size - 1 downto 0) :=  "010100";    -- SLLI (0x14)
  constant I_SRLI : std_logic_vector(op_size - 1 downto 0) :=  "010110";    -- SRLI (0x16)
  constant I_SRAI : std_logic_vector(op_size - 1 downto 0) :=  "010111";    -- SRAI (0x17)
  constant I_SNEI : std_logic_vector(op_size - 1 downto 0) :=  "011001";    -- SNEI (0x19)
  constant I_SLEI : std_logic_vector(op_size - 1 downto 0) :=  "011100";    -- SGEI (0x1C)
  constant I_SGEI : std_logic_vector(op_size - 1 downto 0) :=  "011101";    -- SLEI (0x1D)
  constant I_LW   : std_logic_vector(op_size - 1 downto 0) :=  "100011";    -- LW RS1,RD ,INP2 -- R[RD] = MEM[R[RS1]+INP2] (0x23)
  constant I_SW   : std_logic_vector(op_size - 1 downto 0) :=  "101011";    -- SW (0x2B)

-- R-Type instruction -> FUNC field
  constant R_ADD : std_logic_vector(function_size - 1 downto 0) :=  "00000000000";    -- ADD RS1,RS2,RD
  constant R_SUB : std_logic_vector(function_size - 1 downto 0) :=  "00000001111";    -- SUB RS1,RS2,RD
  constant R_AND : std_logic_vector(function_size - 1 downto 0) :=  "00000001000";    -- AND RS1,RS2,RD
  constant R_OR  : std_logic_vector(function_size - 1 downto 0) :=  "00000001110";    -- OR  RS1,RS2,RD
  constant R_XOR : std_logic_vector(function_size - 1 downto 0) :=  "00000000110";    -- XOR
  constant R_SGE : std_logic_vector(function_size - 1 downto 0) :=  "00000001010";    -- SGE
  constant R_SLE : std_logic_vector(function_size - 1 downto 0) :=  "00000001010";    -- SLE
  constant R_SLL : std_logic_vector(function_size - 1 downto 0) :=  "00000000010";    -- SLL
  constant R_SRL : std_logic_vector(function_size - 1 downto 0) :=  "00000000100";    -- SRL
  constant R_SRA : std_logic_vector(function_size - 1 downto 0) :=  "00000000101";    -- SRA
  constant R_SNE : std_logic_vector(function_size - 1 downto 0) :=  "00000000011";    -- SNE

end package;
