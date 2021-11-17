onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_instr_demux/instr
add wave -noupdate /tb_instr_demux/instr_v
add wave -noupdate /tb_instr_demux/instr_type
add wave -noupdate /tb_instr_demux/cmd_a
add wave -noupdate /tb_instr_demux/cmd_c
add wave -noupdate /tb_instr_demux/cmd_d
add wave -noupdate /tb_instr_demux/cmd_j
add wave -noupdate /tb_instr_demux/cmd_a
add wave -noupdate /tb_instr_demux/cmd_c1
add wave -noupdate /tb_instr_demux/cmd_c2
add wave -noupdate /tb_instr_demux/cmd_c3
add wave -noupdate /tb_instr_demux/cmd_c4
add wave -noupdate /tb_instr_demux/cmd_c5
add wave -noupdate /tb_instr_demux/cmd_c6
add wave -noupdate /tb_instr_demux/cmd_d1
add wave -noupdate /tb_instr_demux/cmd_d2
add wave -noupdate /tb_instr_demux/cmd_d3
add wave -noupdate /tb_instr_demux/cmd_j1
add wave -noupdate /tb_instr_demux/cmd_j2
add wave -noupdate /tb_instr_demux/cmd_j3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {469097 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 230
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {525 ns}
