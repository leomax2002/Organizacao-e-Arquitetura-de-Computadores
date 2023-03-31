library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity testbench is
end entity;

architecture arch of testbench is

component genImm32 is
	port(
    		instr: in std_logic_vector(31 downto 0);
            imm32: out signed(31 downto 0)
            );
end component;

signal instr_o: std_logic_vector(31 downto 0);
signal imm32_o: signed(31 downto 0);

begin

dut: genImm32 port map(
		instr => instr_o,
        imm32 => imm32_o
        );
 
drive: process begin

       instr_o <= x"000002b3";
       wait for 10 ns;
       
       instr_o <= x"01002283";
       wait for 10 ns;
       
       instr_o <= x"f9c00313";
       wait for 10 ns;
       
       instr_o <= x"fff2c293";
       wait for 10 ns;
       
       instr_o <= x"16200313";
       wait for 10 ns;
       
       instr_o <= x"01800067";
       wait for 10 ns;
       
       instr_o <= x"00002437";
       wait for 10 ns;
       
       instr_o <= x"02542e23";
       wait for 10 ns;
       
       instr_o <= x"fe5290e3";
       wait for 10 ns;
       
       instr_o <= x"00c000ef";
       wait for 10 ns; 
       
              instr_o <= x"FACAF0FA";
       wait for 10 ns; 
       wait;
       
       end process;
end arch;
