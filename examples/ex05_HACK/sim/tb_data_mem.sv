/*
*****************************************************************************************
project name:       tb_data_mem
auth:               Jakob Tschavoll
date:               03.12.21
brief:              system verilog implementation of testbench for memory mapped IO
version:            V1.0
*****************************************************************************************
*/


`timescale 10ns/10ns

module tb_data_mem ();

localparam AW = 15;
localparam DW = 16;

logic rst_n;
logic clk50m;
logic we;
logic [DW-1:0]data_in;
logic [AW-1:0]addr;
logic [DW-1:0] data_out;
logic [DW-1:0]reg0x7400;
logic [DW-1:0]reg0x7401;
logic [DW-1:0]reg0x7402;

logic [DW-1:0]reg0x7000;
logic [DW-1:0]reg0x7001;
logic [DW-1:0]reg0x7002;

data_mem
#(
    .AW (AW),
    .DW (DW)
)
dut
(
    .*
);

logic run_sim = 1'b1;

initial begin
    clk50m = 1'b0;
    while (run_sim) begin
        #10ns;
        clk50m = ~clk50m;
    end
end

initial begin
    rst_n = 1'b0;
    addr = '0;
    data_in = '0;
    we = 1'b0;

    reg0x7400 = 16'hAFFE;
    reg0x7401 = 16'hEDDA;
    reg0x7402 = 16'hDADA;

    #90ns;
    rst_n = 1'b1;

    #1us;
    @(negedge clk50m);
    addr = 15'h0000;
    data_in = '1;
    we = 1'b1;

    @(negedge clk50m);
    we = 1'b0;

    @(negedge clk50m);
    assert (data_out == data_in) 
    else   begin
        $display("wrong value saved");
    end
        

    #1us;
    @(negedge clk50m);
    addr = 15'h3000;
    data_in = '1;
    we = 1'b1;

    @(negedge clk50m);
    we = 1'b0;

    @(negedge clk50m);
    assert (data_out == data_in) 
    else   begin
        $display("wrong value saved");
    end


    #1us;
    @(negedge clk50m);
    addr = 15'h7002;
    data_in = '1;
    we = 1'b1;
    
    @(negedge clk50m);
    we = 1'b0;
    @(negedge clk50m);
    assert (data_out == data_in) 
    else   begin
        $display("wrong value saved");
    end
    assert (reg0x7402 == '1) 
    else   begin
        $display("oreg output not set");
    end


    #1us;
    run_sim = 1'b0;
end

endmodule