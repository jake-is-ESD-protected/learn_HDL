# project name:       arithm
# auth:               Jakob Tschavoll
# date:               21.10.21
# brief:              script for counter implementation
# version:            V1.0

# just write this all the time
vlib work
vmap work work  

# compile design files
vlog ../src/counter.sv

# compile testbench
vlog tb_counter.sv

# init simulation (module name)
vsim tb_counter

# log all data
log -r *
# do wave_tb_counter.tcl

# run simulation
run -all

# open wave window
view wave