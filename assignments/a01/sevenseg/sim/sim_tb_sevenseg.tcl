# project name:       tb_sevenseg
# auth:               Jakob Tschavoll
# date:               14.10.21
# brief:              script for sevenseg implementation
# version:            V1.0

# just write this all the time
vlib work
vmap work work  

# compile design files
vlog ../src/sevenseg.sv

# compile testbench
vlog tb_sevenseg.sv

# init simulation (module name)
vsim tb_sevenseg

# log all data
log -r *
do wave_tb_sevenseg.tcl

# run simulation
run -all

# open wave window
view wave