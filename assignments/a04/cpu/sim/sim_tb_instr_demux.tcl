# project name:       instr_demux
# auth:               Jakob Tschavoll
# date:               03.11.21
# brief:              script for instruction demuxer implementation
# version:            V1.0

# just write this all the time
vlib work
vmap work work  

# compile design files
vlog ../src/instr_demux.sv

# compile testbench
vlog tb_instr_demux.sv

# init simulation (module name)
vsim tb_instr_demux

# log all data
log -r *
do wave.do

# run simulation
run -all

# open wave window
view wave