# project name:       arithm
# auth:               Jakob Tschavoll
# date:               21.10.21
# brief:              script for adder_unsigned implementation
# version:            V1.0

# just write this all the time
vlib work
vmap work work  

# compile design files
vlog ../src/adder_unsigned.sv

# compile testbench
vlog tb_adder_unsigned.sv

# init simulation (module name)
vsim tb_adder_unsigned

# log all data
log -r *
do wave_tb_adder_unsigned.tcl

# run simulation
run -all

# open wave window
view wave