
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity show_bitao is
port(
    clock : in bit; -- entrada de clock
    reset : in bit; -- entrada de reset
    dificuldade : in bit; -- entrada de nível de dificuldade
    inicio_confirmacao : in bit; -- entrada de inicio-confirmacao
    alternativa : in bit_vector(3 downto 0); -- entrada de alternativas
    fim : out bit; -- saida: fim de jogo
    pts_hex1 : out bit_vector(6 downto 0); -- saida: pontos HEX1
    pts_hex0 : out bit_vector(6 downto 0); -- saida: pontos HEX0
    db_altEscolhida : out bit_vector(3 downto 0); -- debug: altEscolhida
    db_resposta : out bit_vector(3 downto 0); -- debug: resposta RAM
    db_numRodada : out bit_vector(3 downto 0); -- debug: rodada atual
    db_ultRodada : out bit_vector(3 downto 0); -- debug: ultima rod.
    db_pts_totais : out bit_vector(7 downto 0); -- debug: pontos bin.
    db_estado : out bit_vector(3 downto 0) -- debug: estado atual
);
end entity show_bitao;