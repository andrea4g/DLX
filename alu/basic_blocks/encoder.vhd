library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity encoder is
  generic(n : integer := 2);
  port (
    out_add     : in  std_logic_vector(n - 1 downto 0);
    out_sub     : in  std_logic_vector(n - 1 downto 0);
    out_sl      : in  std_logic_vector(n - 1 downto 0);
    out_sr      : in  std_logic_vector(n - 1 downto 0);
    sel         : in  std_logic_vector(2 downto 0);
    o           : out std_logic_vector(n - 1 downto 0)
  );
end entity;

architecture behavioral of encoder is

begin

  o <= out_add          when sel = "000" else -- add
       out_sub          when sel = "001" else -- sub
       out_sl           when sel = "010" else -- sll
       out_sl           when sel = "011" else -- sla
       out_sr           when sel = "100" else -- srl
       out_sr           when sel = "101" else -- sra
       (others => '0')  when sel = "110" else -- bu
       (others => 'X');

end architecture; -- behavioral
