onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_ram16k_verilog/clock
add wave -noupdate /tb_ram16k_verilog/q
add wave -noupdate /tb_ram16k_verilog/address
add wave -noupdate /tb_ram16k_verilog/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {521315265 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 192
configure wave -valuecolwidth 152
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
WaveRestoreZoom {0 ps} {2064268500 ps}
