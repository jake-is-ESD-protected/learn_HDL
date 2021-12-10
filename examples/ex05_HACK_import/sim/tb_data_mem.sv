//-------------------------------------------------
// Project:     EDB HDL WS2021
// Purpose:     Data memory (RAM, output regs, input regs)
// Author:      Andre
// Version:     v0, 02.12.2021
//-------------------------------------------------

`timescale 10ns/10ns
module tb_data_mem();

// (1) DUT wiring
    localparam           AW = 15;
    localparam           DW = 16;
    logic               rst_n;
    logic               clk50m;
    logic               we;       
    logic [DW-1:0]      data_in;  
    logic [AW-1:0]      addr;     
    logic [DW-1:0]      data_out; 
    logic [DW-1:0]      reg0x7000;
    logic [DW-1:0]      reg0x7001;
    logic [DW-1:0]      reg0x7002;
    logic [DW-1:0]      reg0x7400;
    logic [DW-1:0]      reg0x7401;
    logic [DW-1:0]      reg0x7402;

// (2) DUT instance

data_mem #(.AW (AW), .DW(DW) ) dut (.*);

// (3) DUT stimuli
logic run_sim = 1'b1;

initial begin
    clk50m      = 1'b0;
    while (run_sim) begin
        #10ns;
        clk50m = ~clk50m;
    end
end

initial begin
    rst_n       = 1'b0;
    addr        = '0;
    data_in     = '0;
    we          = 1'b0;
    reg0x7400   = 16'hAFFE;
    reg0x7401   = 16'hEDDA;
    reg0x7402   = 16'hDADA;

    #90ns;
    rst_n       = 1'b1;

    #1us;
    // -- Write to RAM and read back ---
    @(negedge clk50m);
    addr        = 15'h0000;
    data_in     = '1;
    we          = 1'b1;
    @(negedge clk50m);
    we          = 1'b0;
    @(negedge clk50m);
    assert (data_out == data_in) else begin
        $error("RAM write failed at addr = %d",addr);
    end
    #1us;
    @(negedge clk50m);
    addr        = 15'h3000;
    data_in     = '1;
    we          = 1'b1;
    @(negedge clk50m);
    we          = 1'b0;
    @(negedge clk50m);
    assert (data_out == data_in) else begin
        $error("RAM write failed at addr = %d",addr);
    end

    // -- Write to OREGs and read back ---
    #1us;
    @(negedge clk50m);
    addr        = 15'h7002;
    data_in     = '1;
    we          = 1'b1;
    @(negedge clk50m);
    we          = 1'b0;
    @(negedge clk50m);
    assert (data_out == data_in) else begin
        $error("OREG write failed at addr = %d",addr);
    end
    assert (reg0x7002 == '1) else begin
        $error("OREG output not set at addr = %d",addr);
    end

    // -- Read from IREGs ---
    #1us;
    @(negedge clk50m);
    addr        = 15'h7400;
    @(negedge clk50m);
    assert (data_out == reg0x7400) else begin
        $error("IREG read failed at addr = %d",addr);
    end
    #1us;
    @(negedge clk50m);
    addr        = 15'h7401;
    @(negedge clk50m);
    assert (data_out == reg0x7400) else begin
        $error("IREG read failed at addr = %d",addr);
    end
    #1us;
    @(negedge clk50m);
    addr        = 15'h7402;
    @(negedge clk50m);
    assert (data_out == reg0x7400) else begin
        $error("IREG read failed at addr = %d",addr);
    end



    #1us;
    run_sim = 1'b0;
end

endmodule