vlib work
vmap work work

vlog ../ip/rom32k.v

vlog tb_rom32k.sv

# Add the -L altera_mf_ver to include the IP library
vsim -L altera_mf_ver    tb_rom32k 

log -r *

run -all

view wave