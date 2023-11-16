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
	 signal speed   : std_logic_vector(15 downto 0);  -- number associated with the speed
	 

-- ... (unchanged declarations)

begin
    -- Latch data on rising edge of CS
    process (RESETN, CS)
    begin
        if RESETN = '0' then
            speed   <= x"1000";
            letter  <= x"0004";
        elsif IO_WRITE = '1' and rising_edge(CS) then
				
				if (IO_DATA >= x"0100") then
					speed <= x"0A00";
					
					if IO_DATA >= x"0101" and IO_DATA <= x"011B" then
						letter <= (IO_DATA - x"0100");
					else 
						letter <= x"0000";
					end if;
					
				else 
		  
					if IO_DATA >= x"0001" and IO_DATA <= x"001B" then
						letter <= IO_DATA;
						speed   <= x"1000";
					else 
						letter <= x"0000";
						speed   <= x"1000";
					end if;
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
            -- letter assignment removed from here
        elsif rising_edge(CLOCK) then
            count <= count + 1;
            incCount <= incCount + 1;
				
				
				if (letter = x"0000") then   -- increment by 0, pauses the spinning
				
					if incCount = speed then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
						incCount <= x"0000";
					
					end if;
					
				
			
				elsif (letter = x"0001") then  -- increment by 1 
				
					if incCount = speed then  -- 4096 ms has elapsed
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
				
				
				
				elsif (letter = x"0002") then  -- increment by 2 
				
					if incCount = speed then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 2;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 2;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 2;
						
						elsif (command <= x"0004") then	
							command <= command + 2;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;
			
			
				elsif (letter = x"0003") then  -- increment by 3 
				
					if incCount = speed then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 3;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 3;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 3;
						
						elsif (command <= x"0004") then	
							command <= command + 3;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;
					
				
				
				elsif (letter = x"0004") then  -- increment by 4 
				
					if incCount = speed then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 4;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 4;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 4;
						
						elsif (command <= x"0004") then	
							command <= command + 4;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;
				
			
		
				elsif (letter = x"0005") then  -- increment by 5 
				
					if incCount = speed then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 5;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 5;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 5;
						
						elsif (command <= x"0004") then	
							command <= command + 5;
							to0 <= "00";
						
						end if;	

					end if;
					
						
						
				elsif (letter = x"0006") then  -- increment by 6 
				
					if incCount = speed then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 6;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 6;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 6;
						
						elsif (command <= x"0004") then	
							command <= command + 6;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;
					
				
			
				elsif (letter = x"0007") then  -- increment by 7 
				
					if incCount = speed then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 7;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 7;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 7;
						
						elsif (command <= x"0004") then	
							command <= command + 7;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;
		
		
		
				elsif (letter = x"0008") then  -- increment by 8 
				
					if incCount = speed then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 8;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 8;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 8;
						
						elsif (command <= x"0004") then	
							command <= command + 8;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;
					
					
					
					
				elsif (letter = x"0009") then  -- increment by 9 
				
					if incCount = speed then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 9;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 9;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 9;
						
						elsif (command <= x"0004") then	
							command <= command + 9;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;	
					
					
					
					
					
				elsif (letter = x"000A") then  -- increment by 10 
				
					if incCount = speed then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 10;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 10;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 10;
						
						elsif (command <= x"0004") then	
							command <= command + 10;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;
					
					
				elsif (letter = x"000B") then  -- increment by 11 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 11;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 11;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 11;
						
						elsif (command <= x"0004") then	
							command <= command + 11;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;	
				
			
			
				elsif (letter = x"000C") then  -- increment by 12 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 12;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 12;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 12;
						
						elsif (command <= x"0004") then	
							command <= command + 12;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;
		
		
		
		
				elsif (letter = x"000D") then  -- increment by 13 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 13;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 13;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 13;
						
						elsif (command <= x"0004") then	
							command <= command + 13;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;
					
					
					
				elsif (letter = x"000E") then  -- increment by 14 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 14;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 14;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 14;
						
						elsif (command <= x"0004") then	
							command <= command + 14;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;	
					
					
	
				elsif (letter = x"000F") then  -- increment by 15 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 15;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 15;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 15;
						
						elsif (command <= x"0004") then	
							command <= command + 15;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;

				
				elsif (letter = x"0010") then  -- increment by 16 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 16;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 16;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 16;
						
						elsif (command <= x"0004") then	
							command <= command + 16;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;
	
				
					
				elsif (letter = x"0011") then  -- increment by 17 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 17;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 17;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 17;
						
						elsif (command <= x"0004") then	
							command <= command + 17;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;	
		
		
		
				elsif (letter = x"0012") then  -- increment by 18 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 18;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 18;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 18;
						
						elsif (command <= x"0004") then	
							command <= command + 18;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;
					
					
				
				elsif (letter = x"0013") then  -- increment by 19 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 19;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 19;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 19;
						
						elsif (command <= x"0004") then	
							command <= command + 19;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;
		
					
				
			
				elsif (letter = x"0014") then  -- increment by 20 
				
					if incCount = x"1000" then  -- 4096 ms has elapsed
						-- Reset the inCounter and change the command variable
							incCount <= x"0000";

						if ((command < x"0018") and (to0 = "00")) then 
							command <= command + 20;
							-- +1 +1 +1 until 25 then goes 5. 
						
						elsif (command >= x"0018") then 
							command <= command - 20;
							to0 <= "01";
						
						elsif ((command > x"0004") and (to0 = "01")) then
							command <= command - 20;
						
						elsif (command <= x"0004") then	
							command <= command + 20;
							to0 <= "00";
						
						end if;	

					 
					 
					end if;
		
				end if;	
				
				
				
				
				
				
				--Safety check
				if (command > x"0018") then
					command <= x"0018";
				elsif (command < x"0004") then
					command <= x"0004";
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