library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity g69_lab2 is
port(	  	  x: 		in std_logic_vector(11 downto 0); --11
		  y: 		in std_logic_vector(11 downto 0); --11
		  N: 		in std_logic_vector(9 downto 0);
		  clk: 		in std_logic;
		  rst: 		in std_logic;
		  mac: 		out std_logic_vector(23 downto 0);
		  ready: 	out std_logic);
end g69_lab2;

architecture logic of g69_lab2 is
	signal mac_temp : signed(23 downto 0);
--signal temp : signed(23 downto 0);

	begin
	mac_math : process(clk, rst, x, y)
		begin
		if rst = '1' then
			mac_temp <= (others => '0');	
		elsif rising_edge(clk) then
			ready <= '0';
				for i in 1 to 1000 loop
					mac_temp <= mac_temp + (signed(x) * signed(y));
				end loop;
			ready <= '1';
		end if;
	end process;
	mac <= std_logic_vector(mac_temp);
end logic;		