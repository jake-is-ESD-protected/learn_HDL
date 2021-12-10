//-------------------------------------------------
// Project:     EDB HDL WS2021
// Purpose:     Memory mapped output for the HACK computer
// Author:      Andre
// Version:     v0, 02.12.2021
//-------------------------------------------------
`timescale  10ns/10ns
module tb_mem_slice ();

// (1) DUT wiring
localparam AW = 15;
localparam DW = 16;

logic                   rst_n;
logic                   clk50m;
logic [AW-1:0]          addr;
logic [DW-1:0]          data_in;
logic                   we;
logic [DW-1:0]          data_out;

// (2) DUT instance
mem_slice
#(
    .ADDRESS    (15'h7401),
    .AW         (AW),
    .DW         (DW)
)
dut (.*);

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

    #90ns;
    rst_n = 1'b1;

    #1us;
    @ (negedge clk50m);
    addr        = 15'h7400;     // WRONG address
    data_in     = '1;
    we          = 1'b1;
    @ (negedge clk50m);
    we          = 1'b0;
    @ (negedge clk50m);
    assert (data_out == '0) else begin
        $error("Wrong data_out for addr = %d", addr);
    end

    #1us;
    @ (negedge clk50m);
    addr        = 15'h7401;     // CORRECT address
    data_in     = '1;
    we          = 1'b1;
    @ (negedge clk50m);
    we          = 1'b0;
    @ (negedge clk50m);
    assert (data_out == '1) else begin
        $error("Wrong data_out for addr = %d", addr);
    end

    #1us;
    run_sim = 1'b0;

end


endmodule