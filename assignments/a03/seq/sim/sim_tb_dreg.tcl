# project name:       dreg
# auth:               Jakob Tschavoll
# date:               03.11.21
# brief:              script for D-FF implementation
# version:            V1.0

# just write this all the time
vlib work
vmap work work  

# compile design files
vlog ../src/dreg.sv

# compile testbench
vlog tb_dreg.sv

# init simulation (module name)
vsim tb_dreg

# log all data
log -r *
do wave.do

# run simulation
run -all

# open wave window
view wave