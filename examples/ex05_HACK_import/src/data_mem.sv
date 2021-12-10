//-------------------------------------------------
// Project:     EDB HDL WS2021
// Purpose:     Data memory (RAM, output regs, input regs)
// Author:      Andre
// Version:     v0, 02.12.2021
//-------------------------------------------------

module data_mem
#(
    parameter           AW = 15,
    parameter           DW = 16
)
(
    input   logic               rst_n,
    input   logic               clk50m,

    input   logic               we,             //write enable
    input   logic [DW-1:0]      data_in,        //data from the cpu
    input   logic [AW-1:0]      addr,           //address from the cpu
    output  logic [DW-1:0]      data_out,       //data to the cpu

    output  logic [DW-1:0]      reg0x7000,      //output register
    output  logic [DW-1:0]      reg0x7001,
    output  logic [DW-1:0]      reg0x7002,

    input   logic [DW-1:0]      reg0x7400,      //input register
    input   logic [DW-1:0]      reg0x7401,
    input   logic [DW-1:0]      reg0x7402
);

localparam RAM_START = 15'h0000;
localparam RAM_END   = 15'h3FFF;

localparam ADDR_OREG_0 = 15'h7000;
localparam ADDR_OREG_1 = 15'h7001;
localparam ADDR_OREG_2 = 15'h7002;

localparam ADDR_IREG_0 = 15'h7400;
localparam ADDR_IREG_1 = 15'h7401;
localparam ADDR_IREG_2 = 15'h7402;

// --- 16k RAM IP ---
logic               we_ram16k;
logic [DW-1:0]      data_out_ram16k;

assign  we_ram16k = we & (addr >= RAM_START) & (addr <= RAM_END);

ram16k  ram16_u0
(
    .address        (addr[13:0]),   // use the 14 LSBs of addr
    .clock          (clk50m),
    .data           (data_in),
    .wren           (we_ram16k),
    .q              (data_out_ram16k)
);

// --- use the mem_slice for the output regs ---
mem_slice 
#(
    .ADDRESS         (ADDR_OREG_0),
    .AW              (AW),
    .DW              (DW)
) 
mem_slice_u0x7000
(
    .rst_n          (rst_n),
    .clk50m         (clk50m),
    .addr           (addr),
    .data_in        (data_in),
    .we             (we),

    .data_out       (reg0x7000)
);
mem_slice 
#(
    .ADDRESS         (ADDR_OREG_1),
    .AW              (AW),
    .DW              (DW)
) 
mem_slice_u0x7001
(
    .rst_n          (rst_n),
    .clk50m         (clk50m),
    .addr           (addr),
    .data_in        (data_in),
    .we             (we),

    .data_out       (reg0x7001)
);
mem_slice 
#(
    .ADDRESS         (ADDR_OREG_2),
    .AW              (AW),
    .DW              (DW)
) 
mem_slice_u0x7002
(
    .rst_n          (rst_n),
    .clk50m         (clk50m),
    .addr           (addr),
    .data_in        (data_in),
    .we             (we),

    .data_out       (reg0x7002)
);

// --- Mux for the data_out ---
always_comb begin : data_out_mux
    if ( (addr >= RAM_START) & (addr <= RAM_END) ) begin
        data_out = data_out_ram16k;
    end
    else if (addr == ADDR_OREG_0) begin
        data_out = reg0x7000;
    end
    else if (addr == ADDR_OREG_1) begin
        data_out = reg0x7001;
    end
    else if (addr == ADDR_OREG_2) begin
        data_out = reg0x7002;
    end
    else if (addr == ADDR_IREG_0) begin
        data_out = reg0x7400;
    end
    else if (addr == ADDR_IREG_1) begin
        data_out = reg0x7401;
    end
    else if (addr == ADDR_IREG_2) begin
        data_out = reg0x7402;
    end
    else begin
        data_out = '0;
    end
end


endmodule