
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity hexa7seg is
port(
    hexa : in bit_vector(3 downto 0); -- entrada: nibble (4 bits)
    sseg : out bit_vector(6 downto 0) -- saída: nibble em 7 segmentos
);
end entity hexa7seg;


architecture arch_decoder of hexa7seg is
begin
    with hexa select
        sseg <= "1000000" when "0000", -- 0 (apenas 'g' apagado)
                "1111001" when "0001", -- 1 (apenas 'b' e 'c' acesos)
                "0100100" when "0010", -- 2 (a, b, d, e, g acesos)
                "0110000" when "0011", -- 3 (a, b, c, d , g acesos)
                "0011001" when "0100", -- 4 (b, c, f, g acesos)
                "0010010" when "0101", -- 5 (a, c, d, f, g acesos)
                "0000010" when "0110", -- 6 (a, c, d, e, f, g acesos)
                "1111000" when "0111", -- 7 (a, b, c acesos)
                "0000000" when "1000", -- 8 (todos acesos)
                "0010000" when "1001", -- 9(a, b, c, d, f, g acesos)
                "0001000" when "1010", -- A(a, b, c, e, f, g acesos)
                "0000011" when "1011", -- b (c, d, e, f, g acesos)
                "1000110" when "1100", -- C (a, d, e, f acesos)
                "0100001" when "1101", -- d (b, c, d, e, g acesos)
                "0000110" when "1110", -- E (a, d, e, f, g acesos)
                "0001110" when "1111", -- F (a, e, f, g acesos)
                "1111111" when others; --Todos apagados por segurança
                
end architecture arch_decoder;