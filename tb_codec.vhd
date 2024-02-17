library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;


entity tb_codec is
end tb_codec;

architecture behavior of tb_codec is
component codificador is
port(
    clock           : in  std_logic;
    reset           : in  std_logic;
    entrada         : in  std_logic;
    dist_cumula     : out std_logic_vector(7 downto 0);
    prob            : out std_logic_vector(7 downto 0));
end component;

signal  clock_sg        : std_logic := '0';
signal  reset_sg        : std_logic := '0';
signal  entrada_sg      : std_logic := '0';
signal  dist_cumula_sg  : std_logic_vector(7 downto 0) := (others => '0');
signal  prob_sg         : std_logic_vector(7 downto 0) := ("00000001");

begin
inst_codec: codificador
port map (
        clock       => clock_sg,
        reset       => reset_sg,
        entrada     => entrada_sg,
        dist_cumula => dist_cumula_sg,
        prob        => prob_sg
    );
           
clock_sg <= not clock_sg after 10 ns;

process
begin
	wait for 5 ns;
                entrada_sg <= '1';
	wait for  15 ns;
		entrada_sg <= '0';
	wait for 25 ns;
                entrada_sg <= '1';
	wait for 35 ns;
                entrada_sg <= '0';
	wait for 45 ns;
                entrada_sg <= '1';
	wait;
end process;

end behavior;