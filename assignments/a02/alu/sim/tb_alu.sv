/*
*****************************************************************************************
project name:       alu
auth:               Jakob Tschavoll
date:               22.10.21
brief:              system verilog implementation of a 16bit ALU
version:            V1.0
*****************************************************************************************
*/

module tb_alu();

localparam WTB = 16;

logic [WTB-1:0] x;
logic [WTB-1:0] y;
logic           zx;
logic           nx;
logic           zy;
logic           ny;
logic           f;
logic           no;
logic [WTB-1:0] out;
logic           zr;
logic           ng;

logic [5:0] c;

alu #(.WORDSIZE (WTB)) dut
(
    .zx (c[0]),
    .nx (c[1]),
    .zy (c[2]),
    .ny (c[3]),
    .f  (c[4]),
    .no (c[5]),
    .*
);

initial begin
    
    $display("start ALU...");
    $display("waiting for self-check");

    $display("addition test:");
    x = 1;
    y = 2;
    c = 6'b010000;

    #100ns;

    $display("x = %d, y = %d, ", x, y);
    $display("no = %d, f = %d, ny = %d, nz = %d, nx = %d, zx = %d", c[5], c[4], c[3], c[2], c[1], c[0]);
    $display("out = %d, zr = %d, ng = %d", out, zr, ng);

end

endmodule