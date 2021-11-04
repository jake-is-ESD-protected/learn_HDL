/*
*****************************************************************************************
project name:       dreg
auth:               Jakob Tschavoll
date:               03.11.21
brief:              system verilog testbench for D-FF
version:            V1.0
*****************************************************************************************
*/

module tb_dreg ();

localparam WTB = 16;

logic rst_n;
logic clk50m;
logic load;
logic [WTB-1:0] d;
logic [WTB-1:0] q;

dreg #(.W (WTB)) dut (.*);

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

    $display("Starting D-FF\n");
    rst_n = 1'b1;
    load = 1'b1;

    $display("Set data to 0:");
    d = 16'h0000;
    #80ns;  // wait for D-FF to store
    $display("q = %d", q);
    assert (q == 16'h0000) 
    else begin
        $display("Value not stored correctly. q = %d", q);
        error_cnt += error_cnt;
    end

    $display("Set data to MAX_VAL:");
    d = 16'hffff;
    #80ns;
    $display("q = %d", q);
    assert (q == 16'hffff) 
    else begin
        $display("Value not stored correctly. q = %d", q);
        error_cnt += error_cnt;
    end

    $display("Set data to AAFF:");
    d = 16'haaff;
    #80ns;
    $display("q = %d", q);
    assert (q == 16'haaff) 
    else begin
        $display("Value not stored correctly. q = %d", q);
        error_cnt += error_cnt;
    end

    $display("Set data to FFAA:");
    d = 16'hffaa;
    #80ns;
    $display("q = %d", q);
    assert (q == 16'hffaa) 
    else begin
        $display("Value not stored correctly. q = %d", q);
        error_cnt += error_cnt;
    end

    $display("Set data to 0 by resetting:");
    rst_n = 1'b0;
    #80ns;
    $display("q = %d", q);
    assert (q == 16'h0000) 
    else begin
        $display("Value not stored correctly. q = %d", q);
        error_cnt += error_cnt;
    end

    if(error_cnt > 0) begin
        $display("Total error-count: %d\n", error_cnt);
    end
    else begin
        $display("Self check clean, leaving...");
    end
    run_sim = 1'b0;
end

endmodule