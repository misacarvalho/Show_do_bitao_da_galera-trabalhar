-------------------------------------------------------------------------
-- Arquivo   : ram_quiz.vhd
-- Projeto   : Show do Bitão (PCS3115 - Sistemas Digitais I)
-------------------------------------------------------------------------
-- Descricao : Memória de Respostas e Flags de Uso de Perguntas
-------------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor                    Descricao
--     2026-05-23  1.0     Leonardo N. Varella      versão inicial
--     2026-05-    2.0     Antonio V. da S. Neto    Adaptação para bit
--                                                  e bit_vector
-------------------------------------------------------------------------

library ieee;
use ieee.numeric_bit.all;

entity tb_ram_quiz is
end entity tb_ram_quiz;

architecture sim of tb_ram_quiz is

    component ram_quiz is
        port (
            clk    : in  bit;
            write_used : in  bit;
            reset_used : in  bit;
            address   : in  bit_vector(5 downto 0);
            data_resp   : out bit_vector(3 downto 0);
            data_used: out bit
        );
    end component;

    signal clk    : bit := '0';
    signal w_used : bit := '0';
    signal r_used : bit := '0';
    signal addr   : bit_vector(5 downto 0) := (others => '0');
    signal dout   : bit_vector(3 downto 0);
    signal used   : bit;

    constant CLK_PERIOD : time := 10 ns;
    
    signal sim_done: boolean := false;

begin

    uut : ram_quiz
        port map (
            clk    => clk,
            write_used => w_used,
            reset_used => r_used,
            address   => addr,
            data_resp   => dout,
            data_used => used
        );

    clk_proc : process
    begin
        while not sim_done loop
            clk <= '0'; wait for CLK_PERIOD / 2;
            clk <= '1'; wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process clk_proc;

    stimulus : process
    begin
        -- -------------------------------------------------------
        -- Step 1: Check hardcoded MSB values at selected addresses
        -- -------------------------------------------------------
        addr <= "000000"; wait for CLK_PERIOD;  -- addr 0: expected "1000"
        assert dout = "1000"
            report "FAIL: addr 0 MSBs expected 1000" severity error;
        assert used = '0'
            report "FAIL: addr 0 LSB should start at 0" severity error;

        addr <= "000001"; wait for CLK_PERIOD;  -- addr 1: expected "0100"
        assert dout = "0100"
            report "FAIL: addr 1 MSBs expected 0100" severity error;

        addr <= "111111"; wait for CLK_PERIOD;  -- addr 63: expected "1000"
        assert dout = "1000"
            report "FAIL: addr 63 MSBs expected 1000" severity error;

        addr <= "110000"; wait for CLK_PERIOD;  -- addr 48: expected "0001"
        assert dout = "0001"
            report "FAIL: addr 48 MSBs expected 0001" severity error;

        -- -------------------------------------------------------
        -- Step 2: Set LSB at address 0 via w_used
        -- -------------------------------------------------------
        addr <= "000000"; w_used <= '1';
        wait for CLK_PERIOD;
        w_used <= '0';
        wait for CLK_PERIOD;
        assert used = '1'
            report "FAIL: addr 0 LSB should be 1 after w_used" severity error;

        -- Set LSB at address 10
        addr <= "001010"; w_used <= '1';
        wait for CLK_PERIOD;
        w_used <= '0';
        wait for CLK_PERIOD;
        assert used = '1'
            report "FAIL: addr 10 LSB should be 1 after w_used" severity error;

        -- Set LSB at address 63
        addr <= "111111"; w_used <= '1';
        wait for CLK_PERIOD;
        w_used <= '0';
        wait for CLK_PERIOD;
        assert used = '1'
            report "FAIL: addr 63 LSB should be 1 after w_used" severity error;

        -- -------------------------------------------------------
        -- Step 3: r_used asynchronously clears all LSBs
        -- -------------------------------------------------------
        r_used <= '1';
        wait for 5 ns;  -- Mid-cycle, no clock edge needed

        addr <= "000000";
        assert used = '0'
            report "FAIL: addr 0 LSB should be 0 during r_used" severity error;
        addr <= "001010";
        assert used = '0'
            report "FAIL: addr 10 LSB should be 0 during r_used" severity error;
        addr <= "111111";
        assert used = '0'
            report "FAIL: addr 63 LSB should be 0 during r_used" severity error;

        r_used <= '0';
        wait for CLK_PERIOD;

        -- -------------------------------------------------------
        -- Step 4: MSBs must be unaffected by r_used
        -- -------------------------------------------------------
        addr <= "000000"; wait for CLK_PERIOD;
        assert dout = "1000"
            report "FAIL: addr 0 MSBs should be preserved after r_used" severity error;

        addr <= "111111"; wait for CLK_PERIOD;
        assert dout = "1000"
            report "FAIL: addr 63 MSBs should be preserved after r_used" severity error;

        report "All tests completed." severity note;
        sim_done <= true;
        wait;
    end process stimulus;

end architecture sim;