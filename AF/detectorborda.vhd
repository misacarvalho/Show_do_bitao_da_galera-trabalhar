library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity detectorborda is
port(
    reset : in bit; -- entrada de reset assíncrono
    dado : in bit; -- entrada de dado: sinal cuja borda deve ser detectada
    clk : in bit; -- entrada de clock
    pulso : out bit -- saída: pulso de um ciclo de clock após dado subir
);
end entity detectorborda;

architecture arch_detect of detectorborda is

    -- Sinais internos em formato de vtor (bit_vector) de 1 posição para garantir a compatibilidade com a interface do registrador_n
    signal d_ff1 : bit_vector(0 downto 0);
    signal out1  : bit_vector(0 downto 0);
    signal out2  : bit_vector(0 downto 0);

begin
    --Fluxo de dados: Converte a entrada escalar bit para o vetor bit_vector
    d_ff1(0) <= dado;

    -- Instanciação estrutural do Flip-Flop 1 (FF1)
    FF1: entity work.registrador_n
        generic map (
            dataSize => 1
        )
        port map (
            clk    => clk,
            reset  => reset,
            enable => '1',
            d      => d_ff1,
            q      => out1
        );

    -- Instanciação estrutural do Flip-Flop 2 (FF2)
    FF2: entity work.registrador_n
        generic map (
            dataSize => 1
        )
        port map (
            clk    => clk,
            reset  => reset,
            enable => '1',
            d      => out1,-- A entrada do FF2 recebe a saída do FF1
            q      => out2
        );

    -- Lógica combinatória de saída (Porta AND + Inversor) em fluxo de dados. Extrai o bit indexando a posição (0) dos vetores
    pulso <= out1(0) and (not out2(0));

end architecture arch_detect;
