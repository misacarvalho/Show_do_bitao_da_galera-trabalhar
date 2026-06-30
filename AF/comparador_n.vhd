library IEEE;
use IEEE.std_logic_1164.all;

entity comparador_n is
generic(dataSize: natural := 8);
port(
    a : in bit_vector(dataSize-1 downto 0); -- entrada de dados A
    b : in bit_vector(dataSize-1 downto 0); -- entrada de dados B
    a_gt_b : out bit; -- saida A > B
    a_eq_b : out bit; -- saida A = B
    a_lt_b : out bit -- saida A < B
);
end entity comparador_n;

architecture comp_behav of comparador_n is
begin
    
    a_gt_b <= '1' when (a > b) else '0';
    a_eq_b <= '1' when (a = b) else '0';
    a_lt_b <= '1' when (a < b) else '0'; 

end architecture comp_behav;