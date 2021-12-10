# project name:       mem_slice
# auth:               Jakob Tschavoll
# date:               3.12.21
# brief:              script for MMIO implementation
# version:            V1.0

# just write this all the time
vlib work
vmap work work  

# compile design files
vlog ../src/data_mem.sv
vlog ../ip/ram16k.v
vlog ../src/mem_slice.sv

# compile testbench
vlog tb_data_mem.sv

# init simulation (module name)
vsim -L altera_mf_ver tb_data_mem

# log all data
log -r *
do wave_tb_data_mem.do

# run simulation
run -all

# open wave window
view wave