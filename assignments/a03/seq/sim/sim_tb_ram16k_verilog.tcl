# project name:       ram16k_verilog
# auth:               Jakob Tschavoll
# date:               03.11.21
# brief:              script for RAM implementation
# version:            V1.0

# just write this all the time
vlib work
vmap work work  

# compile design files
vlog ../src/ram16k_verilog.sv

# compile testbench
vlog tb_ram16k_verilog.sv

# init simulation (module name)
vsim tb_ram16k_verilog

# log all data
log -r *
do wave_ram.do

# run simulation
run -all

# open wave window
view wave