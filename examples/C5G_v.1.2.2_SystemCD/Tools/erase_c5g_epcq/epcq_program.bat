@ REM ######################################
@ REM # Variable to ignore <CR> in DOS
@ REM # line endings
@ set SHELLOPTS=igncr

@ REM ######################################
@ REM # Variable to ignore mixed paths
@ REM # i.e. G:/$SOPC_KIT_NIOS2/bin
@ set CYGWIN=nodosfilewarning


%QUARTUS_ROOTDIR%\\bin\\quartus_pgm.exe -m jtag -c 1 -o "p;sfl_enhanced_01_02b020dd.sof@1"
%QUARTUS_ROOTDIR%\\bin\\quartus_pgm.exe -m jtag -c 1 -o "r;output_file.jic@1"
pause