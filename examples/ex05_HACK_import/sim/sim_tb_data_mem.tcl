vlib work
vmap work work


vlog ../src/mem_slice.sv
vlog ../ip/ram16k.v
vlog ../src/data_mem.sv

vlog tb_data_mem.sv

# Add the -L altera_mf_ver to include the IP library
vsim -L altera_mf_ver    tb_data_mem

log -r *
do wave_tb_data_mem.tcl
run -all

view wave