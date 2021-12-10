onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_data_mem/rst_n
add wave -noupdate /tb_data_mem/clk50m
add wave -noupdate /tb_data_mem/we
add wave -noupdate -radix hexadecimal /tb_data_mem/data_in
add wave -noupdate -radix hexadecimal /tb_data_mem/addr
add wave -noupdate -radix hexadecimal /tb_data_mem/data_out
add wave -noupdate -radix hexadecimal /tb_data_mem/reg0x7000
add wave -noupdate -radix hexadecimal /tb_data_mem/reg0x7001
add wave -noupdate -radix hexadecimal /tb_data_mem/reg0x7002
add wave -noupdate -radix hexadecimal /tb_data_mem/reg0x7400
add wave -noupdate -radix hexadecimal /tb_data_mem/reg0x7401
add wave -noupdate -radix hexadecimal /tb_data_mem/reg0x7402
add wave -noupdate /tb_data_mem/run_sim
add wave -noupdate -divider DUT
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/addr
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/ADDR_IREG_0
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/ADDR_IREG_1
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/ADDR_IREG_2
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/ADDR_OREG_0
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/ADDR_OREG_1
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/ADDR_OREG_2
add wave -noupdate /tb_data_mem/dut/AW
add wave -noupdate /tb_data_mem/dut/clk50m
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/data_in
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/data_out
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/data_out_ram16k
add wave -noupdate /tb_data_mem/dut/DW
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/RAM_END
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/RAM_START
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/reg0x7000
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/reg0x7001
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/reg0x7002
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/reg0x7400
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/reg0x7401
add wave -noupdate -radix hexadecimal /tb_data_mem/dut/reg0x7402
add wave -noupdate /tb_data_mem/dut/rst_n
add wave -noupdate /tb_data_mem/dut/we
add wave -noupdate /tb_data_mem/dut/we_ram16k
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 273
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
WaveRestoreZoom {0 ps} {7644 ns}
