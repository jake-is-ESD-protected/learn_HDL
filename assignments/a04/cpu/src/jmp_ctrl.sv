/*
*****************************************************************************************
project name:       jmp_ctrl
auth:               Jakob Tschavoll
date:               15.11.21
brief:              system verilog implementation of a cpu jump control
version:            V1.0
*****************************************************************************************
*/

<<<<<<< HEAD
=======
`define HIGH    (1'b1)
`define LOW     (1'b0)

>>>>>>> 9637dd6dea5d49e49c920a177d42ae12a961f6a1
module jmp_ctrl
(
    input logic cmd_j1,
    input logic cmd_j2,
    input logic cmd_j3,
    input logic alu_zr,
    input logic alu_ng,

    output logic pc_load,
    output logic pc_inc
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
    pc_load = 1'b0;
    pc_inc = 1'b1;

    case(cmd_j)
        // covers JGT
        3'b001: begin
            if((~alu_ng) && (~alu_zr)) begin
<<<<<<< HEAD
                pc_load = 1'b1;
                pc_inc = 1'b0;
=======
                pc_load = `HIGH;
                pc_inc = `LOW;
>>>>>>> 9637dd6dea5d49e49c920a177d42ae12a961f6a1
            end
        end
        // covers JEQ
        3'b010: begin
            if(alu_zr) begin
<<<<<<< HEAD
                pc_load = 1'b1;
                pc_inc = 1'b0;
=======
                pc_load = `HIGH;
                pc_inc = `LOW;
>>>>>>> 9637dd6dea5d49e49c920a177d42ae12a961f6a1
            end
            
        end
        // covers JGE
        3'b011: begin
            if((~alu_ng) || alu_zr) begin
<<<<<<< HEAD
                pc_load = 1'b1;
                pc_inc = 1'b0;
=======
                pc_load = `HIGH;
                pc_inc = `LOW;
>>>>>>> 9637dd6dea5d49e49c920a177d42ae12a961f6a1
            end
        end
        // covers JLT
        3'b100: begin
            if(alu_ng) begin
<<<<<<< HEAD
                pc_load = 1'b1;
                pc_inc = 1'b0;
=======
                pc_load = `HIGH;
                pc_inc = `LOW;
>>>>>>> 9637dd6dea5d49e49c920a177d42ae12a961f6a1
            end
        end
        // covers JNE
        3'b101: begin
            if(~alu_zr) begin
<<<<<<< HEAD
                pc_load = 1'b1;
                pc_inc = 1'b0;
=======
                pc_load = `HIGH;
                pc_inc = `LOW;
>>>>>>> 9637dd6dea5d49e49c920a177d42ae12a961f6a1
            end
        end
        // covers JLE
        3'b110: begin
            if(alu_ng || alu_zr) begin
<<<<<<< HEAD
                pc_load = 1'b1;
                pc_inc = 1'b0;
=======
                pc_load = `HIGH;
                pc_inc = `LOW;
>>>>>>> 9637dd6dea5d49e49c920a177d42ae12a961f6a1
            end
        end
        // covers JMP
        3'b111: begin
<<<<<<< HEAD
            pc_load = 1'b1;
            pc_inc = 1'b0;
=======
            pc_load = `HIGH;
            pc_inc = `LOW;
>>>>>>> 9637dd6dea5d49e49c920a177d42ae12a961f6a1
        end
    endcase
end

endmodule