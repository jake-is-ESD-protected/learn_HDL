/*
*****************************************************************************************
project name:       arithm (adder_unsigned)
auth:               Jakob Tschavoll
date:               21.10.21
brief:              system verilog implementation of an adder
version:            V1.0
*****************************************************************************************
*/

module adder_unsigned

#
(
    parameter WIDTH = 3 // changable constant param to adjust system before compiling
)

(
    input logic[WIDTH-1:0]    x1,
    input logic[WIDTH-1:0]    x2,

    output logic[WIDTH-1:0]   sum
);

logic [WIDTH:0] x1_temp;    // one more digit for OF detection
logic [WIDTH:0] x2_temp;
logic [WIDTH:0] sum_temp;

// assign a 4bit val to a 3bit val by introducing a 0 manually
assign x1_temp = {1'b0, x1};
assign x2_temp = {1'b0, x2};

// core of the function
assign sum_temp = x1_temp + x2_temp;

// OF detector with c-like ?: - statement
// if OF occurs, assign the 3BIT_MAX_VALUE (all 1s done by '1)
// read: "if sum_temp at the MSB is 1 (indicates OF), set the ouput to max value. If not, leave it as it is"
assign sum = sum_temp[WIDTH] ? '1 : sum_temp[WIDTH-1:0];

endmodule