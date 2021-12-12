(LOOP)
@29696  // input register
D=M     // Load value of reg at 29696
@GREEN  // 
D;JGT

@256    // go to 256
D=A     // store adress
@28672  // go to 28672
M=D     // save stored value to register
@LOOP   // jump back to top
0;JMP

(GREEN)
@1
D=A
@28672
M=D
@LOOP
0;JMP