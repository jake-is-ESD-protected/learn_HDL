/*
*****************************************************************************************
project name:       ram16k_verilog
auth:               Jakob Tschavoll
date:               03.11.21
brief:              system verilog testbench for RAM
version:            V1.0
*****************************************************************************************
*/

module tb_ram16k_verilog ();

logic aclr;
logic [13:0] address;
logic clock;
logic [15:0] data;
logic wren;
logic [15:0] q;

ram16k_verilog dut (.*);

int error_cnt = 0;
logic run_sim = 1'b1;

initial begin
    clock = 1'b0;
    while(run_sim)begin
        #10ns;
        clock = ~clock;
    end
end

initial begin
    
    $display("\n#################\nStarting 16k RAM\n#################\n");
    
    $display("Set all data to 0");
    wren = 1'b1;

    for(address = 14'b0; address < ((1 << 14)-1); address += 1) begin
        data = 16'd0;
        #80ns;
        //$display("q = %d", q);
        assert (q == 16'd0000) 
        else begin
            $display("Value not stored correctly. q = %d", q);
            error_cnt += error_cnt;
        end
    end

    $display("Set all data to 1 (bitwise)");

    for(address = 14'b0; address < ((1 << 14)-1); address += 1) begin
        data = 16'hffff;
        #80ns;
        //$display("q = %d", q);
        assert (q == 16'hffff) 
        else begin
            $display("Value not stored correctly. q = %d", q);
            error_cnt += error_cnt;
        end
    end

    $display("Set all data to the value of their adress");

    for(address = 14'b0; address < ((1 << 14)-1); address += 1) begin
        data = address;
        #80ns;
        //$display("q = %d", address);
        assert (q == address) 
        else begin
            $display("Value not stored correctly. q = %d", q);
            error_cnt += error_cnt;
        end
    end
    if(error_cnt > 0) begin
        $display("Total error-count: %d\n", error_cnt);
    end
    else begin
        $display("\nSelf check clean, leaving...");
    end
    run_sim = 1'b0;
end

endmodule