-------------------------------------------------------------------------
-- Arquivo   : ram_quiz.vhd
-- Projeto   : Show do Bitão (PCS3115 - Sistemas Digitais I)
-------------------------------------------------------------------------
-- Descricao : Memória de Respostas e Flags de Uso de Perguntas
-------------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor                    Descricao
--     2026-05-23  1.0     Leonardo N. Varella      versão inicial
--     2026-05-25  2.0     Antonio V. da S. Neto    Adaptação para bit
--                                                  e bit_vector, inclusão
--                                                  de comentários extras e
--                                                  aprimoramento do código
-------------------------------------------------------------------------

library ieee;
use ieee.numeric_bit.all;

entity ram_quiz is
    port (
        clk    : in  bit;                         -- Entrada de clock
        write_used : in  bit;                     -- Sinal de escrita: se '1', escreve '1' no campo de uso na próxima borda de clk
        reset_used : in  bit;                     -- Sinal de reset de uso: se '1', escreve '0' assincronamente no campo de uso
        address   : in  bit_vector(5 downto 0);   -- Endereço: 6 bits (64 perguntas)
        data_resp   : out bit_vector(3 downto 0); -- Saída: resposta da pergunta usada.
        data_used: out bit                        -- Saída: indicação de uso da pergunta no jogo ('0' livre, '1' usada)
    );
end entity ram_quiz;

architecture behavioral of ram_quiz is

    -- Estrutura interna da memória: MSB (4 bits) com gabarito; LSB (1 bit) com flag de uso
    type msb_mem_t is array (0 to 63) of bit_vector(3 downto 0);
    type lsb_mem_t is array (0 to 63) of bit;

    -- Iniciação: MSB com valores somente leitura fornecidos
    constant msb_mem : msb_mem_t := (
        0  => "1000",
        1  => "0100",
        2  => "0010",
        3  => "0001",
        4  => "0001",
        5  => "0010",
        6  => "0100",
        7  => "1000",
        8  => "1000",
        9  => "0100",
        10 => "0010",
        11 => "0001",
        12 => "0001",
        13 => "0010",
        14 => "0100",
        15 => "1000",
        16 => "1000",
        17 => "0001",
        18 => "1000",
        19 => "0001",
        20 => "0100",
        21 => "0010",
        22 => "0100",
        23 => "0010",
        24 => "1000",
        25 => "0001",
        26 => "1000",
        27 => "0001",
        28 => "0100",
        29 => "0010",
        30 => "0100",
        31 => "0010",
        32 => "0001",
        33 => "0010",
        34 => "0100",
        35 => "1000",
        36 => "1000",
        37 => "0100",
        38 => "0010",
        39 => "0001",
        40 => "0001",
        41 => "0010",
        42 => "0100",
        43 => "1000",
        44 => "1000",
        45 => "0100",
        46 => "0010",
        47 => "0001",
        48 => "0001",
        49 => "0001",
        50 => "0001",
        51 => "0001",
        52 => "0010",
        53 => "0010",
        54 => "0010",
        55 => "0010",
        56 => "0100",
        57 => "0100",
        58 => "0100",
        59 => "0100",
        60 => "1000",
        61 => "1000",
        62 => "1000",
        63 => "1000"
    );

    -- LSB: Começa com '0' e é modificada durante o funcionamento
    signal lsb_mem : lsb_mem_t := (others => '0');

begin

    -- Leitura assíncrona da memória
    data_resp <= msb_mem(to_integer(unsigned(address)));
    data_used <= lsb_mem(to_integer(unsigned(address)));

    -- Processamento síncrono do LSB (flag de uso)
    --   reset_used: Se '1', assincronamente coloca LSB em '0'
    --   write_used Se '1', coloca LSB em '1' na próxima borda do clock
    lsb_logic : process(clk, reset_used)
    begin
        if reset_used = '1' then
            lsb_mem <= (others => '0');
        elsif rising_edge(clk) then
            if write_used = '1' then
                lsb_mem(to_integer(unsigned(address))) <= '1';
			else  -- Não faz nada se não tiver escrita ativada
			    NULL;
			end if;	
        end if;
    end process lsb_logic;

end architecture behavioral;