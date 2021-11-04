/*
*****************************************************************************************
project name:       dreg
auth:               Jakob Tschavoll
date:               03.11.21
brief:              system verilog implementation of a D-FF
version:            V1.0
*****************************************************************************************
*/

module dreg
#(
    parameter W  = 16
)
(
    input logic rst_n,          // reset
    input logic clk50m,         // clock
    input logic load,           // enable
    input logic [W-1:0] d,      // register input

    output logic [W-1:0] q      // register output
);

logic [W-1:0] q_new;

always_ff @( negedge rst_n or posedge clk50m ) begin

    if(!rst_n) begin
        q_new <= 16'd0;  // reset: set value to 0
    end
    else if(load) begin
        q_new <= d;      // load: store input in helper-var
    end
    else begin
        q_new <= q;      // any other case: state is kept
    end

    q <= q_new;
end

endmodule