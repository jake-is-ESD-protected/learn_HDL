/*
*****************************************************************************************
project name:       tb_uart_rx
auth:               Jakob Tschavoll
date:               20.11.21
brief:              system verilog implementation of an uart reciever
version:            V1.0
*****************************************************************************************
*/
`define HIGH (1'b1)
`define LOW (1'b0)

module tb_uart_rx();

parameter fclk = 50000000;
parameter fbaud = 115200;

// rx
logic rst_n;
logic clk;
logic rx;

logic [7:0]rx_data;
logic rx_idle;
logic rx_ready;
logic rx_error;

// tx
logic [7:0] tx_data;
logic tx_start;

logic tx;
logic tx_idle;

uart_rx #(.fclk(fclk), .fbaud(fbaud)) uartrx (.*);
uart_tx #(.CLK(fclk), .BAUD(fbaud)) uarttx (.*);

assign rx = tx;

logic run_sim = `HIGH;
initial begin
    clk = `LOW;
    while(run_sim) begin
        #10ns;
        clk = ~clk;
    end
end

initial begin
    rst_n = `LOW;
    tx_data = '0;
    tx_start = `LOW;
    
    #95ns;
    rst_n = `HIGH;

    #1us;
    @ (negedge clk);
    tx_data = 8'ha5;
    tx_start = `HIGH;
    #100ns
    tx_start = `LOW;
    @ (posedge tx_idle);

    #1us;
    @ (negedge clk);
    tx_data = 8'h5a;
    tx_start = `HIGH;
    #100ns;
    tx_start = `LOW;
    @ (posedge tx_idle);

    #1us;
    @ (negedge clk);
    tx_data = 8'hff;
    tx_start = `HIGH;
    #100ns
    tx_start = `LOW;
    @ (posedge tx_idle);

    #1us;
    @ (negedge clk);
    tx_data = 8'h00;
    tx_start = `HIGH;
    #100ns;
    tx_start = `LOW;
    @ (posedge tx_idle);

    #100ns;
    run_sim = `LOW;
end

endmodule