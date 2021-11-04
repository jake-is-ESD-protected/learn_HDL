/*
*****************************************************************************************
project name:       pcount
auth:               Jakob Tschavoll
date:               03.11.21
brief:              system verilog implementation of a counter
version:            V1.0
*****************************************************************************************
*/

module pcount
#(
    parameter W  = 15
)
(
    input logic rst_n,          // reset
    input logic clk50m,         // clock
    input logic load,           // load to cnt_in
    input logic inc,            // increment on pos edge
    input logic [W-1:0] cnt_in, // input

    output logic [W-1:0] cnt    // output
);

always_ff @( negedge rst_n or posedge clk50m ) begin

    
    
end