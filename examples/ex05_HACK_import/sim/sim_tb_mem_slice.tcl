vlib work
vmap work work


vlog ../src/mem_slice.sv

vlog tb_mem_slice.sv

vsim tb_mem_slice

log -r *
do wave_tb_mem_slice.tcl
run -all

view wave