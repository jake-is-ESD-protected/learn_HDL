/*---------------------------------------------
Project:    Hack Computer
Module:     uC
Purpose:    uC = CPU+RAM+ROM
Author:     Andre Mitterbacher
Version:    v1, 23.11.2019            
---------------------------------------------*/


module uc
#(
    parameter DW = 16,                  //data width
    parameter AW = 15,                  //address width data RAM
    parameter PW = 15                   //address width instruction ROM
)
(
    input   logic               rst_n,              //active low reset
    input   logic               clk50m, 

    // memory mapped peripherals

    output  logic [DW-1:0]          reg0x7000,      //output reg 0
    output  logic [DW-1:0]          reg0x7001,      //output reg 1
    output  logic [DW-1:0]          reg0x7002,      //output reg 2

    input   logic [DW-1:0]          reg0x7400,      //input reg 0
    input   logic [DW-1:0]          reg0x7401,      //input reg 1
    input   logic [DW-1:0]          reg0x7402      //input reg 2
);

// --- internal wires ---
    logic   [AW-1:0]    addressM;
    logic   [DW-1:0]    inM;
    logic   [DW-1:0]    outM;
    logic               writeM;
    logic   [DW-1:0]    instr;              //instruction from ROM
    logic   [PW-1:0]    pc;                 //address for ROM instruction
// --- submodules ---
// --- The CPU ---
cpu #(
    .DW (DW),  //data width
    .AW (AW),  //address width data RAM
    .PW (PW)   //address width instruction ROM
)
cpu_u0 (
    .rst_n                      ,           //active low reset
    .clk50m                     ,           //50MHz clock
    .inM                        ,           //data from RAM
    .instr                      ,           //instruction from ROM
    .writeM                     ,           //write enable for RAM
    .outM                       ,           //data to RAM
    .addressM                   ,           //address for RAM
    .pc                                     //address for ROM instruction
);
// --- DATA RAM incl memory mapped peripherals ---
data_mem #(
    .AW (15), 
    .DW (16)
)
data_mem_u0 (
    .rst_n          ,                   //active low reset
    .clk50m         ,                   //clock active edge is posedge
    .addr           (addressM),         //address lines
    .data_in        (outM),             //data input
    .we             (writeM),           //write enable
    .data_out       (inM),              //data output
    // memory mapped peripherals
    
    .reg0x7000      ,                   //output reg 0
    .reg0x7001      ,                   //output reg 1
    .reg0x7002      ,                   //output reg 2
    
    .reg0x7400      ,                   //input reg 0
    .reg0x7401      ,                   //input reg 1
    .reg0x7402                          //input reg 2
);
// --- Program ROM ---
rom32k      rom32k_u0 (
	.address                (pc),       //address for ROM instruction
	.clock                  (clk50m),   //50MHz clock
	.q                      (instr)     //instruction from ROM   
);

endmodule