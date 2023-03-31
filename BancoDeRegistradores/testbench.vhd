library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity testbench is
	generic(WSIZE : natural := 32);
end entity;

architecture arch of testbench is

component bregs is
	port(
    	clk,wren,rst : in std_logic;
  		rs1,rs2,rd : in std_logic_vector(4 downto 0);
  		data : in std_logic_vector(WSIZE -1 downto 0);
 	 	ro1, ro2 : out std_logic_vector(WSIZE -1 downto 0)
            );
end component;


signal clk,wren,rst: std_logic;
signal rs1_in, rs2_in, rd_in: std_logic_vector(4 downto 0);
signal data_in: std_logic_vector(WSIZE-1 downto 0); 
signal ro1_in, ro2_in: std_logic_vector(WSIZE-1 downto 0); 


begin

dut: bregs port map(
		clk => clk,
        wren => wren,
  		rst => rst,
  		rs1 => rs1_in,
  		rs2 => rs2_in,
  		rd => rd_in,
  		data => data_in,
  		ro1 => ro1_in,
  		ro2 => ro2_in
        );
 
drive: process begin
--Teste Escrever todos os Registradores
  rst <= '0'; 
  wren <= '1';
  rd_in <= "00001";
  data_in <= x"00000001";
  rs1_in <= "00000";
  rs2_in <= "00000";
  for i in 1 to 32 loop
  	clk <= '0';
  	wait for 25 ns;
  	clk <= '1';
  	wait for 25 ns;
  	rd_in <= std_logic_vector(unsigned(rd_in)+1);
    data_in <= std_logic_vector(unsigned(data_in)+1);
  	end loop;
    
--Teste Ler todos os Registradores  
  rd_in <= "00000";
  data_in <= x"00000000";
  for i in 1 to 32 loop
  	clk <= '0';
  	wait for 25 ns;
  	clk <= '1';
  	wait for 25 ns;
  	rs1_in <= std_logic_vector(unsigned(rs1_in)+1);
    rs2_in <= std_logic_vector(unsigned(rs2_in)+1);
    data_in <= std_logic_vector(unsigned(data_in)+1);
    assert ro1_in = data_in and ro2_in = data_in
    report "Registrador(es) não escrito(s)"
    severity error;
  	end loop;
        
--Teste Escrever todos os Registradores wren = 0
  rst <= '0'; 
  wren <= '0';
  rd_in <= "00001";
  data_in <= x"00000000";
  rs1_in <= "00000";
  rs2_in <= "00000";
  for i in 1 to 32 loop
  	clk <= '0';
  	wait for 25 ns;
  	clk <= '1';
  	wait for 25 ns;
  	rd_in <= std_logic_vector(unsigned(rd_in)+1);
  	end loop;
    
--Teste Ler todos os Registradores wren = 0 
  rd_in <= "00000";
  data_in <= x"10000000";
  for i in 1 to 32 loop
  	clk <= '0';
  	wait for 25 ns;
  	clk <= '1';
  	wait for 25 ns;
  	rs1_in <= std_logic_vector(unsigned(rs1_in)+1);
    rs2_in <= std_logic_vector(unsigned(rs2_in)+1);
    assert ro1_in /= data_in and ro2_in /= data_in
    report "Registrador(es) escrito(s)"
    severity error;
  	end loop;
    
--Teste Reset
  rst <= '1'; 
  wren <= '0';
  rd_in <= "00001";
  rs1_in <= "00000";
  rs2_in <= "00000";
  for i in 1 to 32 loop
  	clk <= '0';
  	wait for 25 ns;
  	clk <= '1';
  	wait for 25 ns;
    
  	rd_in <= std_logic_vector(unsigned(rd_in)+1);
    rs1_in <= std_logic_vector(unsigned(rs1_in)+1);
    rs2_in <= std_logic_vector(unsigned(rs2_in)+1);
    
    assert ro1_in = x"00000000" and ro2_in = x"00000000"
    report "Reset nao funcional"
    severity error;
    
  	end loop;
  wait;  
       end process;
end arch;
