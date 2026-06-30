library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity unidade_controle is
port(
    clock : in bit; -- entrada de clock
    reset : in bit; -- entrada de reset
    icPressionado : in bit; -- condicao: início-confirmacao pression.
    altPressionada : in bit; -- condicao: alguma alternativa pression.
    acerto : in bit; -- condicao: resposta certa
    usada : in bit; -- condicao: pergunta usada
    fim : in bit; -- condição: fim de jogo
    r_RB : out bit; -- controle: reset RB
    e_RB : out bit; -- controle: enable RB
    r_CEnd : out bit; -- controle: reset CEnd
    e_CEnd : out bit; -- controle: enable CEnd
    r_used : out bit; -- controle: reset data_used RAMPerg
    w_used : out bit; -- controle: escrita data_used RAMPerg
    r_RD : out bit; -- controle: reset RD
    e_RD : out bit; -- controle: enable RD
    r_CRod : out bit; -- controle: reset CRod
    e_CRod : out bit; -- controle: enable CRod
    r_RPts : out bit; -- controle: reset RPts
    e_RPts : out bit; -- controle: enable RPts
    db_estado : out bit_vector(3 downto 0) -- debug: estado atual
);
end entity unidade_controle;

