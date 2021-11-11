# project name:       uart_tx
# auth:               Jakob Tschavoll
# date:               11.11.21
# brief:              script for uart tx implementation
# version:            V1.0

# just write this all the time
vlib work
vmap work work  

# compile design files
vlog ../src/uart_tx.sv

# compile testbench
vlog tb_uart_tx.sv

# init simulation (module name)
vsim tb_uart_tx

# log all data
log -r *
do wave.do

# run simulation
run -all

# open wave window
view wave