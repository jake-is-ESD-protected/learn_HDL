/*
*****************************************************************************************
project name:       maj_vote
auth:               Jakob Tschavoll
date:               7.10.21
brief:              testbench for maj_vote implementation
version:            V1.0
*****************************************************************************************
*/

module tb_maj_vote 
(
    // no I/O because this is a testbench
);

/* 
    (1) create wiring for DUT               (digital pcb)
    (2) create an instance of the DUT       (digital chip to pcb)
    (3) stimulate DUT                       (apply function generator)
    (4) observe output                      (connect osci)
*/

// (1)
logic x2;
logic x1;
logic x0;
//logic y;
logic ycase;

// (2)
maj_vote dut
(
//  I/O     wire    
    .x0     (x0),
    .x1     (x1),
    .x2     (x2),
    //.y      (y),
    .ycase  (ycase)
);
// use maj_vote dut(.*); to match all equal names, e.g. ".x0 -> (x0)"

// (3)
initial begin // start at time = 0 and run line by line 
    
    $display("***********************");
    $display("Benching maj_vote...");
    $display("***********************");

    x2 = 1'b0;
    x1 = 1'b0;
    x0 = 1'b0;
    // only inputs can be stimulated

    #100ns; // advance in time

    x2 = 1'b1;
    x1 = 1'b1;
    x0 = 1'b0;

    #100ns;
    
    for(int i = 0; i < 8; i+=1) begin
        
        x0 = i[0]; // i is an integer and this way the single bits can be accessed
        x1 = i[1];
        x2 = i[2];
        $display("%d | %d | %d --> %d", x2, x1, x0, ycase);
        #100ns;

    end

    $display("***********************");
    $display("maj_vote benching end.");
    $display("***********************");

end
    
endmodule