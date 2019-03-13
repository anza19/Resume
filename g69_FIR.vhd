library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity g69_FIR is
port ( 	
		x			   : in std_logic_vector(15 downto 0); --Input signal
		clk			   : in std_logic;  --Clock
		rst			   : in std_logic;  --Asynchronous active-high reset
		y 			   : out std_logic_vector(16 downto 0));  --Output signal
end g69_FIR;

architecture logic of g69_FIR is
	
	type MULTI_ARRAY is array(24 downto 0) of signed(15 downto 0);	--This will create a multidimensional array for weights and input signals
	signal weights : MULTI_ARRAY;					--Holds the 25 weights
	signal input_signal : MULTI_ARRAY;				-- This will hold the input signals	
	signal sum1  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum2  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum3  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum4  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum5  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum6  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum7  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum8  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum9  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum10  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum11  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum12  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum13  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum14  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum15  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum16  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum17  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum18  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum19  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum20  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum21  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum22  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum23  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum24  : signed(31 downto 0);				--Temp variable for incrementing
	signal sum25  : signed(31 downto 0);				--Temp variable for incrementing
	
	signal final_sum : signed(31 downto 0);	
	begin
		
		--Assign the weights 
		weights(0) <= "0000001001110011"; --done, 1
		weights(1) <= "0000000000010001"; --done, 2
		weights(2) <= "1111111111010010"; --done, 3
		weights(3) <= "1111111011011101"; --done, 4
		weights(4) <= "0000001100011010"; --done, 5
		weights(5) <= "1111110110100111"; --done, 6
		weights(6) <= "1111110000001101"; --done, 7
		weights(7) <= "0000110110111101"; --done, 8
		weights(8) <= "1110110001110010"; --done, 9
		weights(9) <= "0000110111111000"; --done, 10
		weights(10) <= "0000001100001000"; --done, 11
		weights(11) <= "1110101000001010"; --done, 12
		weights(12) <= "0001111000110100"; --done, 13
		weights(13) <= "1110101000001010"; --done, 14
		weights(14) <= "0000001100001000"; --done, 15
		weights(15) <= "0000110111111000"; --done, 16
		weights(16) <= "1110110001110010"; --done, 17
		weights(17) <= "0000110110111101"; --done, 18
		weights(18) <= "1111110000001101"; --done, 19
		weights(19) <= "1111110110100111"; --done, 20 
		weights(20) <= "0000001100011010"; --done, 21
		weights(21) <= "1111111011011101"; --done, 22
		weights(22) <= "1111111111010010"; --done, 23
		weights(23) <= "0000000000010001"; --done, 24
		weights(24) <= "0000001001110011"; --done, 25
		
		--We perform convolution in this process block	
		convolution : process(rst, clk)
		begin
			if rst = '1' then
				--Reset input array values to 0
				input_signal <= (others=>(others=>'0'));
			
			elsif(rising_edge(clk)) then
				--Reset the temp total
				final_sum <= "00000000000000000000000000000000"; --33

				--We cycle throught the input signals and pass the i-1th entry
				--To the ith entry in order to perform convolution
				for i in 1 to 24 loop
					input_signal(i) <= input_signal(i-1); 
				end loop;
				
				--The first input signal in the array gets the current value of x
				input_signal(0) <= signed(x);

				--Actual convolution is performed in this loop
				--We convolve the ith weight with the 25th -ith input signal
				--And store the sum
				sum1 <= input_signal(24)*weights(0);
				sum2 <= input_signal(23)*weights(1);
				sum3 <= input_signal(22)*weights(2);
				sum4 <= input_signal(21)*weights(3);
				sum5 <= input_signal(20)*weights(4);
				sum6 <= input_signal(19)*weights(5);
				sum7 <= input_signal(18)*weights(6);
				sum8 <= input_signal(17)*weights(7);
				sum9 <= input_signal(16)*weights(8);
				sum10 <= input_signal(15)*weights(9);
				sum11 <= input_signal(14)*weights(10);
				sum12 <= input_signal(13)*weights(11);
				sum13 <= input_signal(12)*weights(12);
				sum14 <= input_signal(11)*weights(13);
				sum15 <= input_signal(10)*weights(14);
				sum16 <= input_signal(9)*weights(15);
				sum17 <= input_signal(8)*weights(16);
				sum18 <= input_signal(7)*weights(17);
				sum19 <= input_signal(6)*weights(18);
				sum20 <= input_signal(5)*weights(19);
				sum21 <= input_signal(4)*weights(20);
				sum22 <= input_signal(3)*weights(21);
				sum23 <= input_signal(2)*weights(22);
				sum24 <= input_signal(1)*weights(23);
				sum25 <= input_signal(0)*weights(24);
				
				final_sum <= sum1+sum2+sum3+sum4+sum5+sum6+sum7+sum8+sum9+sum10+sum11+sum12+sum13+sum14+sum15+sum16+sum17+sum18+sum19+sum20+sum21+sum22+sum23+sum24+sum25;
			end if;
		end process convolution;
	--Assign result to output outside of the process block 
	--We truncate the unused digits
	y <= std_logic_vector(final_sum(31 downto 15));
end logic;