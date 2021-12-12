
`timescale 10ns/10ns
module tb_toplevel_c5g_hex4_uart();

//////////// CLOCK //////////
logic	          		CLOCK_125_p;
logic	          		CLOCK_50_B5B;
logic	          		CLOCK_50_B6A;
logic	          		CLOCK_50_B7A;
logic	          		CLOCK_50_B8A;

//// LED //////////
logic	     [7:0]		LEDG;
logic	     [9:0]		LEDR;

//// KEY //////////
logic	          		CPU_RESET_n;
logic	     [3:0]		KEY;

//// SW //////////
logic	     [9:0]		SW;

//// SEG7 //////////
logic	     [6:0]		HEX0;
logic	     [6:0]		HEX1;
logic	     [6:0]		HEX2;
logic	     [6:0]		HEX3;

//// Uart to USB //////////
logic	          		UART_RX;
logic	          		UART_TX;

toplevel_c5g_hex4_uart dut
(
    .*
);

logic run_sim = 1'b1;

initial begin
    CLOCK_50_B5B      = 1'b0;
    while (run_sim) begin
        #10ns;
        CLOCK_50_B5B = ~CLOCK_50_B5B;
    end
end

initial begin

    $readmemb("../asm/program.hack",tb_toplevel_c5g_hex4_uart.dut.uc_u0.rom32k_u0.altsyncram_component.m_default.altsyncram_inst.mem_data);
    
    CPU_RESET_n       = 1'b0;
    SW = 10'b0000000000;
    KEY = 4'b1111;
    UART_RX = 1'b0;

    #90ns;
    CPU_RESET_n = 1'b1;

    #500ns;
    SW = 10'b1111111111;

    #1us;
    run_sim = 1'b0;

end

endmodule