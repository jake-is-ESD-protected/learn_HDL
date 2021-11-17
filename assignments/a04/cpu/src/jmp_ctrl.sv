/*
*****************************************************************************************
project name:       jmp_ctrl
auth:               Jakob Tschavoll
date:               15.11.21
brief:              system verilog implementation of a cpu jump control
version:            V1.0
*****************************************************************************************
*/

`define HIGH    1'b1
`define LOW     1'b0

module jmp_ctrl
(
    input logic cmd_j1;
    input logic cmd_j2;
    input logic cmd_j3;
    input logic alu_zr;
    input logic alu_ng;

    output logic pc_load;
    output logic pc_inc;
);

logic [2:0]cmd_j;
assign cmd_j = {cmd_j1, cmd_j2, cmd_j3};

// always_comb begin
//     if(cmd_j == 3'b000) begin
//         pc_load = `LOW;
//         pc_inc = `HIGH;
//     end
//     else begin
//         pc_load = `HIGH;
//         pc_inc = `LOW;
//     end
// end

always_comb begin
    
    // covers null
    pc_load = `LOW;
    pc_inc = `HIGH;

    case(cmd_j)
        // covers JGT
        3'b001: begin
            if(~alu_ng && ~alu_zr) begin
                pc_load = `HIGH;
                pc_inc  `LOW;
            end
        end
        // covers JEQ
        3'b010: begin
            if(alu_zr) begin
                pc_load = `HIGH;
                pc_inc  `LOW;
            end
            
        end
        // covers JGE
        3'b011: begin
            if(~alu_ng || alu_zr) begin
                pc_load = `HIGH;
                pc_inc  `LOW;
            end
        end
        // covers JLT
        3'b100: begin
            if(alu_ng) begin
                pc_load = `HIGH;
                pc_inc  `LOW;
            end
        end
        // covers JNE
        3'b101: begin
            if(~alu_zr) begin
                pc_load = `HIGH;
                pc_inc  `LOW;
            end
        end
        // covers JLE
        3'b110: begin
            if(alu_ng || alu_zr) begin
                pc_load = `HIGH;
                pc_inc  `LOW;
            end
        end
        // covers JMP
        3'b111: begin
            pc_load = `HIGH;
            pc_inc  `LOW;
        end

end

endmodule