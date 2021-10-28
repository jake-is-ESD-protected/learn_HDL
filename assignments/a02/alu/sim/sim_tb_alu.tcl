# project name:       alu
# auth:               Jakob Tschavoll
# date:               22.10.21
# brief:              script for alu implementation
# version:            V1.0

# just write this all the time
vlib work
vmap work work  

# compile design files
vlog ../src/alu.sv

# compile testbench
vlog tb_alu.sv

# init simulation (module name)
vsim tb_alu

# log all data
log -r *
do wave.do

# run simulation
run -all

# open wave window
view wave