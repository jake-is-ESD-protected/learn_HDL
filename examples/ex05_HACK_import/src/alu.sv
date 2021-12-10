/*---------------------------------------------
Project:    Hack Computer
Module:     ALU
Purpose:    Implement the arithmetic and logic operations
            for the Hack CPU
Author:     Andre Mitterbacher
Version:    v0, 25.03.2019            
---------------------------------------------*/

module alu 
    #(parameter W = 16)  
    (
    input   logic signed   [W-1:0]      x,      // 16 bit operand x
    input   logic signed   [W-1:0]      y,      // 16 bit operand y
    input   logic                       zx,     // set x to zero
    input   logic                       nx,     // invert x
    input   logic                       zy,     // set y to zero
    input   logic                       ny,     // invert y
    input   logic                       f,      // function: 1 for Add, 0 for And
    input   logic                       no,     // negate the output

    output  logic signed  [W-1:0]       out,    // 16 bit output
    output  logic                       zr,     // true if out==0
    output  logic                       ng      // true if out<0
);




// --- Process the input x ---
logic [W-1:0] x_z;
logic [W-1:0] x_z_n;
// if zx then x=0
assign x_z     = zx ? '0 : x;
// if nx then x=~x
assign x_z_n  = nx ? ~x_z : x_z;

// --- Process the input y ---
logic [W-1:0] y_z;
logic [W-1:0] y_z_n;
// if zy then y=0
assign y_z     = zy ? '0 : y;
// if ny then y=~y
assign y_z_n  = ny ? ~y_z : y_z;

// --- Implement the operation f ---
logic [W-1:0] out_f;
// if f then out=a+b else out = a&b
always_comb begin
    if (f) begin
        out_f = x_z_n + y_z_n;
    end
    else begin
        out_f = x_z_n & y_z_n;
    end
end

// --- Post processing of out_f ---
// if no then out=~out
assign out = no ? ~out_f : out_f;

// --- output flags ---
// ng and zr are derived from the output out
// ng is set if the MSB=1 --> negative number
// zr is set if out==0
assign zr = (out == '0);
assign ng = out[W-1];

endmodule