# project name:       pcount
# auth:               Jakob Tschavoll
# date:               03.11.21
# brief:              script for counter implementation
# version:            V1.0

# just write this all the time
vlib work
vmap work work  

# compile design files
vlog ../src/pcount.sv

# compile testbench
vlog tb_pcount.sv

# init simulation (module name)
vsim tb_pcount

# log all data
log -r *
do wave.do

# run simulation
run -all

# open wave window
view wave