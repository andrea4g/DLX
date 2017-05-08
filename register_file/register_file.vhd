library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.all;

entity register_file is
  generic (N : natural := 32);
  port (
    -- INPUTS
    CLK     : IN  std_logic;
    RESET   : IN  std_logic;
	  ENABLE  : IN  std_logic;
	  RD1     : IN  std_logic;
	  RD2     : IN  std_logic;
	  WR      : IN  std_logic;
	  ADD_WR  : IN  std_logic_vector(4  downto 0);
	  ADD_RD1 : IN  std_logic_vector(4  downto 0);
	  ADD_RD2 : IN  std_logic_vector(4  downto 0);
	  DATAIN  : IN  std_logic_vector(63 downto 0);
    -- OUTPUTS
    OUT1    : OUT std_logic_vector(63 downto 0);
	  OUT2    : OUT std_logic_vector(63 downto 0)
  );
end entity;

architecture behavioral of register_file is

  -- suggested structures
  subtype REG_ADDR  is natural range 0 to N - 1; -- using natural type
	type    REG_ARRAY is array(REG_ADDR) of std_logic_vector(2 * N - 1 downto 0);

	signal REGISTERS : REG_ARRAY;

begin

  process(clk) -- sensitivity list
  begin
    if (clk = '1' and clk'event) then
      if(reset = '0') then  -- reset is checked only at the rising edge of clock.
        -- start with the other operations
        if (enable = '1') then
          -- enable active => let's see the operation the RF has to perform
          -- READ1
          if (RD1 = '1') then
            OUT1 <= REGISTERS(to_integer(unsigned(ADD_RD1)));
          end if;
          -- READ2
          if (RD2 = '1') then
            OUT2 <= REGISTERS(to_integer(unsigned(ADD_RD2)));
          end if;
          -- WRITE
          if (WR = '1') then
            REGISTERS (to_integer(unsigned(ADD_WR))) <= DATAIN;
            if ADD_RD1 = ADD_WR then
  					 OUT1 <= DATAIN;
  				  end if;
  				  if ADD_RD2 = ADD_WR then
  					 OUT2 <= DATAIN;
  				  end if;
          end if;
        end if;
      else
        OUT1 <= (others => 'Z');
        OUT2 <= (others => 'Z');
      end if;
    else
      REGISTERS <= (others =>(others =>'0'));
    end if;
  end process;

end architecture;

--configuration CFG_RF_BEH of register_file is
--  for A
--  end for;
--end configuration;
