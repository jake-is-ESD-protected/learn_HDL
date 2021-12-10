onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_mem_slice/rst_n
add wave -noupdate /tb_mem_slice/clk50m
add wave -noupdate /tb_mem_slice/addr
add wave -noupdate /tb_mem_slice/data_in
add wave -noupdate /tb_mem_slice/we
add wave -noupdate /tb_mem_slice/data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {859436 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {3339 ns}
