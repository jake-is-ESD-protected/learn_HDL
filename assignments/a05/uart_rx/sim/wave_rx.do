onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider GLOBAL
add wave -noupdate /tb_uart_rx/clk
add wave -noupdate /tb_uart_rx/rst_n
add wave -noupdate -divider TX
add wave -noupdate /tb_uart_rx/tx_start
add wave -noupdate -radix hexadecimal /tb_uart_rx/tx_data
add wave -noupdate /tb_uart_rx/tx_start
add wave -noupdate /tb_uart_rx/tx
add wave -noupdate /tb_uart_rx/tx_idle
add wave -noupdate -divider RX
add wave -noupdate /tb_uart_rx/rx
add wave -noupdate -radix hexadecimal /tb_uart_rx/rx_data
add wave -noupdate /tb_uart_rx/rx_idle
add wave -noupdate /tb_uart_rx/rx_ready
add wave -noupdate /tb_uart_rx/rx_error
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {154421038 ps} 0}
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
WaveRestoreZoom {0 ps} {368949 ns}
