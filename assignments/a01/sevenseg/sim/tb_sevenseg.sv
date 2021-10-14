/*
*****************************************************************************************
project name:       tb_sevenseg
auth:               Jakob Tschavoll
date:               14.10.21
brief:              testbench for sevenseg implementation
version:            V1.0
*****************************************************************************************
*/

module tb_sevenseg 
(
    // no I/O because this is a testbench
);

// create virtual I/O
logic [3:0] bin;
logic [6:0] hex;
logic [6:0] hexn;

//match all names because they share names
sevenseg dut
(
    .*
);

//start testbench
initial begin
    
    $display("***********************");
    $display("Benching sevenseg...");
    $display("***********************");

    // start value for inputs
    bin = 0;

    #100ns;
    
    // to stimulate all 16 possible digits, an integer is counted up 16 times
    for(int i = 0; i < 16; i+=1) begin
        
        bin = i;

        $display("%d --> %x != %x", bin, hex, hexn);
        #100ns;

    end

    $display("***********************");
    $display("sevenseg benching end.");
    $display("***********************");

end

endmodule