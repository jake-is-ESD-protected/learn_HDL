//-------------------------------------------------
// Project:     EDB HDL WS2021
// Purpose:     Memory mapped output for the HACK computer
// Author:      Andre
// Version:     v0, 02.12.2021
//-------------------------------------------------

module mem_slice 
#(
    parameter ADDRESS = 15'h7400,
    parameter AW      = 15,
    parameter DW      = 16
) 
(
    input   logic                   rst_n,
    input   logic                   clk50m,
    input   logic [AW-1:0]          addr,
    input   logic [DW-1:0]          data_in,
    input   logic                   we,

    output  logic [DW-1:0]          data_out
);

always_ff @( negedge rst_n or posedge clk50m ) begin : oreg_ff
    if (~rst_n) begin
        data_out        <= '0;
    end
    else if ( (addr == ADDRESS) & we ) begin
        data_out        <= data_in;
    end
end
    
endmodule