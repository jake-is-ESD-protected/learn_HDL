/*
*****************************************************************************************
project name:       tb_cpu
auth:               Jakob Tschavoll
date:               17.11.21
brief:              system verilog testbench for cpu
version:            V1.0
*****************************************************************************************
*/

module tb_cpu();

localparam  DW = 16;
localparam  AW = 14;
localparam  PW = 14;

logic rst_n;
logic clk50m;
logic [DW-1:0]instr;
logic [DW-1:0]inM;

logic writeM;
logic [DW-1:0] outM;
logic [AW-1:0] addressM;
logic [PW-1:0] pc;

cpu #(.DW (DW), .AW (AW), .PW (PW)) dut (.*);

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

    $display("\n#################\nStarting CPU\n#################\n");

    $display("Load A to the value 0x7FFF:");
    @(negedge clk50m)
    instr = 16'h7fff;   // what to do
    @(negedge clk50m)
    $display("addressM is %b", addressM);
    if (addressM == 14'b11111111111111) begin
        $display("--> Success.\n");
    end
    else begin
        $display("unexpected address: %b\n", addressM);
        error_cnt += 1;
    end

    $display("Load A to the value 0x0000:");
    @(negedge clk50m)
    instr = 16'h0000;
    @(negedge clk50m)
    $display("addressM is %b", addressM);
    if (addressM == 14'b00000000000000) begin
        $display("--> Success.\n");
    end
    else begin
        $display("unexpected address: %b\n", addressM);
        error_cnt += 1;
    end

    $display("Set D to 1:");
    @(negedge clk50m)
    instr = 16'b1110111111010000;
    @(negedge clk50m)
    $display("outM is %d", outM);
    if (outM == 16'd1) begin
        $display("--> Success.\n");
    end
    else begin
        $display("unexpected value: %d\n", outM);
        error_cnt += 1;
    end

    $display("Add D+A and store the result in D:");
    @(negedge clk50m)
    instr = 16'b1110000010010000;
    @(negedge clk50m)
    $display("outM is %d", outM);
    if (outM == 16'd1) begin
        $display("--> Success.\n");
    end
    else begin
        $display("unexpected value: %d\n", outM);
        error_cnt += 1;
    end

    $display("Increment A and store the result in memory:");
    @(negedge clk50m)
    instr = 16'b1110110111001000;
    @(negedge clk50m)
    $display("outM is %d", outM);
    if (outM == 16'd1) begin
        $display("--> Success.\n");
    end
    else begin
        $display("unexpected value: %d\n", outM);
        error_cnt += 1;
    end

    run_sim = 1'b0;

    if(error_cnt > 0) begin
        $display("Total error-count: %d\n", error_cnt);
    end
    else begin
        $display("\nSelf check clean, leaving...");
    end
    
end

endmodule