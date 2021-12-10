/*------------------------------
Projekt: Stop Watch
Purpose: Translate binary number to seven segment display
Author: ANM
Version: v00, 26.09.2017
--------------------------------*/



module sevenseg(
    input   logic   [3:0]               bin,
    output  logic   [6:0]               hex,
    output  logic   [6:0]               hexn
);

always_comb begin
    case (bin)
    //                gfe_dcba
    4'd0 :   hex = 7'b011_1111;
    4'd1 :   hex = 7'b000_0110;
    4'd2 :   hex = 7'b101_1011;
    4'd3 :   hex = 7'b100_1111;
    4'd4 :   hex = 7'b110_0110;
    4'd5 :   hex = 7'b110_1101;
    4'd6 :   hex = 7'b111_1101;
    4'd7 :   hex = 7'b000_0111;
    4'd8 :   hex = 7'b111_1111;
    4'd9 :   hex = 7'b110_1111;
    4'd10:   hex = 7'b111_1011; //A
    4'd11:   hex = 7'b111_1100; //b
    4'd12:   hex = 7'b011_1001; //C
    4'd13:   hex = 7'b101_1110; //d
    4'd14:   hex = 7'b111_1001; //E
    4'd15:   hex = 7'b111_0001; //F
    default: hex = 7'b000_0000;    // default is required to ensure combinatorial synthesis
    endcase
end

assign hexn = ~hex;     // bit wise inversion for active low displays

endmodule