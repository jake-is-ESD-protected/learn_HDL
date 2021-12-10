/*
*****************************************************************************************
project name:       tb_mem_slice
auth:               Jakob Tschavoll
date:               03.12.21
brief:              system verilog implementation of testbench for memory mapped IO
version:            V1.0
*****************************************************************************************
*/

module tb_mem_slice ();

localparam AW = 15;
localparam DW = 16;

logic rst_n;
logic clk50m;
logic [AW-1:0]addr;
logic [DW-1:0]data_in;
logic we;

logic [DW-1:0]data_out;

mem_slice
#(
    .ADDRESS (15'h7401),
    .AW (AW),
    .DW (DW)
)
dut(.*);

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

    #90ns;
    rst_n = 1'b1;

    #1us;
    @(negedge clk50m);
    addr = 15'h7400;
    data_in = '1;
    we = 1'b1;

    @(negedge clk50m);
    we = 1'b0;

    @(negedge clk50m);
    assert (data_out == '0) 
    else   begin
        $display("wrong address");
    end
        

    #1us;
    @(negedge clk50m);
    addr = 15'h7401;
    data_in = '1;
    we = 1'b1;

    @(negedge clk50m);
    we = 1'b0;

    @(negedge clk50m);
    assert (data_out == '1) 
    else   begin
        $display("wrong address");
    end

    #1us;
    run_sim = 1'b0;
end

endmodule