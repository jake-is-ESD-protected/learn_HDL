/*
*****************************************************************************************
project name:       counter
auth:               Jakob Tschavoll
date:               21.10.21
brief:              system verilog implementation of a counter
version:            V1.0
*****************************************************************************************
*/

module counter 
#(
    parameter WIDTH  = 8
)
(
    input logic rst_n,
    input logic clk50m,     // 50 MHz
    input logic en,         // en = 1 means active counting
    input logic up_dn_n,    // 1 = up, 0 = down

    output logic [WIDTH-1:0] cnt // counter value
);

// local signals
logic [WIDTH-1:0] cnt_new;

// create ff of width = WIDTH
always_ff @( negedge rst_n or posedge clk50m ) begin

    // reset should set everything to a constant value
    if(!rst_n) begin
        cnt <= '0;  // "<= is the assigment operator in an always block"
    end
    else begin
        cnt <= cnt_new;
    end
end

// comb logic
always_comb begin

    if (!en) begin
        cnt_new = cnt;
    end
    else if(en && up_dn_n) begin
        cnt_new = cnt + 1'b1;
    end
    else begin
        cnt_new = cnt - 1'b1;
    end
end
    
endmodule