onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_mem_slice/rst_n
add wave -noupdate -radix hexadecimal /tb_mem_slice/clk50m
add wave -noupdate -radix hexadecimal /tb_mem_slice/addr
add wave -noupdate -radix hexadecimal /tb_mem_slice/data_in
add wave -noupdate -radix hexadecimal /tb_mem_slice/we
add wave -noupdate -radix hexadecimal /tb_mem_slice/data_out
add wave -noupdate -radix hexadecimal /tb_mem_slice/run_sim
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 180
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {3250 ns}
