library ieee;
  use ieee.numeric_bit.all;

entity registrador_n is
  generic (dataSize : natural := 8);
  port (
    clk    : in  bit;                               -- entrada de clock
    reset  : in  bit;                               -- clear assincrono
    enable : in  bit;                               -- write enable (carga paralela)
    d      : in  bit_vector(dataSize - 1 downto 0); -- entrada
    q      : out bit_vector(dataSize - 1 downto 0)  -- saida
  );
end entity;

architecture arch_reg of registrador_n is
  signal estado_interno : bit_vector(dataSize - 1 downto 0);
begin
  process (clk, reset)
  begin
    if reset = '1' then
      estado_interno <= (others => '0');

    elsif clk'event and clk = '1' then
      if enable = '1' then
        estado_interno <= d;
      end if;
    end if;
  end process;

  q <= estado_interno;

end architecture;
