/*
*****************************************************************************************
project name:       data_mem
auth:               Jakob Tschavoll
date:               3.12.21
brief:              data memory for RAM, IO
version:            V1.0
*****************************************************************************************
*/

module data_mem
#(
    parameter AW = 15,
    parameter DW = 16
)
(
    input logic rst_n,
    input logic clk50m,

    input logic we,
    input logic [DW-1:0]data_in,
    input logic [AW-1:0]addr,
    output logic [DW-1:0] data_out,

    input logic [DW-1:0]reg0x7400,
    input logic [DW-1:0]reg0x7401,
    input logic [DW-1:0]reg0x7402,
    
    output logic [DW-1:0]reg0x7000,
    output logic [DW-1:0]reg0x7001,
    output logic [DW-1:0]reg0x7002
);


// 16k RAM---------------------------------------
localparam RAM_START = 15'h000;
localparam RAM_END = 15'h3fff;
localparam ADDR_OREG0 = 15'h7000;
localparam ADDR_OREG1 = 15'h7001;
localparam ADDR_OREG2 = 15'h7002;
localparam ADDR_IREG0 = 15'h7400;
localparam ADDR_IREG1 = 15'h7401;
localparam ADDR_IREG2 = 15'h7402;

logic we_ram16k;
assign we_ram16k = we & (addr >= RAM_START) & (addr <= RAM_END);
logic [DW-1:0] data_out_ram16k;

ram16k ram16k_u0(
    .address (addr[13:0]), // only use 14 LSBs
    .clock (clk50m),
    .data (data_in),
    .wren (we_ram16k),
    .q (data_out_ram16k)
);

// mem_slice---------------------------------------
mem_slice 
#(
    .ADDRESS (ADDR_OREG0),
    .AW (AW),
    .DW (DW)
)
mem_slice_u0x7000
(
    .rst_n (rst_n),
    .clk50m (clk50m),
    .addr (addr),
    .data_in (data_in),
    .we (we),

    .data_out (reg0x7000)
);

mem_slice 
#(
    .ADDRESS (ADDR_OREG1),
    .AW (AW),
    .DW (DW)
)
mem_slice_u0x7001
(
    .rst_n (rst_n),
    .clk50m (clk50m),
    .addr (addr),
    .data_in (data_in),
    .we (we),

    .data_out (reg0x7001)
);

mem_slice 
#(
    .ADDRESS (ADDR_OREG2),
    .AW (AW),
    .DW (DW)
)
mem_slice_u0x7002
(
    .rst_n (rst_n),
    .clk50m (clk50m),
    .addr (addr),
    .data_in (data_in),
    .we (we),

    .data_out (reg0x7002)
);

// mux for data_out
always_comb begin
    if((addr >= RAM_START) & (addr <= RAM_END)) begin
        data_out = data_out_ram16k;
    end
    else if(addr == ADDR_OREG0) begin
        data_out = reg0x7000;
    end
    else if(addr == ADDR_OREG1) begin
        data_out = reg0x7001;
    end
    else if(addr == ADDR_OREG2) begin
        data_out = reg0x7002;
    end
    else if(addr == ADDR_IREG0) begin
        data_out = reg0x7400;
    end
    else if(addr == ADDR_IREG1) begin
        data_out = reg0x7401;
    end
    else if(addr == ADDR_IREG2) begin
        data_out = reg0x7402;
    end
    
end

endmodule