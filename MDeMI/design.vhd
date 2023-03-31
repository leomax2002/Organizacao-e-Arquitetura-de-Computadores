library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;

entity mem_rv is

port(

	clock: in std_logic;
	we: in std_logic;
    address: in std_logic_vector(7 downto 0);
    datain: in std_logic_vector(31 downto 0);
	dataout: out std_logic_vector(31 downto 0)
    
);
end entity mem_rv;

architecture RTL of mem_rv is

Type mem_type is array (0 to (2**address'length)-1) of std_logic_vector(dataout'range);

signal mem: mem_type := (others => (others => '0'));
signal read_address: std_logic_vector(address'range);

begin

Write: process(clock) begin

	if ( we = '1') then
    	mem(to_integer(unsigned(address))) <= datain;
    end if;
    read_address <= address;
    
  end process;
  
  dataout <= mem(to_integer(unsigned(read_address)));
    

end architecture;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.textio.all;


entity mem_read_rv is

port(

	clock2: in std_logic;
    address2: in std_logic_vector(7 downto 0);
	dataout2: out std_logic_vector(31 downto 0)
    
);
end entity mem_read_rv;



architecture RTT of mem_read_rv is

--procedure READLINE (file: F: TEXT; L: inout LINE);

--type LINE is access STRING;

Type rom_type is array (0 to (2**address2'length)-1) of std_logic_vector(dataout2'range);

impure function init_rom_hex return rom_type is

	file text_file: text open read_mode is "rom.txt";
    variable text_line: line;
    variable rom_content: rom_type;
    
begin

	for i in 0 to (2**address2'length-1) loop
    	readline(text_file, text_line);
        hread(text_line, rom_content(i));
    end loop;
    
    return rom_content;
    
end function;

signal memRTT: rom_type := init_rom_hex;

begin

	dataout2 <= memRTT(to_integer(unsigned(address2)));
    
end RTT;

