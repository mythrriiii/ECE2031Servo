# ECE2031Servo

## Index
- [HSPG_Provided](#HSPG_Provided)
- [HSPG_TestingCode.TXT](#HSPG_TestingCode.TXT)
- [HSPG_TestingCode.MIF](HSPG_TestingCode.MIF)
- [HSPG_TestingCode_v1](#HSPG_TestingCode_v1)
- [HSPG_TestingCode_v2 BASE FUNCTIONALITY](#HSPG_TestingCode_v2)
- [HSPG_TestingCode_v3](#HSPG_TestingCode_v3)
- [HSPG_TestingCode_v4](#HSPG_TestingCode_v4)
- [HSPG_TestingCode_v5](#HSPG_TestingCode_v5)
- [HSPG_TestingCode_v6](#HSPG_TestingCode_v6)
- [HSPG_TestingCode_v7](#HSPG_TestingCode_v7)
 



## HSPG_Provided
Contains the code given in the lab manual.

## HSPG_TestingCode.TXT
Contains the Assembly code to test. Gets input of switches and outputs onto the servo and the LEDs.

## HSPG_TestingCode.MIF
MIF File for the basic testing Assembly Code.

## HSPG_TestingCode_v1

**New Features**
Ensures that the servo controls are between 0.5ms and 2.5ms without using safety

- If switch 0, then 0.5ms pulse so ccw left rotation extreme
- If switch 1, then 1.0ms pulse so ccw left rotation moderate
- If switch 2, then 1.5ms pulse so rotate to neutral position
- If switch 3, then 2.0ms pulse so cw right rotation moderate
- If switch 4, then 2.5ms pulse so cw right rotation extreme

**Issues**

- Servo reset was at 0.1ms instead of 0.5
- Pulse widths are off by 0.1ms or 1 clock cycle

## HSPG_TestingCode_v2 
BASE FUNCTIONALITY

**New Features**
This contains the completed base functionality

- Servo resets at the neutral position of 15ms pulse width
- Pulse widths are exactly 0.5ms, 1.0ms, 1.5ms, 2.0ms, 2.5ms

**Issues**

- Only basic, need to add the additional features


 ## HSPG_TestingCode_v3 

**New Features**
This contains the completed base functionality and an extra feature to control how much it spins exactly in increments of 9.

- Servo resets at the neutral position of 15ms pulse width
- Pulse widths are exactly 0.5ms, 0.6ms, ...... 2.5ms
- The servo increments by 9 degrees.
- The (switch input x 9) refers to the final angle the servo turns by from the CCW or left extreme. For e.g.: 1 x 9 = 9 degrees, 5 * 9 = 45 degrees.

**Issues**

- Right now can increment by 9, change the clock maybe? to increment by 1 degree.


## HSPG_TestingCode_v4 

**New Features**
This contains the completed base functionality and an extra feature that continuously spins from 0 to 180 position and back

- Servo resets at the 0 position with 0.5ms pulse width
- The servo increments by 9 degrees up to spin CCW to the left extreme and then decrements by 9 degrees down to 0 to spin CW to the right extreme.
- When the reset button is hit, the servo returns to position 0 and starts again.

**Issues**

- Let the user pick from where to where they want continuous turning
- Combine it with the other features.
- Why is changing the clock throwing errors?


## HSPG_TestingCode_v5 

**New Features**
This contains the completed base functionality and an extra that can output Morse Code.

- Servo resets at the 0 position with 0.5ms pulse width, every time the key is 0
- The servo increments by 9 degrees up to spin CCW to the left for dot and by 9*3 = 27 degrees for dash and stay at the last position when then letter is over
- Go back to 0 for and then input again. 
- When the reset button is hit, the servo returns to position 0 and starts again.

**Issues**

- Combine it with the other features.
- Add more features apart from letters
- Slight error, change if 4 pattern then continuously spins


## HSPG_TestingCode_v6 

**New Features**
This contains the completed base functionality and an extra that can output Morse Code accurately.

- Same as v5 but with letterCount going upto 5 instead of 4

**Issues**

- Combine it with the other features.
- Add more features apart from letters


## HSPG_TestingCode_v7 

**New Features**
This contains the completed base functionality and can spin with increments provided by the user.

- Servo resets at the 0 position with 0.5ms pulse width, every time the key is 0
- The servo increments by 9*input to spin back and forth. There are 20 options.

**Issues**

- Combine it with the other features.
- Add more features apart from letters
- 

## HSPG_TestingCode_v9 FINAL 

**New Features**
This contains the completed project with all 4 sub-features integrated into one. 

-  SOS machine on Bit 9
-  Configurable Range machine on Bit 8
-  Morse Code machine on Bit 7
-  Continuous Spinning 000 for Control Bits
    

