-- HSPG.vhd (hobby servo pulse generator)
-- This starting point generates a pulse between 100 us and something much longer than 2.5 ms.

library IEEE;
library lpm;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use lpm.lpm_components.all;

entity HSPG is
    port(
        CS          : in  std_logic;
        IO_WRITE    : in  std_logic;
        IO_DATA     : in  std_logic_vector(15 downto 0);
        CLOCK       : in  std_logic;
        RESETN      : in  std_logic;
        PULSE       : out std_logic
    );
end HSPG;

architecture a of HSPG is

    signal command : std_logic_vector(15 downto 0);  -- command sent from SCOMP
    signal count   : std_logic_vector(15 downto 0);  -- internal counter
	 signal incCount   : std_logic_vector(15 downto 0);  -- internal counter to change the spin
	 signal to0   : std_logic_vector(1 downto 0);  -- boolean for which way to spin
	 

begin


    -- This is a VERY SIMPLE way to generate a pulse.  This is not particularly
    -- flexible and it has some issues.  It works, but you should probably consider ways
    -- to improve this.
	 
    process (RESETN, CLOCK)
    begin
        if (RESETN = '0') then
            count <= x"0000";
				incCount <= x"0000";
				command <= x"0004";
				to0 <= "00";
	
        elsif rising_edge(CLOCK) then
            count <= count + 1;
				incCount <= incCount + 1;
				
				
				if incCount = x"1000" then  -- 4096 ms has elapsed
					-- Reset the inCounter and change the command variable
					incCount <= x"0000";
					 
					if ((command < x"0018") and (to0 = "00")) then 
						command <= command + 1;
						-- +1 +1 +1 until 25 then goes 5. 
						
					elsif (command >= x"0018") then 
						command <= command - 1;
						to0 <= "01";
						
					elsif ((command > x"0004") and (to0 = "01")) then
						command <= command - 1;
						
					elsif (command <= x"0004") then	
						command <= command + 1;
						to0 <= "00";

					
					end if;
				end if;	
				
				
            if count = x"00C7" then  -- 20 ms has elapsed
                -- Reset the counter and set the output high.
                count <= x"0000";
                PULSE <= '1';
					 
            elsif count = command then
                -- Once the count reaches the command value, set the output low.
                -- This will make larger command values produce longer pulses.
                PULSE <= '0';
            end if;
				
        end if;
    end process;

end a;
