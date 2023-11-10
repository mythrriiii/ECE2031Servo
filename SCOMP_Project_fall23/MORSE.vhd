-- HSPG.vhd (hobby servo pulse generator)
-- This starting point generates a pulse between 100 us and something much longer than 2.5 ms.
-- This is currently HSPG version 4.

library IEEE;
library lpm;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use lpm.lpm_components.all;

entity MORSE is
    port(
        CS          : in  std_logic;
        IO_WRITE    : in  std_logic;
        IO_DATA     : in  std_logic_vector(15 downto 0);
        CLOCK       : in  std_logic;
        RESETN      : in  std_logic;
        PULSE       : out std_logic
    );
end MORSE;

architecture a of MORSE is

    signal command : std_logic_vector(15 downto 0);  -- command sent from SCOMP
    signal count   : std_logic_vector(15 downto 0);  -- internal counter
	 signal incCount   : std_logic_vector(15 downto 0);  -- internal counter to change the spin
	 signal to0   : std_logic_vector(1 downto 0);  -- boolean for which way to spin
	 

begin

    -- PUT MORSE VHDL CODE HERE
	 
end a;