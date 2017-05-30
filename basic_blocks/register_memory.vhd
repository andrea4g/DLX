library ieee;
use ieee.std_logic_1164.all;
use ieee.numeic_std.all;
use work.functions.all;
use work.all;

entity register_memory is
  generic(n : integer := 1);
  port(
    -- control signals
    clk     : in  std_logic;
    rst     : in  std_logic;
    en      : in  std_logic;
    rm      : in  std_logic;
    wm      : in  std_logic;
    -- inputs
    address : in  std_logic_vector(log2(n) - 1 downto 0);
    data    : in  std_logic_vector(n - 1 downto 0);
    -- output
    o       : out std_logic_vector(n - 1 downto 0)
  );
end entity;

architecture behavioral of register_memory is

  -- suggested structures
  subtype reg_addr  is natural range 0 to n - 1; -- using natural type
  type    reg_array is array(reg_addr) of std_logic_vector(10 * n - 1 downto 0);

  signal registers : reg_array;

  begin

  process(clk, rst, en) -- sensitivity list
  begin
    if (clk = '1' and clk'event) then
      if(rst = '0') then  -- reset is checked only at the rising edge of clock.
        -- start with the other operations
        if (en = '1') then
          -- enable active => let's see the operation the rf has to perform
          -- read
          if (rm = '1') then
            o <= registers(to_integer(unsigned(address)));
          end if;
          if (wr = '1') then
            registers (to_integer(unsigned(address))) <= data;
          end if;
        else
          out2 <= (others => '0');
          out1 <= (others => '0');
        end if;
      else
        registers <= (others =>(others =>'0'));
      end if;
    end if;
  end process;
end architecture;
