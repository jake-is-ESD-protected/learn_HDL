/*
*****************************************************************************************
project name:       tb_sevenseg
auth:               Jakob Tschavoll
date:               14.10.21
brief:              testbench for sevenseg implementation
version:            V1.0
*****************************************************************************************
*/

module tb_sevenseg 
(
    // no I/O because this is a testbench
);

logic [3:0] bBus;
logic [6:0] hexBus;
logic [6:0] nhexBus;

sevenseg dut
(
    .
)