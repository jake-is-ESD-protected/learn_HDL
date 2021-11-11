/*
*****************************************************************************************
project name:       tb_uart_tx
auth:               Jakob Tschavoll
date:               11.11.21
brief:              system verilog implementation of a uart transmitter
version:            V1.0
*****************************************************************************************
*/

module tb_uart_tx();

localparam      FCLK_TB = 50000000;
localparam      BAUD_TB = 115200;
logic           rst_n_i;
logic           clk_i;
logic [7:0]     tx_data_i;
logic           tx_start_i;

logic           tx_o;
logic           idle_o;

uart_tx #(.CLK(FCLK_TB), .BAUD(BAUD_TB)) dut (.*);

logic run_sim = 1'b1;
//localparam TCLK = 1/FCLK;

initial begin
    clk_i = 1'b0;
    while(run_sim) begin
        #10ns;
        clk_i = ~clk_i;
    end
end

initial begin
    rst_n_i = 1'b0;
    tx_data_i = '0;
    tx_start_i = 1'b0;

    #95ns;
    rst_n_i = 1'b1;

    #1us;
    @ (negedge clk_i);
    tx_data_i = 8'hAA;
    tx_start_i = 1'b1;

    #100ns
    @ (posedge idle_o);

    #1us;
    run_sim = 1'b0;
end

endmodule