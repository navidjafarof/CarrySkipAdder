library ieee;
use ieee.std_logic_1164.all;
entity cs_adder is 
generic(number_of_blocks: integer := 8;
        number_of_bits: integer := 8);
    port(
        a : in std_logic_vector(number_of_bits*number_of_blocks-1 downto 0);
        b : in std_logic_vector(number_of_bits*number_of_blocks-1 downto 0);
        cin: in std_logic;
        cout: out std_logic;
        sum: out std_logic_vector(number_of_bits*number_of_blocks-1 downto 0)
    );
end entity;
architecture test of cs_adder is 
signal skip_result_array: std_logic_vector(number_of_blocks downto 0);
component csa_block is 
generic(width: integer := 8);
    port(
        a : in std_logic_vector(width-1 downto 0);
        b : in std_logic_vector(width-1 downto 0);
        cin: in std_logic;
        sum: out std_logic_vector(width-1 downto 0);
        skip_res: out std_logic
    );
end component;
begin
    block_array: for i in 0 to number_of_blocks - 1 generate
        csa_block_i: csa_block port map (a  ((((i+1) * number_of_bits)-1) downto ((i * number_of_bits))), 
													  b  ((((i+1) * number_of_bits)-1) downto ((i * number_of_bits))),
													  skip_result_array(i),
													  sum((((i+1) * number_of_bits)-1) downto ((i * number_of_bits))),
													  skip_result_array(i+1));
													  end generate;
	skip_result_array(0) <= cin;
	cout<= skip_result_array(number_of_blocks);
    
end architecture;
