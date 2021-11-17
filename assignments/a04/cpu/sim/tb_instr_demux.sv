/*
*****************************************************************************************
project name:       tb_instr_demux
auth:               Jakob Tschavoll
date:               12.11.21
brief:              system verilog implementation of a demuxer TB
version:            V1.0
*****************************************************************************************
*/

module tb_instr_demux();

localparam DW = 16;

logic [DW-1:0] instr;

logic instr_type;
logic [DW-1:0]instr_v;
logic cmd_a;
logic cmd_c1;
logic cmd_c2;
logic cmd_c3;
logic cmd_c4;
logic cmd_c5;
logic cmd_c6;
logic cmd_d1;
logic cmd_d2;
logic cmd_d3;
logic cmd_j1;
logic cmd_j2;
logic cmd_j3;

`define SHIFT_D 2'd3
`define SHIFT_C 3'd6
`define SHIFT_A 4'd12
`define SHIFT_PAD 4'd13

int n_err = 0;

// helper busses
logic [DW-1:0] cmd_a_helper;
logic [DW-1:0] cmd_c;
logic [DW-1:0] cmd_d;
logic [DW-1:0] cmd_j;
logic [DW-1:0] pad;

instr_demux #(.DW (DW)) dut (
    .*
);

initial begin

    $display("******************\nStarting demuxer-testbench:\n******************\n");
    
    // Load 0x7FFF to A
    $display("directly load instr with 0x7FFF:");
    instr = 16'h7fff;
    #100ns
    if(instr_v[DW-1] == 1'b0) begin
        $display("MSB checked: %b", instr_v[DW-1]);
    end
    else begin
        $display("MSB not set to 0!");
        n_err += n_err;
    end
    if
    ( 
        (cmd_a == 0)  && 
        (cmd_c1 == 0) && 
        (cmd_c2 == 0) && 
        (cmd_c3 == 0) && 
        (cmd_c4 == 0) && 
        (cmd_c5 == 0) && 
        (cmd_c6 == 0) && 
        (cmd_d1 == 0) && 
        (cmd_d2 == 0) && 
        (cmd_d3 == 0) && 
        (cmd_j1 == 0) && 
        (cmd_j2 == 0) && 
        (cmd_j3 == 0)
    ) begin
        $display("single bit outputs checked: %b%b%b%b%b%b%b%b%b%b%b%b%b", 
        cmd_a, cmd_c1, cmd_c2, cmd_c3, cmd_c4, cmd_c5, cmd_c6, cmd_d1, cmd_d2, cmd_d3, cmd_j1, cmd_j2, cmd_j3);
    end
    else begin
        $display("Error in single bit outputs!");
        n_err += n_err;
    end

    // Load 0x0000 to A
    $display("\ndirectly load instr with 0x0000:");
    instr = 16'h0000;
    #100ns
    if(instr_v[DW-1] == 1'b0) begin
        $display("MSB checked: %b", instr_v[DW-1]);
    end
    else begin
        $display("MSB not set to 0!");
        n_err += n_err;
    end
    if
    ( 
        (cmd_a == 0)  && 
        (cmd_c1 == 0) && 
        (cmd_c2 == 0) && 
        (cmd_c3 == 0) && 
        (cmd_c4 == 0) && 
        (cmd_c5 == 0) && 
        (cmd_c6 == 0) && 
        (cmd_d1 == 0) && 
        (cmd_d2 == 0) && 
        (cmd_d3 == 0) && 
        (cmd_j1 == 0) && 
        (cmd_j2 == 0) && 
        (cmd_j3 == 0)
    ) begin
        $display("single bit outputs checked: %b%b%b%b%b%b%b%b%b%b%b%b%b", 
        cmd_a, cmd_c1, cmd_c2, cmd_c3, cmd_c4, cmd_c5, cmd_c6, cmd_d1, cmd_d2, cmd_d3, cmd_j1, cmd_j2, cmd_j3);
    end
    else begin
        $display("Error in single bit outputs!");
        n_err += n_err;
    end

    // set instructions which don't change for all tests
    pad =           3'b111      << `SHIFT_PAD;      // stays 1 in every simulation case
    cmd_a_helper =  1'b0        << `SHIFT_A;        // stays 0 in every simulation case
    cmd_j =         '0;                             // stays 0 in every simulation case    

    // Set D to 1
    $display("\nSet D to 1:");
    cmd_c =         6'b111111   << `SHIFT_C;
    cmd_d =         3'b010      << `SHIFT_D;
    instr = pad | cmd_a | cmd_c | cmd_d | cmd_j;    // fill all values into instr
    #100ns
    if(instr_v[DW-1] == 1'b0) begin
        $display("MSB checked: %b", instr_v[DW-1]);
    end
    else begin
        $display("MSB not set to 0!");
        n_err += n_err;
    end
    if
    ( 
        (cmd_a == 0)  && 
        (cmd_c1 == 1) && 
        (cmd_c2 == 1) && 
        (cmd_c3 == 1) && 
        (cmd_c4 == 1) && 
        (cmd_c5 == 1) && 
        (cmd_c6 == 1) && 
        (cmd_d1 == 0) && 
        (cmd_d2 == 1) && 
        (cmd_d3 == 0) && 
        (cmd_j1 == 0) && 
        (cmd_j2 == 0) && 
        (cmd_j3 == 0)
    ) begin
        $display("single bit outputs checked: %b%b%b%b%b%b%b%b%b%b%b%b%b", 
        cmd_a, cmd_c1, cmd_c2, cmd_c3, cmd_c4, cmd_c5, cmd_c6, cmd_d1, cmd_d2, cmd_d3, cmd_j1, cmd_j2, cmd_j3);
    end
    else begin
        $display("Error in single bit outputs!");
        n_err += n_err;
    end

    // set D to D + A
    $display("\nset D to D + A:");
    cmd_c =         6'b000010   << `SHIFT_C;
    cmd_d =         3'b010      << `SHIFT_D;
    instr = pad | cmd_a | cmd_c | cmd_d | cmd_j;
    #100ns
    if(instr_v[DW-1] == 1'b0) begin
        $display("MSB checked: %b", instr_v[DW-1]);
    end
    else begin
        $display("MSB not set to 0!");
        n_err += n_err;
    end
    if
    ( 
        (cmd_a == 0)  && 
        (cmd_c1 == 0) && 
        (cmd_c2 == 0) && 
        (cmd_c3 == 0) && 
        (cmd_c4 == 0) && 
        (cmd_c5 == 1) && 
        (cmd_c6 == 0) && 
        (cmd_d1 == 0) && 
        (cmd_d2 == 1) && 
        (cmd_d3 == 0) && 
        (cmd_j1 == 0) && 
        (cmd_j2 == 0) && 
        (cmd_j3 == 0)
    ) begin
        $display("single bit outputs checked: %b%b%b%b%b%b%b%b%b%b%b%b%b", 
        cmd_a, cmd_c1, cmd_c2, cmd_c3, cmd_c4, cmd_c5, cmd_c6, cmd_d1, cmd_d2, cmd_d3, cmd_j1, cmd_j2, cmd_j3);
    end
    else begin
        $display("Error in single bit outputs!");
        n_err += n_err;
    end

    // set memory to A + 1
    $display("\nset memory to A + 1:");
    cmd_c =         6'b110111   << `SHIFT_C;
    cmd_d =         3'b001      << `SHIFT_D;
    instr = pad | cmd_a | cmd_c | cmd_d | cmd_j;
    #100ns;
    if(instr_v[DW-1] == 1'b0) begin
        $display("MSB checked: %b", instr_v[DW-1]);
    end
    else begin
        $display("MSB not set to 0!");
        n_err += n_err;
    end
    if
    ( 
        (cmd_a == 0)  && 
        (cmd_c1 == 1) && 
        (cmd_c2 == 1) && 
        (cmd_c3 == 0) && 
        (cmd_c4 == 1) && 
        (cmd_c5 == 1) && 
        (cmd_c6 == 1) && 
        (cmd_d1 == 0) && 
        (cmd_d2 == 0) && 
        (cmd_d3 == 1) && 
        (cmd_j1 == 0) && 
        (cmd_j2 == 0) && 
        (cmd_j3 == 0)
    ) begin
        $display("single bit outputs checked: %b%b%b%b%b%b%b%b%b%b%b%b%b", 
        cmd_a, cmd_c1, cmd_c2, cmd_c3, cmd_c4, cmd_c5, cmd_c6, cmd_d1, cmd_d2, cmd_d3, cmd_j1, cmd_j2, cmd_j3);
    end
    else begin
        $display("Error in single bit outputs!");
        n_err += n_err;
    end

    if(n_err > 0) begin
        $display("\nTestbench failed: %d errors.", n_err);
    end
    else begin
        $display("\nTestbench success.");
    end

end

endmodule