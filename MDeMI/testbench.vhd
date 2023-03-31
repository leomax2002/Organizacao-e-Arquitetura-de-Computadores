-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;


entity testbench is
end entity;

architecture arch of testbench is

component mem_rv is

	port(

	clock: in std_logic;
	we: in std_logic;
    address: in std_logic_vector(7 downto 0);
    datain: in std_logic_vector(31 downto 0);
	dataout: out std_logic_vector(31 downto 0)
    
);


end component;


 component mem_read_rv is

	port(

	clock2: in std_logic;
    address2: in std_logic_vector(7 downto 0);
	dataout2: out std_logic_vector(31 downto 0)
    
);

end component;

signal clock_MD,we_MD: std_logic;
signal address_MD: std_logic_vector(7 downto 0);
signal datain_MD: std_logic_vector(31 downto 0);
signal dataout_MD: std_logic_vector(31 downto 0);

signal clock_MI,we_MI: std_logic;
signal address_MI: std_logic_vector(7 downto 0);
signal dataout_MI: std_logic_vector(31 downto 0);

begin

    
    MD: mem_rv 
    port map(
    		clock => clock_MD,
			we => we_MD,
            address => address_MD,
			datain => datain_MD,
            dataout => dataout_MD
    		
    );
    
	 MI: mem_read_rv 
     port map(
    		clock2 => clock_MI,
            address2 => address_MI,
            dataout2 => dataout_MI
    		
    );
   drive: process begin
   we_MD <= '1';
   
   for i in 0 to 255 loop
   		if(i > 125) then
        	we_MD <= '0';
        end if;
   		clock_MD <= '0';
   		address_MI <= std_logic_vector(to_unsigned(i,8));
        address_MD <= std_logic_vector(to_unsigned(i,8));
        datain_MD <= std_logic_vector(to_unsigned(i,30)) & "00";
        wait for 1 ns;
        clock_MD <= '1';
        wait for 1 ns;
   end loop;
	wait;
	end process;
    
end arch;