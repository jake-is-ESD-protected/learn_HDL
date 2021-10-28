/*
*****************************************************************************************
project name:       alu
auth:               Jakob Tschavoll
date:               21.10.21
brief:              system verilog implementation of a 16bit ALU
version:            V1.1, fixed confusion of "!" with "~"
*****************************************************************************************
*/

/* "chip" shall contain 11 pins:
*   8 inputs   
*   3 outputs
*/
module alu
#(
    parameter WORDSIZE = 16
)
(
    input logic [WORDSIZE-1:0] x,
    input logic [WORDSIZE-1:0] y,

    input logic zx,
    input logic nx,
    input logic zy,
    input logic ny,
    input logic f,
    input logic no,

    output logic [WORDSIZE-1:0] out,

    output logic zr,
    output logic ng
);

logic [WORDSIZE-1:0] x_temp;
logic [WORDSIZE-1:0] y_temp;
logic [WORDSIZE-1:0] out_temp;

always_comb begin
    
    // setting x
    x_temp = x;
    if(zx) begin
        x_temp = 0;
    end
    if(nx) begin
        x_temp = ~x_temp;
    end

    // setting y
    y_temp = y;
    if(zy) begin
        y_temp = 0;
    end
    if(ny) begin
        y_temp = ~y_temp;
    end

    // setting operation
    if(f) begin
        out_temp = x_temp + y_temp;    
    end
    else begin
        out_temp = x_temp & y_temp;
    end

    // post-process out
    out = out_temp;
    if(no) begin
        out = ~out_temp;
    end

    // setting out-flags
    zr = 1'b0;
    if(out_temp == 0) begin
        zr = 1'b1;
    end

    ng = 1'b0;
    if(out[WORDSIZE-1] == 1) begin
        ng = 1'b1;
    end
end

endmodule