/*---------------------------------------------
Project:    Hack Computer
Module:     ALU
Purpose:    Demux the instruction into command bits
Author:     Andre Mitterbacher
Version:    v0, 13.05.2019            
---------------------------------------------*/


module instr_demux(
    input   logic   [15:0]              instr,
    output  logic                       instr_type,
    output  logic   [15:0]              instr_v,
    output  logic                       cmd_a,
    output  logic                       cmd_c1,
    output  logic                       cmd_c2,
    output  logic                       cmd_c3,
    output  logic                       cmd_c4,
    output  logic                       cmd_c5,
    output  logic                       cmd_c6,
    output  logic                       cmd_d1,
    output  logic                       cmd_d2,
    output  logic                       cmd_d3,
    output  logic                       cmd_j1,
    output  logic                       cmd_j2,
    output  logic                       cmd_j3
);

    
    /*
    Two types of commands are supported by the HACK assembler language:
    _A-instruction:    0vvv_vvvv_vvvv_vvvv                  --> load v[14:0] into register A
    _C-instruction     111a_c1c2c3c4_c5c6d1d2_d3j1j2j3      --> command as specified by the a,c,d and j bits
    */
    assign instr_type = instr[15];
    // --- A-instruction
    assign instr_v = {1'b0,instr[14:0]};
    // --- C-instruction
    // instr[14:23] not used
    assign cmd_a = instr_type ? instr[12] : 1'b0;
    assign cmd_c1= instr_type ? instr[11] : 1'b0;
    assign cmd_c2= instr_type ? instr[10] : 1'b0;
    assign cmd_c3= instr_type ? instr[ 9] : 1'b0;
    assign cmd_c4= instr_type ? instr[ 8] : 1'b0;
    assign cmd_c5= instr_type ? instr[ 7] : 1'b0;
    assign cmd_c6= instr_type ? instr[ 6] : 1'b0;
    assign cmd_d1= instr_type ? instr[ 5] : 1'b0;
    assign cmd_d2= instr_type ? instr[ 4] : 1'b0;
    assign cmd_d3= instr_type ? instr[ 3] : 1'b0;
    assign cmd_j1= instr_type ? instr[ 2] : 1'b0;
    assign cmd_j2= instr_type ? instr[ 1] : 1'b0;
    assign cmd_j3= instr_type ? instr[ 0] : 1'b0;
    




endmodule