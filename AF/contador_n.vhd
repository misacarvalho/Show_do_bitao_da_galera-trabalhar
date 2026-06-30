library IEEE;
use ieee.math_real.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity contador_n is
  generic (module : natural := 4);
  port (
    reset  : in bit; -- entrada de reset assincrono
    clk    : in bit; -- entrada de clock
    enable : in bit; -- entrada de controle de ativacao de contagem
    fim    : out bit; -- saida de fim de contagem;
    q      : out bit_vector(natural(ceil(log2(real(module)))) - 1 downto 0)
    -- saida com o valor da contagem
  );
end entity contador_n;

architecture arch_contador of contador_n is
  constant BIT_WIDTH : natural := natural(ceil(log2(real(module))));

  signal contagem_atual : unsigned(BIT_WIDTH - 1 downto 0);
begin

  p_contador : process (clk, reset)
  begin
    if reset = '1' then
      contagem_atual <= (others => '0');

    elsif clk'event and clk = '1' then
      if enable = '1' then
        if contagem_atual = to_unsigned(module - 1, BIT_WIDTH) then
          contagem_atual <= (others => '0');
        else
          contagem_atual <= contagem_atual + 1;
        end if;
      end if;
    end if; 
  end process p_contador;
  
  q <= to_bitvector(std_logic_vector(contagem_atual));

  fim <= '1' when contagem_atual = to_unsigned(module - 1, BIT_WIDTH) else
    '0';

end architecture arch_contador;
