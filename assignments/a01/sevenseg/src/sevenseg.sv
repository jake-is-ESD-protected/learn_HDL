/*
*****************************************************************************************
project name:       sevenseg
auth:               Jakob Tschavoll
date:               9.10.21
brief:              system verilog implementation 7 segment number display
version:            V1.0
*****************************************************************************************
*/

/* "chip" shall contain 18 pins:
*   4 inputs   
*   7 outputs
*   7 negated outputs
*/
module sevenseg
(
    input logic [3:0] bin,
    output logic [6:0] hex,
    output logic [6:0] hexn
);

// LUT
always_comb begin : description_sevenseg

    case (bin)
        4'b0000 :   begin
                        hex = 7'b0111111;   // 0
                        hexn = ~hex;
                    end
        4'b0001 :   begin
                        hex = 7'b0000110;   // 1
                        hexn = ~hex;
                    end
        4'b0010 :   begin
                        hex = 7'b1011011;   // 2
                        hexn = ~hex;
                    end    
        4'b0011 :   begin
                        hex = 7'b1001111;   // 3
                        hexn = ~hex;
                    end    
        4'b0100 :   begin
                        hex = 7'b1100110;   // 4
                        hexn = ~hex;
                    end    
        4'b0101 :   begin
                        hex = 7'b1101101;   // 5
                        hexn = ~hex;
                    end    
        4'b0110 :   begin 
                        hex = 7'b1111101;   // 6
                        hexn = ~hex;
                    end    
        4'b0111 :   begin
                        hex = 7'b0000111;   // 7
                        hexn = ~hex;
                    end    
        4'b1000 :   begin
                        hex = 7'b1111111;   // 8
                        hexn = ~hex;
                    end    
        4'b1001 :   begin
                        hex = 7'b1101111;   // 9
                        hexn = ~hex;
                    end    
        4'b1010 :   begin
                        hex = 7'b1110111;   // 10 (A)
                        hexn = ~hex;
                    end    
        4'b1011 :   begin
                        hex = 7'b1111100;   // 11 (B)
                        hexn = ~hex;
                    end    
        4'b1100 :   begin
                        hex = 7'b0111001;   // 12 (C)
                        hexn = ~hex;
                    end  
        4'b1101 :   begin
                        hex = 7'b1011110;   // 13 (D)
                        hexn = ~hex;
                    end
        4'b1110 :   begin
                        hex = 7'b1111001;   // 14 (E)
                        hexn = ~hex;
                    end    
        4'b1111 :   begin
                        hex = 7'b1110001;   // 15 (F)
                        hexn = ~hex;
                    end    
    endcase
    
end

endmodule