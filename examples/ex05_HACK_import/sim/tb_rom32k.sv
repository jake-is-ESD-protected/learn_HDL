//-----------------------------------
// Project:     EDB HDL WS2021
// Purpose:     Check out the 32k ROM created by Quartus
// Author:      Andre
// Version:     v0
//-----------------------------------

`timescale 10ns/10ns

module tb_rom32k();

// (1) DUT wiring
    logic   [14:0]  address;
    logic           clock;
    logic   [15:0]  q;

// (2) DUT instance
rom32k dut (.*);

// (3) DUT stimuli
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

    $readmemh("../ip/rom32k_content0.txt",tb_rom32k.dut.altsyncram_component.m_default.altsyncram_inst.mem_data);
    
    #100ns;
    for (int i = 0; i < 16; i++) begin
        @ (negedge clock);
        address = i;


    end

    #1us;
    run_sim = 1'b0;
end

endmodule