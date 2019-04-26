library ieee;
use ieee.std_logic_1164.all;
entity csa_block is 
generic(width: integer := 8);
    port(
        a : in std_logic_vector(width-1 downto 0);
        b : in std_logic_vector(width-1 downto 0);
        cin: in std_logic;
        sum: out std_logic_vector(width-1 downto 0);
        skip_res: out std_logic
    );
end entity;
architecture test of csa_block is 
signal cout: std_logic;
signal p: std_logic_vector(width-1 downto 0);
component ripple_carry_adder
generic(width: integer := 8);
    port(
        a : in std_logic_vector(width-1 downto 0);
        b : in std_logic_vector(width-1 downto 0);
        cin: in std_logic;
        sum: out std_logic_vector(width-1 downto 0);
        p: out std_logic_vector(width-1 downto 0);
        cout: out std_logic
    );
end component;
component skip_logic is 
    generic(width: integer := 8);
    port(
        p : in std_logic_vector(width - 1 downto 0);
		  cin : in std_logic;
		  cout : in std_logic;
        out_signal : out std_logic
    );
end component;
begin
    adder: ripple_carry_adder port map(a,b,cin,sum,p,cout);
    skiplogic: skip_logic port map(p,cin,cout,skip_res);
end architecture;
