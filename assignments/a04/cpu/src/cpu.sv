/*
*****************************************************************************************
project name:       cpu
auth:               Jakob Tschavoll
date:               03.11.21
brief:              system verilog implementation of a CPU
version:            V1.0
*****************************************************************************************
*/

module cpu
#(
    parameter DW  = 16,
    parameter AW  = 14,
    parameter PW  = 14
)
(
    input logic rst_n,              // reset
    input logic clk50m,             // clock 
    input logic [DW-1:0]instr,      // instruction set
    input logic [DW-1:0]inM,        // read from memory

    output logic writeM,            // write to memory flag
    output logic [DW-1:0] outM,     // store in memory
    output logic [AW-1:0] addressM, // address in memory
    output logic [PW-1:0] pc        // program counter
);

// signals @ demuxer:
// I:
// *outer signal*
// O:
logic instr_type;
logic [DW-1:0]instr_v;
logic cmd_a;
logic cmd_c1;
logic cmd_c2;
logic cmd_c3;
logic cmd_c4;
logic cmd_c5;
logic cmd_c6;
logic cmd_d1;
// logic cmd_d2; removed due to renaming to "dload"
// logic cmd_d3; removed due to renaming to "mload"
logic cmd_j1;
logic cmd_j2;
logic cmd_j3;
logic dload;
logic mload;
// instance
instr_demux #(.DW (DW)) instr_demux (
    .cmd_d2 (dload),
    .cmd_d3 (mload),
    .*
);

// signals @ alu:
// I:
logic [DW-1:0]d;
logic [DW-1:0]y;
// O:
logic [DW-1:0]alu_out;
logic alu_zr;
logic alu_ng;
// instance
alu #(.WORDSIZE (DW)) alu (
    .x (d),
    .y (y),
    .zx (cmd_c1),
    .nx (cmd_c2),
    .zy (cmd_c3),
    .ny (cmd_c4),
    .f  (cmd_c5),
    .no (cmd_c6),
    .out (alu_out),
    .zr (alu_zr),
    .ng (alu_ng)
);

// signals @ a:
// I:
logic aload;
logic [15:0]ad;
// O:
logic [DW-1:0]a;
// instance
dreg #(.W (DW)) a_reg (
    .load (aload),
    .d (ad),
    .q (a),
    .*
);

// signals @ pcount:
// I:
logic pc_load;
logic pc_inc;
// O:
// outer signal
// instance
pcount #(.W (PW)) pcount (
    .load (pc_load),
    .inc (pc_inc),
    .cnt_in (a),
    .cnt (pc),
    .*
);

//signals @ d:
// I:
// already declared
// O:
// already declared
// instance
dreg #(.W (DW)) d_reg (
    .load (dload),
    .d (alu_out),
    .q (d),
    .*
);

logic [15:0] q_ram;
ram16k_verilog ram (
    .address (addressM),
    .clock (clk50m),
    .data (outM),
    .wren (writeM),
    .q (q_ram)
);

// misc signals:
logic [DW-1:0]m;
// instance
jmp_ctrl jmp_ctrl (
    .*
);

// rename certain signals:
assign m = inM;
assign addressM = a; // should use the lower 15 bit
assign writeM = mload;
assign outM = alu_out;

always_comb begin

    if(instr_type) begin
        aload = cmd_d1;
        ad = alu_out;
    end
    else begin
        aload = 1'b1;
        ad = instr_v;
    end
    
    if(cmd_a) begin
        y = m;
    end
    else begin
        y = a;
    end
end

endmodule