library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.numeric_std.all;

entity somador_n is
  generic (dataSize : natural := 8);
  port (
    a   : in  bit_vector(dataSize - 1 downto 0); -- entrada de dados A
    b   : in  bit_vector(dataSize - 1 downto 0); -- entrada de dados B
    cin : in  bit;                               -- entrada de vem-um (carry in)
    sum : out bit_vector(dataSize - 1 downto 0)  -- soma A + B + Cin
  );
end entity;

architecture arch_somador of somador_n is
begin

  sum <= bit_vector(unsigned(a) + unsigned(b) + 1) when cin = '1' else
         bit_vector(unsigned(a) + unsigned(b));

end architecture;
