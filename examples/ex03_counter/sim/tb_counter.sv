/*
*****************************************************************************************
project name:       counter
auth:               Jakob Tschavoll
date:               21.10.21
brief:              system verilog implementation of a counter
version:            V1.0
*****************************************************************************************
*/

module tb_counter ();

localparam WTB = 5;

logic rst_n;
logic clk50m;
logic en;
logic up_dn_n;

logic [WTB-1:0]cnt;

counter #(.WIDTH (WTB)) dut (.*);

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
    $display("Starting counter");
    rst_n =     1'b0;
    en =        1'b0;
    up_dn_n =   1'b0;

    #90ns;
    assert (cnt == '0) 
    else begin
        $display("Counter not reset. cnt = %d", cnt);
        error_cnt += error_cnt;
    end

    #10ns;
    $display("power on reset");
    rst_n = 1'b1;
    
    #1us;
    @(negedge clk50m);
    en = 1'b1;
    up_dn_n = 1'b1;
    @(negedge clk50m);

    assert (cnt == '1) 
    else begin
        $display("Counter not incrementing. cnt = %d", cnt);
        error_cnt += error_cnt;
    end

    #1us;
    run_sim = 1'b0;
    $display("Stopping counter");

    if(error_cnt == 0) begin
        $display("PASSED");
    end
    else begin
        $display("FAILED");
    end
end
    
endmodule