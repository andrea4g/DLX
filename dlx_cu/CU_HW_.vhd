library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.Control_Unit_Type.all;

entity CU_HW is
  generic (
    OP_CODE_SIZE                  : integer := 6;   -- Op Code Size
    IR_SIZE                       : integer := 32;  -- Instruction Register Size
    FUNC_SIZE                     : integer := 11;  -- Func Field Size for R-Type Ops
    CW_SIZE                       : integer := 13   -- Control Word Size
  ); -- Control Word Size
  port (
    Clk                : in  std_logic;  -- Clock
    Rst                : in  std_logic;  -- Reset : Active-Low
    -- Instruction Register
    IR_IN              : in  std_logic_vector(IR_SIZE - 1 downto 0);
    -- Pipe stage 1
    EN1                : out std_logic;  -- enables the register le and the pipeline registers
    RF1                : out std_logic;  -- enables the read port 1 of the register ﬁle
    RF2                : out std_logic;  -- enables the read port 2 of the register ﬁle
    WF1                : out std_logic;  -- enables the write port of the register ﬁle
    -- Pipe stage 2
    EN2                : out std_logic;  -- enables the pipe registers
    S1                 : out std_logic;  -- input selection of the ﬁrst multiplexer
    S2                 : out std_logic;  -- input selection of the second multiplexer
    ALU1               : out std_logic;  -- alu control bit 1
    ALU2               : out std_logic;  -- alu control bit 2
    -- Pipe stage 3
    EN3                : out std_logic;  -- enables the memory and the pipeline register
    RM                 : out std_logic;  -- enables the read-out of the memory
    WM                 : out std_logic;  -- enables the write-in of the memory
    S3                 : out std_logic   -- input selection of the multiplexer
  );
end entity;

architecture cu_rtl of CU_HW is

  signal IR_opcode : std_logic_vector(OP_CODE_SIZE -1 downto 0) := (others => '0');  -- OpCode part of IR
  signal IR_func   : std_logic_vector(FUNC_SIZE - 1 downto 0) := (others => '0');   -- Func part of IR when Rtype
  signal CW        : std_logic_vector(CW_SIZE - 1 downto 0) := (others => '0'); -- full control word read from cw_mem

begin  -- cu_rtl

  IR_opcode(5 downto 0) <= IR_IN(31 downto 26);
  IR_func(10 downto 0)  <= IR_IN(FUNC_SIZE - 1 downto 0);

  -- Process assigning the control word values
  process (IR_opcode, IR_func) is
  begin
    if Rst = '0'              then CW <= (others => '0'); -- Reset
    elsif IR_opcode = NOP     then CW <= "0000000000000"; -- NOP
    elsif IR_opcode = I_ADDI1 then CW <= "1011111001000"; -- I_ADDI1
    elsif IR_opcode = I_SUBI1 then CW <= "1011111011000"; -- I_SUBI1
    elsif IR_opcode = I_ANDI1 then CW <= "1011111101000"; -- I_ANDI1
    elsif IR_opcode = I_ORI1  then CW <= "1011111111000"; -- I_ORI1
    elsif IR_opcode = I_ADDI2 then CW <= "1101100001000"; -- I_ADDI2
    elsif IR_opcode = I_SUBI2 then CW <= "1101100011000"; -- I_SUBI2
    elsif IR_opcode = I_ANDI2 then CW <= "1101100101000"; -- I_ANDI2
    elsif IR_opcode = I_ORI2  then CW <= "1101100111000"; -- I_ORI2
    elsif IR_opcode = I_MOV   then CW <= "1101100111000"; -- I_MOV
    elsif IR_opcode = S_REG1  then CW <= "1001110111000"; -- S_REG1
    elsif IR_opcode = S_REG2  then CW <= "1001110111000"; -- S_REG2
    elsif IR_opcode = S_MEM2  then CW <= "1110100001010"; -- S_MEM2
    elsif IR_opcode = L_MEM1  then CW <= "1011111001101"; -- L_MEM1
    elsif IR_opcode = L_MEM2  then CW <= "1101100001101"; -- L_MEM2
    elsif (IR_opcode = RTYPE and IR_func = R_ADD) then CW <= "1111101001000"; -- R_ADD
    elsif (IR_opcode = RTYPE and IR_func = R_SUB) then CW <= "1111101011000"; -- R_SUB
    elsif (IR_opcode = RTYPE and IR_func = R_AND) then CW <= "1111101101000"; -- R_AND
    elsif (IR_opcode = RTYPE and IR_func = R_OR ) then CW <= "1111101111000"; -- R_OR
    else                           CW <= (others => '0');
    end if;
  end process;

  -- process handling the output
  CW_PIPE: process (Clk, Rst)
  begin  -- process Clk
    if (Clk'event and Clk = '1') or Rst = '0' then  -- rising clock edge
      EN1  <= CW(CW_SIZE - 1);
      RF1  <= CW(CW_SIZE - 2);
      RF2  <= CW(CW_SIZE - 3);
      EN2  <= CW(CW_SIZE - 4);
      S1   <= CW(CW_SIZE - 5);
      S2   <= CW(CW_SIZE - 6);
      ALU1 <= CW(CW_SIZE - 7);
      ALU2 <= CW(CW_SIZE - 8);
      EN3  <= CW(CW_SIZE - 9);
      RM   <= CW(CW_SIZE - 10);
      WM   <= CW(CW_SIZE - 11);
      S3   <= CW(CW_SIZE - 12);
      WF1  <= CW(CW_SIZE - 13);
    end if;
      -- if Rst = 0, CW will be all 0s and doing so every output will be reset
  end process CW_PIPE;

end architecture;
