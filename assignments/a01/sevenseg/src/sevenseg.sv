/*
*****************************************************************************************
project name:       sevenseg
auth:               Jakob Tschavoll
date:               9.10.21
brief:              system verilog implementation 7 segment number display
version:            V1.0
*****************************************************************************************
*/

module sevenseg
(
    input logic [3:0] bBus;

    output logic [6:0] hexBus;
    output logic [6:0] nhexBus;
);

always_comb begin : description_sevenseg

    hexBus = 7'b1111110 // in case of 0 and undefined display 0
    case (bBus)
        4'b0001 : hexBus = 7'b0110000   // 1
        4'b0010 : hexBus = 7'b1101101   // 2
        4'b0011 : hexBus = 7'b1111001   // 3
        4'b0100 : hexBus = 7'b0110011   // 4
        4'b0101 : hexBus = 7'b1011011   // 5
        4'b0110 : hexBus = 7'b1011111   // 6
        4'b0111 : hexBus = 7'b1110000   // 7
        4'b1000 : hexBus = 7'b1111111   // 8
        4'b1001 : hexBus = 7'b1111011   // 9
        4'b1010 : hexBus = 7'b1110111   // 10 (A)
        4'b1011 : hexBus = 7'b0011111   // 11 (B)
        4'b1100 : hexBus = 7'b1001110   // 12 (C)
        4'b1101 : hexBus = 7'b0111101   // 13 (D)
        4'b1110 : hexBus = 7'b1001111   // 14 (E)
        4'b1111 : hexBus = 7'b1000111   // 15 (F)
     
    endcase
    
end

endmodule