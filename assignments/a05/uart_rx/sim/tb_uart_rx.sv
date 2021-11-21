/*
*****************************************************************************************
project name:       tb_uart_rx
auth:               Jakob Tschavoll
date:               20.11.21
brief:              system verilog implementation of an uart reciever
version:            V1.0
*****************************************************************************************
*/

// defines
`define HIGH (1'b1)
`define LOW (1'b0)

// tb module
module tb_uart_rx();

// global vars
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

// instances
uart_rx #(.fclk(fclk), .fbaud(fbaud)) uartrx (.*);
uart_tx #(.CLK(fclk), .BAUD(fbaud)) uarttx (.*);

// flag for error testing
logic do_error = `LOW;
logic noise;

always_comb begin
    // injection of errors
    if(do_error) begin
        rx = noise;
    end
    // normal simplex connection
    else begin
        rx = tx;
    end
    
end

// clock
logic run_sim = `HIGH;
int error_cnt = 0;
initial begin
    clk = `LOW;
    while(run_sim) begin
        #10ns;
        clk = ~clk;
    end
end

// tb
initial begin

    $display("\n#################\nStarting UART\n#################\n");
    
    // test reset
    $display("Initiate with reset:");
    rst_n = `LOW;
    tx_data = '0;
    tx_start = `LOW;
    #1us;
    rst_n = `HIGH;
    #10ns;
    $display("rx_idle = %b, rx_ready = %b, rx_error = %b", rx_idle, rx_ready, rx_error);
    if(~rx_ready && rx_idle && ~rx_error) begin
        $display("--> Flags correct.\n");
    end
    else begin
        $display("unexpected signals: rx_idle = %b, rx_ready = %b, rx_error = %b\n", rx_idle, rx_ready, rx_error);
        error_cnt += 1;
    end
    	
    // transmit 0xa5
    $display("Transmit 0xA5:");
    #1us;
    @ (negedge clk);
    tx_data = 8'ha5;
    tx_start = `HIGH;
    #100ns
    tx_start = `LOW;
    $display("Flags in transit:\nrx_idle = %b, rx_ready = %b, rx_error = %b", rx_idle, rx_ready, rx_error);
    if(~rx_ready && ~rx_idle && ~rx_error) begin
        $display("--> Flags correct.");
    end
    else begin
        $display("unexpected signals: rx_idle = %b, rx_ready = %b, rx_error = %b\n", rx_idle, rx_ready, rx_error);
        error_cnt += 1;
    end
    @ (posedge tx_idle);
    #100ns;
    $display("Flags after transit:\nrx_idle = %b, rx_ready = %b, rx_error = %b", rx_idle, rx_ready, rx_error);
    $display("sent data: 0x%x. recieved data: 0x%x", tx_data, rx_data);
    if(rx_data == tx_data) begin
        $display("--> Success.\n");
    end
    else begin
        $display("unexpected data: rx_data = 0x%x\n", rx_data);
        error_cnt += 1;
    end

    // transmit 0x5a
    $display("Transmit 0x5A:");
    #1us;
    @ (negedge clk);
    tx_data = 8'h5a;
    tx_start = `HIGH;
    #100ns
    tx_start = `LOW;
    $display("Flags in transit:\nrx_idle = %b, rx_ready = %b, rx_error = %b", rx_idle, rx_ready, rx_error);
    if(~rx_ready && ~rx_idle && ~rx_error) begin
        $display("--> Flags correct.");
    end
    else begin
        $display("unexpected signals: rx_idle = %b, rx_ready = %b, rx_error = %b\n", rx_idle, rx_ready, rx_error);
        error_cnt += 1;
    end
    @ (posedge tx_idle);
    #100ns;
    $display("Flags after transit:\nrx_idle = %b, rx_ready = %b, rx_error = %b", rx_idle, rx_ready, rx_error);
    $display("sent data: 0x%x. recieved data: 0x%x", tx_data, rx_data);
    if(rx_data == tx_data) begin
        $display("--> Success.\n");
    end
    else begin
        $display("unexpected data: rx_data = 0x%x\n", rx_data);
        error_cnt += 1;
    end

    // transmit 0xff
    $display("Transmit 0xFF:");
    #1us;
    @ (negedge clk);
    tx_data = 8'hff;
    tx_start = `HIGH;
    #100ns
    tx_start = `LOW;
    $display("Flags in transit:\nrx_idle = %b, rx_ready = %b, rx_error = %b", rx_idle, rx_ready, rx_error);
    if(~rx_ready && ~rx_idle && ~rx_error) begin
        $display("--> Flags correct.");
    end
    else begin
        $display("unexpected signals: rx_idle = %b, rx_ready = %b, rx_error = %b\n", rx_idle, rx_ready, rx_error);
        error_cnt += 1;
    end
    @ (posedge tx_idle);
    #100ns;
    $display("Flags after transit:\nrx_idle = %b, rx_ready = %b, rx_error = %b", rx_idle, rx_ready, rx_error);
    $display("sent data: 0x%x. recieved data: 0x%x", tx_data, rx_data);
    if(rx_data == tx_data) begin
        $display("--> Success.\n");
    end
    else begin
        $display("unexpected data: rx_data = 0x%x\n", rx_data);
        error_cnt += 1;
    end

    // transmit 0x00
    $display("Transmit 0x00:");
    #1us;
    @ (negedge clk);
    tx_data = 8'h00;
    tx_start = `HIGH;
    #100ns
    tx_start = `LOW;
    $display("Flags in transit:\nrx_idle = %b, rx_ready = %b, rx_error = %b", rx_idle, rx_ready, rx_error);
    if(~rx_ready && ~rx_idle && ~rx_error) begin
        $display("--> Flags correct.");
    end
    else begin
        $display("unexpected signals: rx_idle = %b, rx_ready = %b, rx_error = %b\n", rx_idle, rx_ready, rx_error);
        error_cnt += 1;
    end
    @ (posedge tx_idle);
    #100ns;
    $display("Flags after transit:\nrx_idle = %b, rx_ready = %b, rx_error = %b", rx_idle, rx_ready, rx_error);
    $display("sent data: 0x%x. recieved data: 0x%x", tx_data, rx_data);
    if(rx_data == tx_data) begin
        $display("--> Success.\n");
    end
    else begin
        $display("unexpected data: rx_data = 0x%x\n", rx_data);
        error_cnt += 1;
    end

    // force framing error
    $display("Force framing error in stopbit:");
    #1us;
    @ (negedge clk);
    tx_data = 8'h00;
    tx_start = `HIGH;
    #100ns
    tx_start = `LOW;

    #85us;
    do_error = `HIGH;
    noise = `LOW;
    #1us;
    do_error = `LOW;
    $display("rx_idle = %b, rx_ready = %b, rx_error = %b", rx_idle, rx_ready, rx_error);
    if(~rx_ready && ~rx_idle && rx_error) begin
        $display("--> Flags correct.\n");
    end
    else begin
        $display("unexpected signals: rx_idle = %b, rx_ready = %b, rx_error = %b\n", rx_idle, rx_ready, rx_error);
        error_cnt += 1;
    end
    @ (posedge tx_idle);


    #30us;
    run_sim = `LOW;

    if(error_cnt > 0) begin
        $display("Total error-count: %d\n", error_cnt);
    end
    else begin
        $display("\nSelf check clean, leaving...");
    end
end

endmodule