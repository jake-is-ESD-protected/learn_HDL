/*---------------------------------------------
Project:    Hack Computer
Module:     ALU
Purpose:    Programm counter
Author:     Andre Mitterbacher
Version:    v0, 08.05.2019            
---------------------------------------------*/

module pcount
#(
    parameter           W = 15             //counter width
)
(
    input   logic           rst_n,              //active low reset
    input   logic           clk50m,             //50MHz clock
    input   logic           load,               //load new value into the counter
    input   logic           inc,                //increment the counter
    input   logic [W-1:0]   cnt_in,             //counter load value
    output  logic [W-1:0]   cnt                 //the counter value
);


always_ff @ (negedge rst_n or posedge clk50m) begin : pc_counter
    if (~rst_n) begin
        cnt <= 1'b0;
    end
    else if (load) begin
        cnt <= cnt_in;
    end
    else if (inc) begin
        cnt <= cnt + 1'b1;     //no overflow protection here!!!
    end
end



endmodule