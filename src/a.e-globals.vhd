library ieee;
use ieee.std_logic_1164.all;
use work.functions.all;

package globals is

  constant instruction_size  : integer := 32;
  constant word_size         : integer := 32;
  constant add_size          : integer := log2(32);

  constant opcode_up         : integer :=  31;
  constant opcode_down       : integer :=  26;
  constant r1_up             : integer :=  25;
  constant r1_down           : integer :=  21;
  constant r2_up             : integer :=  20;
  constant r2_down           : integer :=  16;
  constant r3_up             : integer :=  15;
  constant r3_down           : integer :=  11;
  constant inp2_up           : integer :=  15;
  constant inp2_down         : integer :=  0;
  constant func_up           : integer :=  10;
  constant func_down         : integer :=  0;

  constant dram_addr_size    : integer := 32;

  constant op_size           : integer := 6;
  constant function_size     : integer := 11;
  constant control_word_size : integer := 13;

end package;
