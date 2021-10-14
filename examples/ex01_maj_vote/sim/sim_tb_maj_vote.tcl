# project name:       tb_maj_vote
# auth:               Jakob Tschavoll
# date:               09.10.21
# brief:              script for maj_vote implementation
# version:            V1.1

# always write these
vlib work
vmap work work  

# compile design files
vlog ../src/maj_vote.sv

# compile testbench
vlog tb_maj_vote.sv

# init simulation (module name)
vsim tb_maj_vote

# log all data
log -r *
do wave_tb_maj_vote.tcl

# run simulation
run -all

# open wave window
view wave