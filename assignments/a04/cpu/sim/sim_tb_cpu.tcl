# project name:       cpu
# auth:               Jakob Tschavoll
# date:               03.11.21
# brief:              script for instruction cpu implementation
# version:            V1.0

# just write this all the time
vlib work
vmap work work  

# compile design files
vlog ../src/cpu.sv
vlog ../src/alu.sv
vlog ../src/dreg.sv
vlog ../src/instr_demux.sv
vlog ../src/jmp_ctrl.sv
vlog ../src/pcount.sv

# compile testbench
vlog tb_cpu.sv

# init simulation (module name)
vsim tb_cpu

# log all data
log -r *
do wave_cpu.do

# run simulation
run -all

# open wave window
view wave