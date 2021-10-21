/*
*****************************************************************************************
project name:       arithm (tb_adder_unsigned)
auth:               Jakob Tschavoll
date:               21.10.21
brief:              system verilog implementation of an adder
version:            V1.0
*****************************************************************************************
*/

module tb_adder_unsigned();
// DUT wiring
localparam WTB = 10;   // invisible from outside and read-only
localparam IMAX = 2**WTB - 1;
logic [WTB-1:0]     x1;
logic [WTB-1:0]     x2;
logic [WTB-1:0]     sum;

//DUT instance
adder_unsigned #(.WIDTH (WTB)) dut(.*);     // overwrite internal param with test-param and assign all wires

// DUT stim
initial begin
    for(x1 = 0; x1 < IMAX; x1 = x1 + 1)begin
        #100ns;
        for(x2 = 0; x2 < IMAX; x2 = x2 + 1)begin
            #100ns;
        end
    end
end

endmodule