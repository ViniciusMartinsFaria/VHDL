library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity codificador is
    port(
        clock                   : in  std_logic;
        reset                   : in  std_logic;
        entrada                 : in  std_logic;
        distribuicao_cumulativa : out std_logic_vector(7 downto 0) := (others => '0');
        probabilidade           : out std_logic_vector(7 downto 0) := (others => '1'));
end codificador;

architecture behavior of codificador is

    signal base         : std_logic_vector(7 downto 0);
    signal lenght       : std_logic_vector(7 downto 0);

    signal eq_base      : std_logic_vector(15 downto 0);
    signal eq_lenght    : std_logic_vector(15 downto 0);

begin

    base    <=  "00000000" when entrada = '0' else
                "01001100";
    lenght  <=  "01001100" when entrada = '0' else
                "10110011";

    eq_base     <=  distribuicao_cumulativa + base * probabilidade;
    eq_lenght   <=  lenght * probabilidade;

    process(clock, reset)
	begin

		if (reset = '1') then

            distribuicao_cumulativa <= (others => '0');
            probabilidade           <= (others => '1');

        else if(rising_edge(clock)) then

            distribuicao_cumulativa <= eq_base  (15 downto 8);
            probabilidade           <= eq_lenght(15 downto 8);

        end if;
    end if;

    end process;

end behavior;
