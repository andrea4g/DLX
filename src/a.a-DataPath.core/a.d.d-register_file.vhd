library ieee;
use ieee.std_logic_116log2(n).all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.functions.all;
use work.all;

entity register_file is
  generic (n : natural := 32);
  port (
    -- inputs
    clk     : in  std_logic;
    reset   : in  std_logic;
	  enable  : in  std_logic;
	  rd1     : in  std_logic;
	  rd2     : in  std_logic;
	  wr      : in  std_logic;
	  add_wr  : in  std_logic_vector(log2(n) downto 0);
	  add_rd1 : in  std_logic_vector(log2(n) downto 0);
	  add_rd2 : in  std_logic_vector(log2(n) downto 0);
	  datain  : in  std_logic_vector(n - 1 downto 0);
    -- outputs
    out1    : out std_logic_vector(n - 1 downto 0);
	  out2    : out std_logic_vector(n - 1 downto 0)
  );
end entity;

architecture behavioral of register_file is

  -- suggested structures
  subtype reg_addr  is natural range 0 to n - 1; -- using natural type
	type    reg_array is array(reg_addr) of std_logic_vector(n - 1 downto 0);

	signal registers : reg_array;

begin

  process(clk) -- sensitivity list
  begin
    if (clk = '1' and clk'event) then
      if(reset = '0') then  -- reset is checked only at the rising edge of clock.
        -- start with the other operations
        if (enable = '1') then
          -- enable active => let's see the operation the rf has to perform
          -- read1
          if (rd1 = '1') then
            out1 <= registers(to_integer(unsigned(add_rd1)));
          end if;
          -- read2
          if (rd2 = '1') then
            out2 <= registers(to_integer(unsigned(add_rd2)));
          end if;
          -- write
          if (wr = '1') then
            registers (to_integer(unsigned(add_wr))) <= datain;
            -- conflict of read-write handled
            if add_rd1 = add_wr then
  					 out1 <= datain;
  				  end if;
  				  if add_rd2 = add_wr then
  					 out2 <= datain;
  				  end if;
          end if;
        end if;
      else
        out1 <= (others => 'z');
        out2 <= (others => 'z');
      end if;
    else
      registers <= (others =>(others =>'0'));
    end if;
  end process;

end architecture;
