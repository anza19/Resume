library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.textio.all;
use IEEE.std_logic_textio.all;

entity g69_FIR_tb is
end g69_FIR_tb;

architecture test of g69_FIR_tb is
---------------------------------------
--Declare the component under test
---------------------------------------

component g69_FIR is
	port(x: in std_logic_vector(15 downto 0);
	  	clk: in std_logic;
	  	rst: in std_logic;
		y: out std_logic_vector(16 downto 0));
end component g69_FIR;

---------------------------------------
--Testbench internal signals
---------------------------------------
file file_VECTORS_X : text;
file file_RESULTS : text;

constant clk_PERIOD : time := 100 ns;

signal x_in : std_logic_vector(15 downto 0);
signal clk_in : std_logic;
signal rst_in : std_logic;
signal y_out : std_logic_vector(16 downto 0);

begin
---------------------------------------
--Instantiate FIR
---------------------------------------
	g69_FIR_INST : g69_FIR port map(x => x_in,
					clk => clk_in,
					rst => rst_in,
					y => y_out);

---------------------------------------
--Clock Generation
---------------------------------------
	clk_generation : process
	begin
		clk_in <= '1';
		wait for clk_PERIOD / 2;
		clk_in <= '0';
		wait for clk_PERIOD / 2;
	end process;

---------------------------------------
--Feeding Inputs
---------------------------------------
feeding_instr : process is
	variable v_lline1 : line;
	variable v_Oline : line;
	variable v_x_in : std_logic_vector(15 downto 0);
	
begin
--reset the circuit
	rst_in <= '1';
	wait until rising_edge(clk_in);
	wait until rising_edge(clk_in);
	rst_in <= '0';

	file_open(file_VECTORS_X, "F:\McGill University\WINTER 2019\ECSE 325 - Digital Systems\ECSE_325_Lab3_Group69\lab3-input-fixed.txt", read_mode);
	file_open(file_RESULTS, "F:\McGill University\WINTER 2019\ECSE 325 - Digital Systems\ECSE_325_Lab3_Group69\lab3-out.txt", write_mode);

	while not endfile(file_VECTORS_X) loop
		readline(file_VECTORS_X, v_lline1);
		read(v_lline1, v_x_in);

	x_in <= v_x_in;

	wait until rising_edge(clk_in);
	write(v_Oline, y_out);
	writeline(file_RESULTS, v_Oline);
	
	end loop;
	wait;
end process;
end test;

