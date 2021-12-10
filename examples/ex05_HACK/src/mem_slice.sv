/*
*****************************************************************************************
project name:       mem_slice
auth:               Jakob Tschavoll
date:               3.12.21
brief:              system verilog implementation of memory mapped IO
version:            V1.0
*****************************************************************************************
*/

module mem_slice
#(
    parameter ADDRESS = 15'h7400,
    parameter AW = 15,
    parameter DW = 16
) 
(
    input logic rst_n,
    input logic clk50m,
    input logic [AW-1:0]addr,
    input logic [DW-1:0]data_in,
    input logic we,

    output logic [DW-1:0]data_out
);
    
always_ff @( negedge rst_n or posedge clk50m ) begin : out_reg
    if (~rst_n) begin
        data_out <= '0;
    end
    else if ((addr == ADDRESS) & (we)) begin
        data_out <= data_in;
    end
end    
endmodule