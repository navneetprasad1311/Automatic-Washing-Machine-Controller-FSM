`include "design.v"

module AWMC_tb();
    reg clk, reset, start, pause;
    wire [2:0] stage;
    wire done;

    AWMC uut(.clk(clk),.reset(reset),.start(start),.pause(pause),.stage(stage),.done(done));

    initial begin
        reset = 1'b0;
        #1
        reset = 1'b1;
        #1
        reset = 1'b0;
        clk = 1'b0;

        forever #5 clk = ~clk;
    end

    initial begin
        start = 1'b0;
        pause = 1'b0;

        $dumpfile("tb.vcd");
        $dumpvars(0,AWMC_tb);

        #10
        start = 1'b1;
        #20
        start = 1'b0;
        #100
        pause = 1'b1;
        #105
        pause = 1'b0;
        #110
        start = 1'b1;
        #120 
        start = 1'b0;
        #135
        reset = 1'b1;
        #150
        reset = 1'b0;
        #155
        start = 1'b1;
        #160
        start = 1'b0;
        #165
        pause = 1'b1;
        #170
        pause = 1'b0;
        #200
        reset = 1'b1;
        #205
        reset = 1'b0;  

        #300 $finish;

    end

endmodule

