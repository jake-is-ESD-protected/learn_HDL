vlib work
vmap work work

vlog ../src/toplevel_c5g_hex4_uart.sv

vlog ../sim/*.sv

# Add the -L altera_mf_ver to include the IP library
vsim -L altera_mf_ver    tb_toplevel_c5g_hex4_uart

log -r *
do wave_tb_toplevel.do
run -all

view wave