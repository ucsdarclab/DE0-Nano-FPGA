--clock scaler
--Dimitir Shreiber, Spencer Chang, Mark Stambaugh
--2020/02/14
--Generates a reduced clock


library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--prescaler size is: (input clock hz / output clock hz) /2
use IEEE.NUMERIC_STD.all;

entity scale_clock is
	generic(
		frequency_in : integer;
		frequency_out : integer
	);
  port (
    clk_50Mhz : in  std_logic;
    rst       : in  std_logic;
    clk_out   : out std_logic);
end scale_clock;

architecture Behavioral of scale_clock is
	
	signal prescale_limit : unsigned (23 downto 0) := to_unsigned(integer(real(frequency_in) / real(2*frequency_out)), 24);
  signal prescaler : unsigned(23 downto 0);
  signal clk_out_i : std_logic;
begin

  gen_clk : process (clk_50Mhz, rst)
  begin  -- process gen_clk
    if rst = '1' then
      clk_out_i   <= '0';
      prescaler   <= (others => '0');
    elsif rising_edge(clk_50Mhz) then   -- rising clock edge
      if prescaler = prescale_limit then     -- 5000 in hex
        prescaler   <= (others => '0');
        clk_out_i   <= not clk_out_i;
      else
        prescaler <= prescaler + "1";
      end if;
    end if;
  end process gen_clk;

clk_out <= clk_out_i;

end Behavioral;