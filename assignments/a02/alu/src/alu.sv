/*
*****************************************************************************************
project name:       alu
auth:               Jakob Tschavoll
date:               21.10.21
brief:              system verilog implementation of a 16bit ALU
version:            V1.0
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
    if(zx) begin
        x_temp = 0;
    end
    else if(nx) begin
        x_temp = !x;
    end
    else begin
        x_temp = x;
    end

    // setting y
    if(zy) begin
        y_temp = 0;
    end
    else if(ny) begin
        y_temp = !y;
    end
    else begin
        y_temp = y;
    end

    // setting operation
    if(f) begin
        out_temp = x_temp + y_temp;
    end
    else begin
        out_temp = x_temp & y_temp;
    end

    // post-process out
    if(no) begin
        out = !out_temp;
    end
    else begin
        out = out_temp;
    end

    // setting out-flags
    if(out_temp == 0) begin
        zr = 1'b1;
    end
    else begin
        zr = 1'b0;
    end
    if(out_temp < 0) begin
        ng = 1'b1;
    end
    else begin
        ng = 1'b0;
    end
end

endmodule