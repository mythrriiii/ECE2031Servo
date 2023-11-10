-- AudioMonitor.vhd
-- Created 2023
--
-- This SCOMP peripheral directly passes data from an input bus to SCOMP's I/O bus.

library IEEE;
library lpm;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use lpm.lpm_components.all;

entity SafePulse is
	port(
		P_IN        : in  std_logic;
		CLOCK       : in  std_logic;
		P_OUT       : out std_logic
	);
end SafePulse;

architecture a of SafePulse is

	signal count   : std_logic_vector(15 downto 0);
	signal trig    : std_logic;
	signal reset   : std_logic;
	signal force   : std_logic;
	signal limit   : std_logic;
	
begin

	process begin
		wait until rising_edge(CLOCK);
		if trig = '1' then
			-- acknowledge the trigger
			reset <= '1';
			-- beginning of pulse; force output active
			force <= '1';
			limit <= '0';
			-- start ~5ms count
			count <= x"FFFF";
		else
			if count = x"0000" then
				-- timed out; cut off any longer pulse
				reset <= '0';
			else
				count <= count - 1;
				if count = x"E88F" then -- don't have to force anymore
					force <= '0';
				end if;
				if count = x"8ACF" then -- timed out; cut off any longer pulse
					limit <= '1';
				end if;
			end if;
		end if;		
	end process;

	process (P_IN, reset) begin
		if reset='1' then
			trig <= '0';
		elsif rising_edge(P_IN) then
			trig <= '1';
		end if;
	end process;
	
	P_OUT <= (P_IN OR force) AND (NOT limit);
	
end a;