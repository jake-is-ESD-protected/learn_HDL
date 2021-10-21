onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_adder_unsigned/WTB
add wave -noupdate /tb_adder_unsigned/IMAX
add wave -noupdate -format Analog-Step -height 74 -max 1023.0000000000001 -radix unsigned /tb_adder_unsigned/x1
add wave -noupdate -format Analog-Step -height 74 -max 1023.0000000000001 -radix unsigned /tb_adder_unsigned/x2
add wave -noupdate -format Analog-Step -height 74 -max 1023.0000000000001 -radix unsigned /tb_adder_unsigned/sum
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {104755199685 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 211
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {109992960 ns}
