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
	 signal letter   : std_logic_vector(15 downto 0);  -- number associated with the letter
	 signal letterCount   : std_logic_vector(15 downto 0);  -- which dot/dash associated with the letter
	 

-- ... (unchanged declarations)

begin
    -- Latch data on rising edge of CS
    process (RESETN, CS)
    begin
        if RESETN = '0' then
            --command <= x"0004";
            letter  <= x"0004";
        elsif IO_WRITE = '1' and rising_edge(CS) then
            if IO_DATA >= x"0001" and IO_DATA <= x"001A" then
                letter <= IO_DATA;
            else 
                letter <= x"0000";
            end if;
        end if;
    end process;

    -- This is a VERY SIMPLE way to generate a pulse.  This is not particularly
    -- flexible and it has some issues.  It works, but you should probably consider ways
    -- to improve this.
    process (RESETN, CLOCK)
    begin
        if RESETN = '0' then
            count   <= x"0000";
            incCount <= x"0000";
            command <= x"0004";
            to0     <= "00";
				letterCount <= x"0000";
            -- letter assignment removed from here
        elsif rising_edge(CLOCK) then
            count <= count + 1;
            incCount <= incCount + 1;
				
				
				if (letter = x"0000") then   --continuous spinning and letterCounter
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
						incCount <= x"0000";
						letterCount <= x"0000";
					 
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
					
				
			
				elsif (letter = x"0001") then  -- A 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then 
							command <= x"0004";                -- reset
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then    -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0002") then    -- dash
							command <= command + 3;
						
						end if;	
					end if;	
					
					
					
					
					
					
				elsif (letter = x"0002") then  -- B 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0002") then   -- dot
							command <= command + 1;
							
						elsif (letterCount = x"0003") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0004") then   -- dot
							command <= command + 1;
						
						
						end if;	
					end if;
					
					
					
					
					
					
				elsif (letter = x"0003") then  -- C 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0002") then   -- dot
							command <= command + 1;
							
						elsif (letterCount = x"0003") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0004") then   -- dot
							command <= command + 1;
						
						
						end if;	
					end if;	
				
				
				
				
				elsif (letter = x"0004") then  -- D 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0002") then   -- dot
							command <= command + 1;
							
						elsif (letterCount = x"0003") then   -- dot
							command <= command + 1;
						
						
						end if;	
					end if;
					
					
					
					
				
				
				elsif (letter = x"0005") then  -- E 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dot
							command <= command + 1;
			
						
						end if;	
					end if;
					
				
				
				elsif (letter = x"0006") then  -- F 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0002") then   -- dot
							command <= command + 1;
							
						elsif (letterCount = x"0003") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0004") then   -- dot
							command <= command + 1;
						
						
						end if;	
					end if;
				
				
				
				
				elsif (letter = x"0007") then  -- G 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0002") then   -- dash
							command <= command + 3;
							
						elsif (letterCount = x"0003") then   -- dot
							command <= command + 1;
						
						
						end if;	
					end if;
					
					
					
				
				
				elsif (letter = x"0008") then  -- H 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0002") then   -- dot
							command <= command + 1;
							
						elsif (letterCount = x"0003") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0004") then   -- dot
							command <= command + 1;
						
						
						end if;	
					end if;
					
					
				
				
				
				elsif (letter = x"0009") then  -- I 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0002") then   -- dot
							command <= command + 1;
							
						end if;	
					end if;
				
				
				
				elsif (letter = x"000A") then  -- J 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0002") then   -- dash
							command <= command + 3;
							
						elsif (letterCount = x"0003") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0004") then   -- dash
							command <= command + 3;
						
						
						end if;	
					end if;
				
				
				
				
				elsif (letter = x"000B") then  -- K 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0002") then   -- dot
							command <= command + 1;
							
						elsif (letterCount = x"0003") then   -- dash
							command <= command + 3;
						
						end if;	
					end if;
				
				
				
				elsif (letter = x"000C") then  -- L 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0002") then   -- dash
							command <= command + 3;
							
						elsif (letterCount = x"0003") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0004") then   -- dot
							command <= command + 1;
						
						
						end if;	
					end if;
				
				
				
				elsif (letter = x"000D") then  -- M 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0002") then   -- dash
							command <= command + 3;
	
						end if;	
					end if;
		
	
	
				
				elsif (letter = x"000E") then  -- N 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0002") then   -- dot
							command <= command + 1;
						
						end if;	
					end if;
		
				
				
				
				elsif (letter = x"000F") then  -- O 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0002") then   -- dash
							command <= command + 3;
							
						elsif (letterCount = x"0003") then   -- dash
							command <= command + 3;
						
						end if;	
					end if;
					
				
				
				
				
				
				elsif (letter = x"0010") then  -- P 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0002") then   -- dash
							command <= command + 3;
							
						elsif (letterCount = x"0003") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0004") then   -- dot
							command <= command + 1;
						
						
						end if;	
					end if;
					
					
					
				
				elsif (letter = x"0011") then  -- Q 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0002") then   -- dash
							command <= command + 3;
							
						elsif (letterCount = x"0003") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0004") then   -- dash
							command <= command + 3;
						
						
						end if;	
					end if;
					
				
				
				
				elsif (letter = x"0012") then  -- R 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0002") then   -- dash
							command <= command + 3;
							
						elsif (letterCount = x"0003") then   -- dot
							command <= command + 1;
						
						end if;	
					end if;
				
				
				
				elsif (letter = x"0013") then  -- S 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0002") then   -- dot
							command <= command + 1;
							
						elsif (letterCount = x"0003") then   -- dot
							command <= command + 1;
		
						
						end if;	
					end if;
					
					
					
					
					
					
				elsif (letter = x"0014") then  -- T 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dash
							command <= command + 3;
						
				
						
						end if;	
					end if;	
					
					
					
					
					
				elsif (letter = x"0015") then  -- U 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0002") then   -- dot
							command <= command + 1;
							
						elsif (letterCount = x"0003") then   -- dash
							command <= command + 3;
						
						end if;	
					end if;	
					
					
				
				
				elsif (letter = x"0016") then  -- V 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0002") then   -- dot
							command <= command + 1;
							
						elsif (letterCount = x"0003") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0004") then   -- dash
							command <= command + 3;
						
						
						end if;	
					end if;
				
					
					
				
				elsif (letter = x"0017") then  -- W 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0002") then   -- dash
							command <= command + 3;
							
						elsif (letterCount = x"0003") then   -- dash
							command <= command + 3;
	
						
						end if;	
					end if;
				
				
				
				
				elsif (letter = x"0018") then  -- X 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0002") then   -- dot
							command <= command + 1;
							
						elsif (letterCount = x"0003") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0004") then   -- dash
							command <= command + 3;
						
						
						end if;	
					end if;
				
				
				
				elsif (letter = x"0019") then  -- Y 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0002") then   -- dot
							command <= command + 1;
							
						elsif (letterCount = x"0003") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0004") then   -- dash
							command <= command + 3;
						
						
						end if;	
					end if;
				
				
				
				
				
				elsif (letter = x"001A") then  -- Z 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dash
							command <= command + 3;
						
						elsif (letterCount = x"0002") then   -- dash
							command <= command + 3;
							
						elsif (letterCount = x"0003") then   -- dot
							command <= command + 1;
						
						elsif (letterCount = x"0004") then   -- dot
							command <= command + 1;
						
						
						end if;	
					end if;
					
				
				
				
				
				elsif (letter = x"001B") then  -- Swish
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if (letterCount >= x"0000") and (letterCount < x"0004") then
								letterCount <= letterCount + 1;	
					
					 
						end if;
					 
					 
					 
							
						if (letterCount = x"0000") then      -- reset
							command <= x"0004";
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (letterCount = x"0001") then   -- dash
							command <= command + 25;
						
						elsif (letterCount = x"0002") then   -- dash
							command <= command - 25;
							

						end if;	
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
