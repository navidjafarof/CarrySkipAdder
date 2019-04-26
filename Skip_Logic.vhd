library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
entity skip_logic is 
    generic(width: integer := 8);
    port(
        p : in std_logic_vector(width - 1 downto 0);
		  cin : in std_logic;
		  cout : in std_logic;
        out_signal : out std_logic
    );
end entity;
architecture test of skip_logic is 
signal s: std_logic;
begin
	 s <= and_reduce(p);
	 out_signal<= cout when s = '1'  else cin;
end architecture;
