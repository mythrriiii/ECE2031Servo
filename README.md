# ECE2031Servo

## Index
- [HSPG_TestingCode_v1](#HSPG_TestingCode_v1)


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

## HSPG_TestingCode_v2 BASE FUNCTIONALITY

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
