library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity genImm32 is
	port(
    		instr: in std_logic_vector(31 downto 0);
            imm32: out signed(31 downto 0)
            );
end entity;

architecture ach of genImm32 is 
signal opc: std_logic_vector(7 downto 0);
begin
	gerador : process(instr,opc) begin
    opc <= '0' & instr(6 downto 0);
	case opc is
    	when x"33" => imm32 <= x"00000000";
        when x"03" => imm32 <= resize(signed(instr(31 downto 20)),32);
        when x"13" => imm32 <= resize(signed(instr(31 downto 20)),32);
        when x"67" => imm32 <= resize(signed(instr(31 downto 20)),32);
        when x"23" => imm32 <= resize(signed(instr(31 downto 25) & instr(11 downto 7)),32);
        when x"63" => imm32 <= resize(signed(instr(31) & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0'),32);
        when x"6F" => imm32 <= resize(signed(instr(31) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0'),32);
        when x"37" => imm32 <= resize(signed(instr(31 downto 12) & x"000"),32);
        when others=> imm32 <= x"00000001";
    end case;
    
    end process gerador;

end ach;