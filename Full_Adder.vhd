library ieee;
use ieee.std_logic_1164.all;
entity full_adder is
    port(
        a    : in  std_logic;
        b    : in  std_logic;
        cin  : in  std_logic;
        sum  : out std_logic;
        cout : out std_logic;
        p    : out std_logic
    );
end entity;
architecture structural of full_adder is
begin
    sum  <= a xor b xor cin;
    cout <= (a and b) or (a and cin) or (b and cin);
    p    <= a xor b;
end architecture;
