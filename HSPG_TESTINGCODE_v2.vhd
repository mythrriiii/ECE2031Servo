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

begin

    -- Latch data on rising edge of CS
    process (RESETN, CS) begin
        if RESETN = '0' then
            command <= x"000E";
        elsif IO_WRITE = '1' and rising_edge(CS) then
				-- If switch 0, then 5ms pulse so ccw left rotation extreme
				if (IO_DATA = x"0001") then
					command <= x"0004";  
				
				-- If switch 1, then 10ms pulse so ccw left rotation moderate	
				elsif	(IO_DATA = x"0002") then
					command <= x"0009";
				
				-- If switch 2, then 15ms pulse so rotate to neutral position		
				elsif	(IO_DATA = x"0004") then
					command <= x"000E";
				
				-- If switch 3, then 20ms pulse so cw right rotation moderate	
				elsif	(IO_DATA = x"0008") then
					command <= x"0013";
				
			   -- If switch 4, then 25ms pulse so cw right rotation extreme	
				elsif	(IO_DATA = x"0010") then
					command <= x"0018";
					
            end if;
        end if;
    end process;

    -- This is a VERY SIMPLE way to generate a pulse.  This is not particularly
    -- flexible and it has some issues.  It works, but you should probably consider ways
    -- to improve this.
	 
    process (RESETN, CLOCK)
    begin
        if (RESETN = '0') then
            count <= x"0000";
	
        elsif rising_edge(CLOCK) then
            count <= count + 1;
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