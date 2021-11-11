/*
*****************************************************************************************
project name:       uart_tx
auth:               Jakob Tschavoll
date:               11.11.21
brief:              system verilog implementation of a uart transmitter
version:            V1.0
*****************************************************************************************
*/

module uart_tx
#(
    parameter CLK = 50000000,
    parameter BAUD = 115200
)
(
    input logic rst_n_i,
    input logic clk_i,
    input logic [7:0] tx_data_i,
    input logic tx_start_i,

    output logic tx_o,
    output logic idle_o
);

// local parameters
localparam WIDTHCNT_INIT = CLK / BAUD -1;
localparam WIDTHCNT_W = $clog2(WIDTHCNT_INIT);

// local signals
logic widthcnt_zero;
logic [WIDTHCNT_W-1:0]widthcnt;
logic widthcnt_load;
logic [2:0]bitcnt;
logic bitcnt_inc;
logic bitcnt_init;

// FSM
enum logic [1:0] {IDLE, START, DATA, STOP} state, state_next;

always_ff @( negedge rst_n_i or posedge clk_i ) begin
    if(~rst_n_i) begin
        state <= IDLE;
    end
    else begin
        state <= state_next;
    end
end

always_comb begin

    state_next = state;
    widthcnt_load = 1'b0;
    tx_o = 1'b1;
    bitcnt_init = 1'b0;
    bitcnt_inc = 1'b0;
    idle_o = 1'b0;

    case(state)

        IDLE: begin
            idle_o = 1'b1;
            if(tx_start_i) begin
                state_next = START;
                widthcnt_load = 1'b1;
            end
        end

        START: begin
            tx_o = 1'b0;
            if(widthcnt_zero) begin
                state_next = DATA;
                widthcnt_load = 1'b1;
                bitcnt_init = 1'b1;
            end
            
        end

        DATA: begin
            tx_o = tx_data_i[bitcnt];
            if(widthcnt_zero && (bitcnt < 3'd7)) begin
                state_next = DATA;
                widthcnt_load = 1'b1;
                bitcnt_inc = 1'b1;
            end
            else if(widthcnt_zero && (bitcnt >= 3'd7)) begin
                state_next = STOP;
                widthcnt_load = 1'b1;
            end
        end

        STOP: begin
            if(widthcnt_zero) begin
                state_next = IDLE;
            end
        end

        default: begin
            state_next = IDLE;
        end

    endcase

end

// Width counter
always_ff @( negedge rst_n_i or posedge clk_i ) begin

    if(~rst_n_i) begin
        // since the reset is asynchronous, only constant values can be applied
        widthcnt <= '0;
    end
    else if(widthcnt_load) begin
        widthcnt <= WIDTHCNT_INIT;
    end
    else if(~widthcnt_zero) begin
        widthcnt <= widthcnt -1'b1;    // decrement
    end
    
end
assign widthcnt_zero = (widthcnt == '0);

// Bit counter
always_ff @( negedge rst_n_i or posedge clk_i ) begin

    if(~rst_n_i) begin
        // since the reset is asynchronous, only constant values can be applied
        bitcnt <= '0;
    end
    else if(bitcnt_init) begin
        bitcnt <= '0;
    end
    else if(bitcnt_inc) begin
        bitcnt <= bitcnt + 1'b1;
    end
    
end

endmodule