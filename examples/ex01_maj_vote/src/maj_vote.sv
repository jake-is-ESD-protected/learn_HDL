/*
*****************************************************************************************
project name:       maj_vote
auth:               Jakob Tschavoll
date:               7.10.21
brief:              system verilog implementation of a 3 input majority voter as example
version:            V1.0
*****************************************************************************************
*/

module maj_vote 
(
    input logic x2,
    input logic x1,
    input logic x0,

    // output logic y,
    output logic ycase
);

// "human" implementation (human did the hard work of calculation prior)
// assign y = (x2 & x1) | (x2 & x0) | (x1 & x0);

// & - Quicktips:
// 4'b1011 & 4'b1001 = 4'b1001
// 4'b1011 && 4'b1001 = 1'b1
// &(4'b0110) = 1'b1

// combine all inputs to a 3bit-value
logic [2:0] xbus; 
assign xbus = {x2, x1, x0};

// high-level abstraction
always_comb begin : description_maj_vote

    // ycase = 1'b0; // this is better than default
    case (xbus)
        3'b011 : ycase = 1'b1;
        3'b101 : ycase = 1'b1;
        3'b110 : ycase = 1'b1;
        3'b111 : ycase = 1'b1;
        default: ycase = 1'b0;
    endcase
    
end

endmodule