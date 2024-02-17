library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity codificador is
    port(
        clock           : in  std_logic;
        reset           : in  std_logic;
        entrada         : in  std_logic;
        dist_cumula     : out std_logic_vector(7 downto 0);
        prob            : out std_logic_vector(7 downto 0));
end codificador;

architecture behavior of codificador is

    signal base_cumula  : std_logic_vector(7 downto 0);
    signal lenght_prob  : std_logic_vector(7 downto 0);
    signal eq_base      : std_logic_vector(15 downto 0);
    signal eq_lenght    : std_logic_vector(15 downto 0);
    signal ff_base      : std_logic_vector(7 downto 0);
    signal ff_lenght    : std_logic_vector(7 downto 0);

begin

    base_cumula <=  "00000011" when entrada = '0' else
                    "00000100";
    lenght_prob <=  "00000011" when entrada = '0' else
                    "00000100";

    eq_base     <=  ff_base + base_cumula * ff_lenght;
    eq_lenght   <=  lenght_prob * ff_lenght;

    dist_cumula <= ff_base;
    prob        <= ff_lenght;

    process(clock, reset)
	begin

		if (reset = '1') then

            ff_base     <= (others => '0');
            ff_lenght   <= ("00000001");

        else if(rising_edge(clock)) then

            ff_base     <= eq_base  (7 downto 0);
            ff_lenght   <= eq_lenght(7 downto 0);

        end if;
    end if;

    end process;

end behavior;