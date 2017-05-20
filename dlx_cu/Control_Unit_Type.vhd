library ieee;
use ieee.std_logic_1164.all;

package Control_Unit_Type is
  -- Control unit input sizes
  constant OP_CODE_SIZE    : integer :=  6;                                       -- OPCODE field size
  constant FUNC_SIZE       : integer :=  11;                                      -- FUNC field size

  -- recall that RD is always the address of the output
  
  -- R-Type instruction -> OPCODE field
  constant NOP     : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000000";    -- no operation
  constant RTYPE   : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000001";    -- for ADD, SUB, AND, OR register-to-register operation
  -- R-Type instruction -> FUNC field
  constant R_ADD : std_logic_vector(FUNC_SIZE - 1 downto 0) := "00000000000";    -- ADD RS1,RS2,RD
  constant R_SUB : std_logic_vector(FUNC_SIZE - 1 downto 0) := "00000000001";    -- SUB RS1,RS2,RD
  constant R_AND : std_logic_vector(FUNC_SIZE - 1 downto 0) := "00000000010";    -- AND RS1,RS2,RD
  constant R_OR  : std_logic_vector(FUNC_SIZE - 1 downto 0) := "00000000011";    -- OR  RS1,RS2,RD

  -- I-Type instruction -> OPCODE field
  constant I_ADDI1 : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000010";    -- ADDI1  RS1,RD,INP1
  constant I_SUBI1 : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000011";    -- SUBI1  RS1,RD,INP1
  constant I_ANDI1 : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000100";    -- ANDI1  RS1,RD,INP1
  constant I_ORI1  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000101";    -- ORI1   RS1,RD,INP1
  constant I_ADDI2 : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000110";    -- ADDI2  RS1,RD,INP2
  constant I_SUBI2 : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "000111";    -- SUBI2  RS1,RD,INP2
  constant I_ANDI2 : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "001010";    -- ANDI2  RS1,RD,INP2
  constant I_ORI2  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "001001";    -- ORI2   RS1,RD,INP2
  constant MOV     : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "001000";    -- MOV    RS2,RS2      -- R[RS2] = R[RS1]
  constant S_REG1  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "001011";    -- S_REG1 RD, INP1     -- R[RD] = INP1
  constant S_REG2  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "001110";    -- S_REG2 RS1 INP2
  constant S_MEM1  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "001101";    -- S MEM2 RS1,RS2,INP1 -- MEM[R[RS1]+INP2] = R[RS2]
  constant S_MEM2  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "001100";    -- S_MEM2 RS1,RD, INP2
  constant L_MEM1  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "001111";    -- L_MEM1 RS1,RS2,INP1 -- R[RS2] = MEM[R[RS1]+INP1]
  constant S_MEM2  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) := "010000";    -- L_MEM2 RS1,RS2,INP2

end package;
