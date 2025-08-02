module AWMC(input clk,  
                  reset,
                  start,
                  pause,
            output reg [2:0] stage,
            output reg done);

    reg [1:0] timer = 2'd3;
    reg [1:0] count = 1'b0;
    reg continue = 1'b0;
    reg w = 1'b0;

    reg [2:0] prev_stage;

    assign state = stage;

    always @(posedge clk or negedge reset) begin 
        
        if (!reset | !pause) begin 
            
            if(start | continue) begin
              if(w) begin  
                if(count != timer) begin
                    stage <= stage;
                    count <= count + 1;
                    continue <= 1'b1;
                end
                else begin
                    if(stage == 000) begin
                        stage <= 111;
                        done <= 1'b1;
                        continue = 1'b0;
                    end
                    else begin
                        stage <= stage + 1;
                        continue <= 1'b1;
                    end
                end
              end
              else begin
                stage <= prev_stage;
                if(count != timer) begin
                    stage <= stage;
                    count <= count + 1;
                    continue <= 1'b1;
                end
                else begin
                    if(stage == 000) begin
                        stage <= 111;
                        done <= 1'b1;
                        continue <= 1'b0;
                    end
                    else begin
                        stage <= stage + 1;
                        continue <= 1'b1;
                    end
                end
              end

            end
            else
                stage <= 111;
        end
        else if(pause) begin
            prev_stage <= stage;
            stage <= 111;
            w <= 1'b1;
        end
        else if(reset) begin
            stage <= 111;
            continue <= 1'b0;
        end
    end

endmodule

