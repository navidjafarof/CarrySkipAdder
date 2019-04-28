library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity cs_adder_tb is
end entity cs_adder_tb;

architecture testbench of cs_adder_tb is
	component cs_adder is
		generic (
			number_of_blocks : integer := 8;
			number_of_bits   : integer := 8
		);
		port (
			a    : in  std_logic_vector(number_of_bits*number_of_blocks-1 downto 0);
			b    : in  std_logic_vector(number_of_bits*number_of_blocks-1 downto 0);
			cin  : in  std_logic;
			cout : out std_logic;
			sum  : out std_logic_vector(number_of_bits*number_of_blocks-1 downto 0)
		);
	end component cs_adder;

	constant number_of_blocks : integer := 8;
	constant number_of_bits   : integer := 8;

	signal a      : std_logic_vector(number_of_bits*number_of_blocks-1 downto 0);
	signal b      : std_logic_vector(number_of_bits*number_of_blocks-1 downto 0);
	signal cin    : std_logic;
	signal cout   : std_logic;
	signal sum    : std_logic_vector(number_of_bits*number_of_blocks-1 downto 0);
	signal result : std_logic_vector(number_of_bits*number_of_blocks-1 downto 0);

begin
	DUT : cs_adder
		generic map (
			number_of_blocks => number_of_blocks,
			number_of_bits   => number_of_bits
		)
		port map (
			a    => a,
			b    => b,
			cin  => cin,
			cout => cout,
			sum  => sum
		);

	process begin
		a      <= (0 => '0' , 1 => '0', others => '1');
		b      <= (0 => '1' , 1 => '1' , others => '0');
		cin    <= '1';
		result <= (others => '0');
		WAIT FOR 2 ns;
		ASSERT sum = result REPORT "failed";

		for I in 0 TO 100 loop
			for J in 0 TO 100 loop
				a      <= conv_std_logic_vector(I, 64);
				b      <= conv_std_logic_vector(J, 64);
				cin    <= '0';
				result <= conv_std_logic_vector(J+I, 64);
				WAIT FOR 1 ns;
				ASSERT result = result REPORT INTEGER'IMAGE(I) & " " & INTEGER'IMAGE(J) & " failed.";
			end loop;
		end loop;
		for I in 0 TO 100 loop
			for J in 0 TO 100 loop
				a      <= conv_std_logic_vector(I, 64);
				b      <= conv_std_logic_vector(J, 64);
				cin    <= '1';
				result <= conv_std_logic_vector(J+I+1, 64);
				WAIT FOR 1 ns;
				ASSERT result = result REPORT INTEGER'IMAGE(I) & " " & INTEGER'IMAGE(J) & " failed 2.";
			end loop;
		end loop;
		WAIT;
	end process;

end architecture testbench;