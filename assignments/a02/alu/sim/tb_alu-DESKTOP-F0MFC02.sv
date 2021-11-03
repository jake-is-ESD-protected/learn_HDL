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
`define BIN_SET_0       6'b010101
`define BIN_SET_1       6'b111111
`define BIN_SET_n1      6'b010111
`define BIN_SET_x       6'b001100
`define BIN_SET_y       6'b000011
`define BIN_SET_nx      6'b101100
`define BIN_SET_ny      6'b100011
`define BIN_SET_NEG_x   6'b111100
`define BIN_SET_NEG_y   6'b110011
`define BIN_x_ADD_1     6'b111110
`define BIN_y_ADD_1     6'b111011
`define BIN_x_SUB_1     6'b011100
`define BIN_y_SUB_1     6'b010011
`define BIN_ADD         6'b010000
`define BIN_x_SUB_y     6'b110010
`define BIN_y_SUB_x     6'b111000
`define BIN_AND         6'b000000
`define BIN_OR          6'b101010

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
    
    $display("\nstart ALU...");
    $display("waiting for self-check:");

    //***ADDITION****************************************************************************************
    $display("\naddition:");
    x = 1;
    y = 2;
    c = `BIN_ADD;

    #100ns;

    $display("x = %d, y = %d, ", x, y);
    $display("no = %d, f = %d, ny = %d, nz = %d, nx = %d, zx = %d", c[5], c[4], c[3], c[2], c[1], c[0]);
    $display("out = %d, zr = %d, ng = %d", out, zr, ng);

    #100ns;

    //***SUBTRACTION****************************************************************************************
    $display("\nsubtraction to pos int:");
    x = 100;
    y = 50;
    c = `BIN_x_SUB_y;

    #100ns;

    $display("x = %d, y = %d, ", x, y);
    $display("no = %d, f = %d, ny = %d, nz = %d, nx = %d, zx = %d", c[5], c[4], c[3], c[2], c[1], c[0]);
    $display("out = %d, zr = %d, ng = %d", out, zr, ng);

    #100ns;

    //***SUBTRACTION_2****************************************************************************************
    $display("\nsubtraction to neg int:");
    x = 100;
    y = 50;
    c = `BIN_y_SUB_x;

    #100ns;

    $display("x = %d, y = %d, ", x, y);
    $display("no = %d, f = %d, ny = %d, nz = %d, nx = %d, zx = %d", c[5], c[4], c[3], c[2], c[1], c[0]);
    $display("out = %d, zr = %d, ng = %d", out, zr, ng);

    #100ns;

    //***SET_0****************************************************************************************
    $display("\nsetting to 0:");
    x = 100;
    y = 50;
    c = `BIN_SET_0;

    #100ns;

    $display("x = %d, y = %d, ", x, y);
    $display("no = %d, f = %d, ny = %d, nz = %d, nx = %d, zx = %d", c[5], c[4], c[3], c[2], c[1], c[0]);
    $display("out = %d, zr = %d, ng = %d", out, zr, ng);

    #100ns;

    //***AND_HEX****************************************************************************************
    $display("\nanding of hex vals:");
    x = 170;
    y = 85;
    c = `BIN_AND;

    #100ns;

    $display("x = %x, y = %x, ", x, y);
    $display("no = %d, f = %d, ny = %d, nz = %d, nx = %d, zx = %d", c[5], c[4], c[3], c[2], c[1], c[0]);
    $display("out = %d, zr = %d, ng = %d", out, zr, ng);

    #100ns;

    //***OR_HEX****************************************************************************************
    $display("\noring of hex vals:");
    x = 2'haa;
    y = 2'h55;
    c = `BIN_OR;

    #100ns;

    $display("x = %d, y = %d, ", x, y);
    $display("no = %d, f = %d, ny = %d, nz = %d, nx = %d, zx = %d", c[5], c[4], c[3], c[2], c[1], c[0]);
    $display("out = %d, zr = %d, ng = %d", out, zr, ng);

    #100ns;

    //***SET_-1****************************************************************************************
    $display("\nsetting output to -1:");
    x = 2'haa;
    y = 2'h55;
    c = `BIN_SET_n1;

    #100ns;

    $display("x = %d, y = %d, ", x, y);
    $display("no = %d, f = %d, ny = %d, nz = %d, nx = %d, zx = %d", c[5], c[4], c[3], c[2], c[1], c[0]);
    $display("out = %d, zr = %d, ng = %d", out, zr, ng);

    #100ns;

    //***NOT_MAX_VAL****************************************************************************************
    $display("\nsetting output to !255:");
    x = 1'hf;
    y = 2'h55;
    c = `BIN_SET_nx;

    #100ns;

    $display("x = %d, y = %d, ", x, y);
    $display("no = %d, f = %d, ny = %d, nz = %d, nx = %d, zx = %d", c[5], c[4], c[3], c[2], c[1], c[0]);
    $display("out = %d, zr = %d, ng = %d", out, zr, ng);

    #100ns;

    //***NEG_MAX_VAL****************************************************************************************
    $display("\nsetting output to -255:");
    x = 1'hf;
    y = 2'h55;
    c = `BIN_SET_NEG_x;

    #100ns;

    $display("x = %d, y = %d, ", x, y);
    $display("no = %d, f = %d, ny = %d, nz = %d, nx = %d, zx = %d", c[5], c[4], c[3], c[2], c[1], c[0]);
    $display("out = %d, zr = %d, ng = %d", out, zr, ng);

    #100ns;

end

endmodule