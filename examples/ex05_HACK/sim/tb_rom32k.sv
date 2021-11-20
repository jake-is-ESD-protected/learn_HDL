/*
*****************************************************************************************
project name:       rom32k
auth:               Jakob Tschavoll
date:               19.11.21
brief:              system verilog implementation of rom
version:            V1.0
*****************************************************************************************
*/

`timescale 10ns/10ns

module tb_rom32k();

logic [14:0] address;
logic clock;
logic [15:0] q;

rom32k dut (.*);

logic run_sim = 1'b1;

initial begin
    clock = 1'b0;
    while (run_sim) begin
        #10ns;
        clock = ~clock;
    end
end

initial begin
    address = '0;

    $readmemh("../ip/rom32k_content0.txt", tb_rom32k.dut.altsyncram_component.m_default.altsyncram_inst.mem_data);

    for(int i = 0; i < 16; i++) begin
        @(negedge clock)
        address = i;
    end
    #1us;
    run_sim = 1'b0;
end

endmodule