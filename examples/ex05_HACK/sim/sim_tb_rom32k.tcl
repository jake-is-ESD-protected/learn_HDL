# project name:       rom32k
# auth:               Jakob Tschavoll
# date:               19.11.21
# brief:              script for rom implementation
# version:            V1.0

# just write this all the time
vlib work
vmap work work  

# compile design files
vlog ../ip/rom32k.v

# compile testbench
vlog tb_rom32k.sv

# init simulation (module name)
vsim -L altera_mf_ver tb_rom32k

# log all data
log -r *
# do wave.do

# run simulation
run -all

# open wave window
view wave