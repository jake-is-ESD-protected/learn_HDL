/*---------------------------------------------
Project:    Hack Computer
Module:     ALU
Purpose:    Generic register
Author:     Andre Mitterbacher
Version:    v0, 08.05.2019            
---------------------------------------------*/

module dreg
#(
    parameter W = 16
)
(
    input   logic           rst_n,
    input   logic           clk50m,
    input   logic [W-1:0]   d,
    input   logic           load,
    output  logic [W-1:0]   q
);


always_ff @ (negedge rst_n or posedge clk50m) begin
    if (~rst_n) begin
        q <= '0;
    end
    else if(load) begin
        q <= d;
    end
end

endmodule