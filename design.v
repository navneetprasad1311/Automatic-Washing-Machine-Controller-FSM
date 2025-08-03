module AWMC(input clk,  
                  reset,
                  start,
                  pause,
            output reg [2:0] stage,
            output reg done);

    parameter TIMER = 2'd3;

    reg [2:0] prev_state;
    reg [1:0] count;
    reg running;
    reg paused;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            stage <= 3'b111;
            prev_state <= 3'b111;
            running <= 1'b0;
            paused <= 1'b0;
            count <= 2'b00;
            done <= 1'b0;
        end
        else begin
            if(pause) begin
                running <= 1'b0;
                if(stage != 3'b111) 
                    prev_state <= stage;
                stage <= 3'b111;
                paused <= 1'b1;
            end
            else if(start | (running | paused) & !done) begin
                running <= 1'b1;
                if(paused) begin
                    stage <= prev_state;
                    paused <= 1'b0;
                end
                if(count < TIMER) begin
                    count <= count + 1;
                end
                else begin
                    if (stage == 3'b100) begin
                        done <= 1'b1;
                        running <= 1'b0;
                        stage <= 3'b111;
                        count <= 2'b00;
                    end
                    else begin
                        stage <= stage + 1;
                        done <= 1'b0;
                        count <= 2'b00;
                    end
                end
            end 
        end
    end
endmodule