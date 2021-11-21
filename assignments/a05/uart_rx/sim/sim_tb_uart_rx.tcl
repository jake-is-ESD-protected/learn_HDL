# project name:       uart_rx
# auth:               Jakob Tschavoll
# date:               20.11.21
# brief:              script for uart receiver implementation
# version:            V1.0

# just write this all the time
vlib work
vmap work work  

# compile design files
vlog ../src/uart_rx.sv
vlog ../src/uart_tx.sv

# compile testbench
vlog tb_uart_rx.sv

# init simulation (module name)
vsim tb_uart_rx

# log all data
log -r *
do wave_rx.do

# run simulation
run -all

# open wave window
view wave