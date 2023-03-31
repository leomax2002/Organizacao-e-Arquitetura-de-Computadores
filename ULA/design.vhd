library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ulaRV is

generic(WSIZE : natural := 32);
      
    
port( 
		opcode: in std_logic_vector(3 downto 0);
  		A,B : in std_logic_vector(WSIZE -1 downto 0);
 	 	Z : out std_logic_vector(WSIZE -1 downto 0)
);
end ulaRV;

architecture ach of ulaRV is

--Constantes
constant ADD_OP: std_logic_vector(3 downto 0) := "0000";
constant SUB_OP: std_logic_vector(3 downto 0) := "0001";
constant AND_OP: std_logic_vector(3 downto 0) := "0010";
constant OR_OP: std_logic_vector(3 downto 0) := "0011";
constant XOR_OP: std_logic_vector(3 downto 0) := "0100";
constant SLLA_OP: std_logic_vector(3 downto 0) := "0101";
constant SRLA_OP: std_logic_vector(3 downto 0) := "0110";
constant SRA_OP: std_logic_vector(3 downto 0) := "0111";
constant SLT_OP: std_logic_vector(3 downto 0) := "1000";
constant SLTU_OP: std_logic_vector(3 downto 0) := "1001";
constant SGE_OP: std_logic_vector(3 downto 0) := "1010";
constant SGEU_OP: std_logic_vector(3 downto 0) := "1011";
constant SEQ_OP: std_logic_vector(3 downto 0) := "1100";
constant SNE_OP: std_logic_vector(3 downto 0) := "1101";

constant ZERO32: std_logic_vector(31 downto 0) := x"00000000";
constant ONE32: std_logic_vector(31 downto 0) := x"00000001";

signal zero: std_logic;
signal a32: std_logic_vector(31 downto 0);

begin
  	Z <= a32;
	proc_ula: process(A,B,opcode,a32) begin
    
    if(a32 = ZERO32) then zero <= '1'; else zero <= '0';end if;
    
	
    if    (opcode = ADD_OP) then a32 <= std_logic_vector(signed(A) + signed(B));
    elsif (opcode = SUB_OP) then a32 <= std_logic_vector(signed(A) - signed(B));
    elsif (opcode = AND_OP) then a32 <= A AND B;
    elsif (opcode = OR_OP) then a32 <= A OR B;
    elsif (opcode = XOR_OP) then a32 <= A XOR B;
    elsif (opcode = SLLA_OP) then a32 <= std_logic_vector(shift_left(unsigned(A),to_integer(unsigned(B))));
    elsif(opcode = SRLA_OP) then a32 <= std_logic_vector(shift_right(unsigned(A),to_integer(unsigned(B))));
    elsif(opcode = SRA_OP) then a32 <= std_logic_vector(shift_right(signed(A),to_integer(unsigned(B))));
    
    elsif(opcode = SLT_OP and signed(A) < signed(B)) then a32 <= ONE32;
    elsif(opcode = SLTU_OP and unsigned(A) < unsigned(B)) then a32 <= ONE32; 
    elsif(opcode = SGE_OP and signed(A) >= signed(B)) then a32 <= ONE32; 
    elsif(opcode = SGEU_OP and unsigned(A) >= unsigned(B)) then a32 <= ONE32; 
    elsif(opcode = SEQ_OP and A = B) then a32 <= ONE32;
    elsif(opcode = SNE_OP and A /= B) then a32 <= ONE32;
    
    else a32 <= ZERO32; 
    end if;
    
    
    
    end process;


end ach;


