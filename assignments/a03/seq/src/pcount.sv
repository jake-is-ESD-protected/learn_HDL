/*
*****************************************************************************************
project name:       pcount
auth:               Jakob Tschavoll
date:               03.11.21
brief:              system verilog implementation of a counter
version:            V1.0
*****************************************************************************************
*/

module pcount
#(
    parameter W  = 15
)
(
    input logic rst_n,          // reset
    input logic clk50m,         // clock
    input logic load,           // load to cnt_in
    input logic inc,            // increment on pos edge
    input logic [W-1:0] cnt_in, // input

    output logic [W-1:0] cnt    // output
);

logic [W-1:0] cnt_new;

always_ff @( negedge rst_n or posedge clk50m ) begin

    if(!rst_n) begin
        cnt_new <= 1'b0;    // reset: set value to 0
    end
    else if(load) begin
        cnt_new <= cnt_in;  // load: store input in helper-var
    end
    else if(inc) begin
        cnt_new <= (cnt + 1); // inc: increment counter value
    end
    else begin
        cnt_new <= cnt;     // any other case: state is kept
    end

    cnt <= cnt_new;
    
end

endmodule