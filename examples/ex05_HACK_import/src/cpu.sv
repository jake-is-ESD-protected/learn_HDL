/*---------------------------------------------
Project:    Hack Computer
Module:     ALU
Purpose:    CPU module
Author:     Andre Mitterbacher
Version:    v0, 13.05.2019            
---------------------------------------------*/


module cpu
#(
    parameter DW = 16,  //data width
    parameter AW = 15,  //address width data RAM
    parameter PW = 15   //address width instruction ROM
)
(
    input   logic               rst_n,              //active low reset
    input   logic               clk50m,             //50MHz clock
    input   logic   [DW-1:0]    inM,                //data from RAM
    input   logic   [DW-1:0]    instr,              //instruction from ROM
    output  logic               writeM,             //write enable for RAM
    output  logic   [DW-1:0]    outM,               //data to RAM
    output  logic   [AW-1:0]    addressM,           //address for RAM
    output  logic   [PW-1:0]    pc                  //address for ROM instruction
);

// --- internal wires ---
logic   [DW-1:0]                m;                  //data from RAM
assign m = inM;
logic                           instr_type;         //0...a-instr, 1...c-instr
logic   [DW-1:0]                instr_v;            //value within an a-instr
logic                           cmd_a;              //c-instr a
logic                           cmd_c1;             //c-instr c1
logic                           cmd_c2;             //c-instr c2
logic                           cmd_c3;             //c-instr c3
logic                           cmd_c4;             //c-instr c4
logic                           cmd_c5;             //c-instr c5
logic                           cmd_c6;             //c-instr c6
logic                           cmd_d1;             //c-instr d1
logic                           cmd_d2;             //c-instr d2
logic                           cmd_d3;             //c-instr d3
logic                           cmd_j1;             //c-instr j1
logic                           cmd_j2;             //c-instr j2
logic                           cmd_j3;             //c-instr j3
logic   [DW-1:0]                ad;                 //input of register A
logic                           aload;              //input load of register A
logic                           dload;              //input load of register D
logic                           mload;              //input load of data memory M
logic   [DW-1:0]                a;                  //output of register A
logic   [DW-1:0]                d;                  //output of register D
logic   [DW-1:0]                y;                  //2nd input of the ALU
logic   [DW-1:0]                alu_out;            //result of the ALU calc
logic                           alu_zr;             //alu flag zero
logic                           alu_ng;             //alu flag neg      
logic                           pc_load;            //load data into pc
logic                           pc_inc;             //increment pc
//logic   [PW-1:0]                pc;               //programm counter --> it's already an output

// --- submodules ---

// instruction demultiplexing
instr_demux         instr_demux_u0(
    .instr              ,    
    .instr_type         ,
    .instr_v            ,
    .cmd_a              ,
    .cmd_c1,
    .cmd_c2,
    .cmd_c3,
    .cmd_c4,
    .cmd_c5,
    .cmd_c6,
    .cmd_d1,
    .cmd_d2,
    .cmd_d3,
    .cmd_j1,
    .cmd_j2,
    .cmd_j3
);

// register A
dreg #( .W (DW) ) rega(
    .rst_n                  ,
    .clk50m                 ,
    .d                      (ad),
    .load                   (aload),
    .q                      (a)
);
// muxer for register A
assign ad = instr_type ? alu_out : instr_v;
assign aload = instr_type ? cmd_d1 : 1'b1;

//register D
dreg #( .W (DW) ) regd(
    .rst_n                  ,
    .clk50m                 ,
    .d                      (alu_out),
    .load                   (dload),
    .q                      (d)
);

//ALU
assign dload = cmd_d2;
alu #( .W (16) ) alu_u0  (
    .x                      (d),      // 16 bit operand x
    .y                      (y),      // 16 bit operand y
    .zx                     (cmd_c1), // set x to zero
    .nx                     (cmd_c2), // invert x
    .zy                     (cmd_c3), // set y to zero
    .ny                     (cmd_c4), // invert y
    .f                      (cmd_c5), // function: 1 for Add, 0 for And
    .no                     (cmd_c6), // negate the output
    .out                    (alu_out),// 16 bit output
    .zr                     (alu_zr), // true if out==0
    .ng                     (alu_ng)  // true if out<0
);
//input muxer for alu input y
assign y = cmd_a ? m : a;

//jump control
jmp_ctrl    jmp_ctrl_u0(
    .j1                     (cmd_j1),
    .j2                     (cmd_j2),
    .j3                     (cmd_j3),
    .neg                    (alu_ng),
    .zero                   (alu_zr),
    .pc_load                (pc_load),
    .pc_inc                 (pc_inc)
);

//program counter
pcount # ( .W(PW) ) pcount_u0(
    .rst_n                  ,               //active low reset
    .clk50m                 ,               //50MHz clock
    .load                   (pc_load),      //load new value into the counter
    .inc                    (pc_inc),       //increment the counter
    .cnt_in                 (a[PW-1:0]),    //counter load value
    .cnt                    (pc)            //the counter value
);

//assign remaining outputs
assign mload    = cmd_d3;
assign writeM   = mload;
assign outM     = alu_out;
assign addressM = a[AW-1:0];    //Note: skip MSBit



endmodule