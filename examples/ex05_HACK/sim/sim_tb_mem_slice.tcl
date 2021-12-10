# project name:       mem_slice
# auth:               Jakob Tschavoll
# date:               3.12.21
# brief:              script for MMIO implementation
# version:            V1.0

# just write this all the time
vlib work
vmap work work  

# compile design files
vlog ../src/mem_slice.sv

# compile testbench
vlog tb_mem_slice.sv

# init simulation (module name)
vsim tb_mem_slice

# log all data
log -r *
# do wave.do

# run simulation
run -all

# open wave window
view wave