library ieee;
use ieee.std_logic_1164.all;
entity ripple_carry_adder is 
generic(width: integer := 8);
    port(
        a : in std_logic_vector(width-1 downto 0);
        b : in std_logic_vector(width-1 downto 0);
        cin: in std_logic;
        sum: out std_logic_vector(width-1 downto 0);
        p: out std_logic_vector(width-1 downto 0);
        cout: out std_logic
    );
end entity;
architecture test of ripple_carry_adder is 
signal cin_vector: std_logic_vector(width downto 0);
component full_adder
port(
    a : in std_logic;
    b : in std_logic;
    cin: in std_logic;
    sum: out std_logic;
    cout: out std_logic;
    p: out std_logic
);
end component;
begin
    cin_vector(0) <= cin;
    full_adder_array: for i in 0 to width-1 generate
        adder_i: full_adder port map (a(i), b(i), cin_vector(i), sum(i),cin_vector(i+1),p(i));
    end generate;
    cout<=cin_vector(width);
end architecture;
