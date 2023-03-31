library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity testbench is
	generic(WSIZE : natural := 32);
end entity;

architecture arch of testbench is

component ulaRV is
	port( 
		opcode: in std_logic_vector(3 downto 0);
  		A,B : in std_logic_vector(WSIZE -1 downto 0);
 	 	Z : out std_logic_vector(WSIZE -1 downto 0)
);
end component;


signal opcode_in: std_logic_vector(3 downto 0);
signal A_in,B_in : std_logic_vector(WSIZE -1 downto 0);
signal Z_out : std_logic_vector(WSIZE -1 downto 0);


begin

dut: ulaRV port map(
		opcode => opcode_in,
         A => A_in,
  		 B => B_in,
  		 Z => Z_out
        );
 
drive: process begin
	--Testa Soma
	opcode_in <= "0000";
    A_in <= x"00000003";
    B_in <= x"00000004";
    wait for 5 ns;
    
	assert Z_out = x"00000007"
    	report "Soma Incorreta"
    	severity error;
    wait for 5 ns;
    
    --Testa Subtracao
    opcode_in <= "0001";
   	A_in <= x"00000002";
    B_in <= x"00000003";
    wait for 5 ns;
    assert Z_out = std_logic_vector(signed(A_in) - signed(B_in))
    report "Subtracao Incorreta"
    severity error;
    wait for 5 ns;
    
    --Testa AND
    opcode_in <= "0010";
   	A_in <= x"00000002";
    B_in <= x"00000003";
    wait for 5 ns;
    assert Z_out = (A_in AND B_in)
    report "AND Incorreta"
    severity error;
    wait for 5 ns;
    
    --Testa OR
    opcode_in <= "0011";
   	A_in <= x"00000002";
    B_in <= x"00000003";
    wait for 5 ns;
    assert Z_out = (A_in OR B_in)
    report "OR Incorreta"
    severity error;
    wait for 5 ns;
    
    --Testa XOR
    opcode_in <= "0100";
   	A_in <= x"00000002";
    B_in <= x"00000003";
    wait for 5 ns;
    assert Z_out = (A_in XOR B_in)
    report "XOR Incorreta"
    severity error;
    wait for 5 ns;
    
    --Testa SLLA
    opcode_in <= "0101";
   	A_in <= x"00000001";
    B_in <= x"00000003";
    wait for 5 ns;
    assert Z_out = x"00000008"
    report "SLLA Incorreta"
    severity error;
    wait for 5 ns;
    
    --Testa SRLA
    opcode_in <= "0110";
   	A_in <= x"80000000";
    B_in <= x"00000003";
    wait for 5 ns;
    assert Z_out = x"10000000"
    report "SRLA Incorreta"
    severity error;
    wait for 5 ns;
    
    --Testa SRA
    opcode_in <= "0111";
   	A_in <= x"80000000";
    B_in <= x"00000003";
    wait for 5 ns;
    assert Z_out = x"F0000000"
    report "SRLA Incorreta"
    severity error;
    wait for 5 ns;
    
    --Testa SLT
    opcode_in <= "1000";
   	A_in <= x"F0000000";
    B_in <= x"00000010";
    wait for 5 ns;
    assert Z_out = x"00000001"
    report "SLT Incorreta"
    severity error;
    wait for 5 ns;
    
    --Testa SLTU
    opcode_in <= "1001";
   	A_in <= x"F0000000";
    B_in <= x"00000010";
    wait for 5 ns;
    assert Z_out = x"00000000"
    report "SLTU Incorreta"
    severity error;
    wait for 5 ns;
    
    --Testa SGE
    opcode_in <= "1010";
   	A_in <= x"F0000000";
    B_in <= x"00000010";
    wait for 5 ns;
    assert Z_out = x"00000000"
    report "SGE Incorreta"
    severity error;
    wait for 5 ns;
    
    --Testa SGEU
    opcode_in <= "1011";
   	A_in <= x"F0000000";
    B_in <= x"00000010";
    wait for 5 ns;
    assert Z_out = x"00000001"
    report "SGEU Incorreta"
    severity error;
    wait for 5 ns;
    
    --Testa SEQ
    opcode_in <= "1100";
   	A_in <= x"80000000";
    B_in <= x"80000000";
    wait for 5 ns;
    assert Z_out = x"00000001"
    report "SEQ Incorreta"
    severity error;
    wait for 5 ns;
    
    --Testa SNE
    opcode_in <= "1101";
   	A_in <= x"00001000";
    B_in <= x"80000000";
    wait for 5 ns;
    assert Z_out = x"00000001"
    report "SNE Incorreta"
    severity error;
    wait for 5 ns;
    
    opcode_in <= "0000";
   	A_in <= x"00000000";
    B_in <= x"00000000";
    wait for 10 ns;
    
  wait;  
end process;

end arch;



