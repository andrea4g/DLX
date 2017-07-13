library ieee;
use ieee.std_logic_1164.all;

package Control_Unit_Type is
-- Control unit input sizes
    constant OP_CODE_SIZE    : integer :=  6;                                       -- OPCODE field size
    constant FUNC_SIZE       : integer :=  11;                                      -- FUNC field size

-- R-Type instruction -> FUNC field
    constant R_ADD : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000000";    -- ADD RS1,RS2,RD
    constant R_SUB : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000001";    -- SUB RS1,RS2,RD
    constant R_AND : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000010";    -- AND RS1,RS2,RD
    constant R_OR  : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000011";    -- OR  RS1,RS2,RD
    constant R_XOR : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000100";    -- new!! XOR
    constant R_SGE : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000101";    -- new!! SGE
    constant R_SLE : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000110";    -- new!! SLE
    constant R_SLL : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000000111";    -- new!! SLL
    constant R_SNE : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000001000";    -- new!! SNE
    constant R_SRL : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000001001";    -- new!! SRL
    constant R_SUB : std_logic_vector(FUNC_SIZE - 1 downto 0) :=  "00000001010";    -- new!! SUB

-- R-Type instruction -> OPCODE field
    constant NOP     : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000000";    -- no operation
    constant RTYPE   : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000001";    -- for ADD, SUB, AND, OR register-to-register operation
-- I-Type instruction -> OPCODE field
    constant I_ADDI1 : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000010";    -- ADDI1  RS2,RD,INP1
    constant I_SUBI1 : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000011";    -- SUBI1  RS2,RD,INP1
    constant I_ANDI1 : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000100";    -- ANDI1  RS2,RD,INP1
    constant I_ORI1  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000101";    -- ORI1   RS2,RD,INP1
    constant I_XORI  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000110";    -- XORI   new!!!
    constant I_ADDI2 : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "000111";    -- ADDI2  RS1,RD,INP2
    constant I_SUBI2 : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "001000";    -- SUBI2  RS1,RD,INP2
    constant I_ANDI2 : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "001001";    -- ANDI2  RS1,RD,INP2
    constant I_ORI2  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "001010";    -- ORI2   RS1,RD,INP2
    constant I_MOV   : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "001011";    -- MOV    RS1,RD       -- R[RD] = R[RS1]   -- RD = RS1 OR 0
    constant I_SW    : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "001100";    -- new!! SW
    constant I_SGEI  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "001101";    -- new!! SGEI
    constant I_SLEI  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "001110";    -- new!! SLEI
    constant I_SLLI  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "001111";    -- new!! SLLI
    constant I_SNEI  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "010000";    -- new!! SNEI
    constant I_SRLI  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "010001";    -- new!! SRLI
    constant I_SUBI  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "010010";    -- new!! SUBI
    constant S_REG1  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "010011";    -- S_REG1 RD, INP1     -- R[RD] = INP1
    constant S_REG2  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "010100";    -- S_REG2 RD, INP2
    constant S_MEM2  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "010101";    -- S MEM2 RS1,RS2,INP1 -- MEM[R[RS2]+INP1] = R[RS1]
    constant L_MEM1  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "010110";    -- L_MEM1 RD, RS2,INP1 -- R[RD] = MEM[R[RS2]+INP1]
    constant L_MEM2  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "010111";    -- L_MEM2 RS1,RD ,INP2 -- R[RD] = MEM[R[RS1]+INP2]
-- J-Type instruction -> OPCODE field
    constant J_BEQZ  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "011000";    -- new!! BEQZ
    constant J_BNEZ  : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "011001";    -- new!! BNEZ
    constant J       : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "011010";    -- new!! J
    constant J_JAL   : std_logic_vector(OP_CODE_SIZE - 1 downto 0) :=  "011011";    -- new!! JAL
end package;
