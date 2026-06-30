library IEEE;
use IEEE.std_logic_1164.all;

entity mux_n is
generic(dataSize: natural := 8);
port(
    e0 : in bit_vector(dataSize-1 downto 0); -- entrada de dados 0
    e1 : in bit_vector(dataSize-1 downto 0); -- entrada de dados 1
    sel : in bit; -- sinal de selecao
    s : out bit_vector(dataSize-1 downto 0) -- saida de dados
);
end entity mux_n;

architecture arch_mux of mux_n is
begin

    s <= e0 when sel = '0' else e1;

end architecture arch_mux;