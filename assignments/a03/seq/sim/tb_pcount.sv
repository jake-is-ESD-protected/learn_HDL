/*
*****************************************************************************************
project name:       pcount
auth:               Jakob Tschavoll
date:               03.11.21
brief:              system verilog testbench for counter
version:            V1.1
*****************************************************************************************
*/

module tb_pcount ();

localparam WTB = 15;

logic rst_n;
logic clk50m;
logic load;
logic inc;
logic [WTB-1:0] cnt_in;
logic [WTB-1:0] cnt;

pcount #(.W (WTB)) dut (.*);

logic run_sim = 1'b1;
int error_cnt = 0;

initial begin
    clk50m = 1'b0;
    while(run_sim)begin
        #10ns;
        clk50m = ~clk50m;
    end
end

initial begin

    $display("\n#################\nStarting counter\n#################\n");
    rst_n = 1'b1;
    cnt_in = 16'b0;
    load = 1'b1;
    #40ns;
    load = 1'b0;

    $display("increment test:");
    @(negedge clk50m);
    inc = 1'b1;
    @(negedge clk50m);
    #800ns;  // wait for timer to rise
    $display("cnt = %d", cnt);
    assert (cnt == 16'd41) 
    else begin
        $display("Counter not on expected value. cnt = %d", cnt);
        error_cnt += error_cnt;
    end

    $display("manual reset:");
    @(negedge clk50m);
    rst_n = 1'b0;
    @(negedge clk50m);

    $display("cnt = %d", cnt);
    assert (cnt == 16'd0) 
    else begin
        $display("Counter not on expected value. cnt = %d", cnt);
        error_cnt += error_cnt;
    end

    $display("load preload 20");
    @(negedge clk50m);
    rst_n = 1'b1;
    cnt_in = 16'd20;
    load = 1'b1;
    #40ns;
    load = 1'b0;
    #800ns;

    $display("cnt = %d", cnt);
    assert (cnt == 16'd60) 
    else begin
        $display("Counter not on expected value. cnt = %d", cnt);
        error_cnt += error_cnt;
    end

    if(error_cnt > 0) begin
        $display("Total error-count: %d\n", error_cnt);
    end
    else begin
        $display("\nSelf check clean, leaving...");
    end
    run_sim = 1'b0;
end

endmodule