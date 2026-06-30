library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fluxo_dados is
port(
    clock : in bit; -- entrada de clock
    reset : in bit; -- entrada de reset
    dificuldade : in bit; -- entrada de nível de dificuldade
    inicio_confirmacao : in bit; -- entrada de inicio-confirmacao
    alternativa : in bit_vector(3 downto 0); -- entrada de alternativas
    r_RB : in bit; -- controle: reset RB
    e_RB : in bit; -- controle: enable RB
    r_CEnd : in bit; -- controle: reset CEnd
    e_CEnd : in bit; -- controle: enable CEnd
    r_used : in bit; -- controle: reset data_used RAMPerg
    w_used : in bit; -- controle: escrita data_used RAMPerg
    r_RD : in bit; -- controle: reset RD
    e_RD : in bit; -- controle: enable RD
    r_CRod : in bit; -- controle: reset CRod
    e_CRod : in bit; -- controle: enable CRod
    r_RPts : in bit; -- controle: reset RPts
    e_RPts : in bit; -- controle: enable RPts
    icPressionado : out bit; -- condicao: início-confirmacao pression.
    altPressionada : out bit; -- condicao: alguma alternativa pression.
    acerto : out bit; -- condicao: resposta certa
    usada : out bit; -- condicao: pergunta usada
    fim : out bit; -- condição e saida: fim de jogo
    pts_hex1 : out bit_vector(6 downto 0); -- saida: pontos HEX1
    pts_hex0 : out bit_vector(6 downto 0); -- saida: pontos HEX0
    db_altEscolhida : out bit_vector(3 downto 0); -- debug: altEscolhida
    db_resposta : out bit_vector(3 downto 0); -- debug: resposta RAM
    db_numRodada : out bit_vector(3 downto 0); -- debug: rodada atual
    db_ultRodada : out bit_vector(3 downto 0); -- debug: ultima rod.
    db_pts_totais : out bit_vector(7 downto 0) -- debug: pontos bin.
);
end entity fluxo_dados;
