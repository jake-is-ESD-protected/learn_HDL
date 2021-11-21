/*
*****************************************************************************************
project name:       uart_rx
auth:               Jakob Tschavoll
date:               20.11.21
brief:              system verilog implementation of an uart reciever
version:            V1.0
*****************************************************************************************
*/

module uart_rx
#(
    parameter fclk = 50000000,
    parameter fbaud = 115200
)
(
    input logic rst_n,
    input logic clk,
    input logic rx,

    output logic [7:0]rx_data,
    output logic rx_idle,
    output logic rx_ready,
    output logic rx_error
);

`define HIGH (1'b1)
`define LOW (1'b0)

localparam WIDTHCNT_INIT = fclk / fbaud -1; // starting value for counter (counts downward)
localparam WIDTHCNT_W = $clog2(WIDTHCNT_INIT);
logic widthcnt_zero;
logic [WIDTHCNT_W-1:0]widthcnt;
logic widthcnt_load;
logic [2:0]bitcnt;
logic bitcnt_inc;
logic bitcnt_init;
logic load_ready;
logic load_error = `LOW;
enum logic [1:0] {IDLE, START, DATA, STOP} state, state_next;

// driver for FSM
always_ff @( negedge rst_n or posedge clk ) begin
    if(~rst_n) begin
        state <= IDLE;
    end
    else begin
        state <= state_next;
    end
end

// counter for duration of tbaud
always_ff @( negedge rst_n or posedge clk ) begin

    if(~rst_n) begin
        // since the reset is asynchronous, only constant values can be applied
        widthcnt <= '0;
    end
    else if(widthcnt_load) begin
        widthcnt <= WIDTHCNT_INIT;
    end
    else if(~widthcnt_zero) begin
        widthcnt <= widthcnt - 1'b1;    // decrement
    end
    
end
assign widthcnt_zero = (widthcnt == '0);

// counter for number of recieved bits
always_ff @( negedge rst_n or posedge clk ) begin

    if(~rst_n) begin
        bitcnt <= '0;
    end
    else if(bitcnt_init) begin
        bitcnt <= '0;
    end
    else if(bitcnt_inc) begin
        bitcnt <= bitcnt + 1'b1;
    end
    
end

// FF for rx_ready flag
always_ff @( negedge rst_n or posedge clk ) begin

    if(~rst_n || ~load_ready) begin
        rx_ready <= `LOW;
    end
    else if(load_ready) begin
        rx_ready <= `HIGH;
    end
    else begin
        rx_ready <= rx_ready;
    end
end

// FF for rx_error flag
always_ff @( negedge rst_n or posedge clk ) begin

    if(~rst_n || ~load_error) begin
        rx_error <= `LOW;
    end
    else if(load_error) begin
        rx_error <= `HIGH;
    end
    else begin
        rx_error <= rx_error;
    end
end

always_comb begin

    state_next = state;
    widthcnt_load = `LOW;
    bitcnt_init = `LOW;
    bitcnt_inc = `LOW;

    rx_idle = `LOW;

    case(state)

        IDLE: begin
            rx_idle = `HIGH;
            load_ready = `HIGH;
            if(~rx) begin
                state_next = START;
                load_error = `LOW;
                widthcnt_load = `HIGH;
            end
        end

        START: begin
            load_ready = `LOW;
            if(widthcnt_zero) begin
                state_next = DATA;
                widthcnt_load = `HIGH;
                bitcnt_init = `HIGH;
            end
            
        end

        DATA: begin
            // sample at half the time of tbaud
            if(widthcnt == WIDTHCNT_INIT/2) begin
                rx_data[bitcnt] = rx;
            end
            if(widthcnt_zero && (bitcnt < 3'd7)) begin
                state_next = DATA;
                widthcnt_load = `HIGH;
                bitcnt_inc = `HIGH;
            end
            else if(widthcnt_zero && (bitcnt >= 3'd7)) begin
                state_next = STOP;
                widthcnt_load = `HIGH;
            end
        end

        STOP: begin
            if(widthcnt_zero) begin
                state_next = IDLE;
            end
            if(~rx) begin
                load_error = `HIGH;
            end
        end

        default: begin
            state_next = IDLE;
            load_error = `HIGH;
        end

    endcase

end
    
endmodule