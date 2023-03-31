library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bregs is
	generic(WSIZE : natural := 32);
    
port( 
		clk,wren,rst : in std_logic;
  		rs1,rs2,rd : in std_logic_vector(4 downto 0);
  		data : in std_logic_vector(WSIZE -1 downto 0);
 	 	ro1, ro2 : out std_logic_vector(WSIZE -1 downto 0)
);
end bregs;

architecture ach of bregs is 
type regArray is array(natural range <>) of std_logic_vector(31 downto 0);
signal xregs: regArray(WSIZE-1 downto 0) := (others => (others => '0'));

begin
	process(rst,clk)
    begin if(rst = '1') then
    --Reset
        	for i in 0 to 31 loop
            	xregs(i) <= x"00000000"; 
            end loop;
            ro1 <= x"00000000";
            ro2 <= x"00000000";
    else
    --Leitura

    	if(rising_edge(clk) and wren = '1') then  
    		--Escrita
    		xregs(to_integer(unsigned(rd))) <= x"00000000" when rd = "00000" else data;
            end if;
            ro1 <= x"00000000" when rs1 = "00000" else xregs(to_integer(unsigned(rs1)));
        	ro2 <= x"00000000" when rs2 = "00000" else xregs(to_integer(unsigned(rs2)));
        end if;
    end process;


end ach;
