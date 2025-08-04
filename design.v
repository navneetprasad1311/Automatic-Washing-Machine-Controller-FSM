module AWMC(input clk,  
                  reset,
                  start,
                  pause,
            output reg [2:0] stage,
            output reg done);

    parameter IDLE  = 3'b111,
              FILL  = 3'b000,
              WASH  = 3'b001,
              RINSE = 3'b010,
              SPIN  = 3'b011,
              STOP  = 3'b100,
              TIMER = 4'd10,
              VALVE_DURATION = 2'd2;


    reg [2:0] prev_state;
    reg [3:0] count;
    reg input_valve;
    reg output_drain;
    reg running;
    reg paused;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 2'b00;
            case (stage)
                WASH : begin
                    if(input_valve == 1'b1) begin
                        input_valve <= 1'b0;
                        if(count < VALVE_DURATION) begin
                                output_drain <= 1'b1;
                                count++;
                        end
                        else begin
                                output_drain <= 1'b0;
                                count <= 2'b00;
                        end
                    end
                    else begin
                        input_valve <= 1'b0;
                        output_drain <= 1'b0;
                    end
                end
                RINSE : begin
                    if(input_valve == 1'b1 || output_drain == 1'b1) begin
                        input_valve <= 1'b0;
                        if(count < VALVE_DURATION) begin
                                output_drain <= 1'b1;
                                count++;
                        end
                        else begin
                                output_drain <= 1'b0;
                                count <= 2'b00;
                        end
                    end
                end
                SPIN : begin
                    if(output_drain == 1'b1) begin
                        if(count < VALVE_DURATION) begin
                                output_drain <= 1'b1;
                                count++;
                        end
                        else begin
                                output_drain <= 1'b0;
                                count <= 2'b00;
                        end
                    end
                end
                default : begin
                    input_valve <= 1'b0;
                    output_drain <= 1'b0;
                end
            endcase

        stage <= IDLE;
        prev_state <= IDLE;
        running <= 1'b0;
        paused <= 1'b0;
        done <= 1'b0;
            
        end
        else begin
            if(pause) begin
                running <= 1'b0;
                if(stage != IDLE) 
                    prev_state <= stage;
                stage <= IDLE;
                paused <= 1'b1;
                input_valve <= 1'b0;
                output_drain <= 1'b0;
            end
            else if(start || ((running || paused) && !done)) begin
                running <= 1'b1;
                if(paused) begin
                    stage <= prev_state;
                    paused <= 1'b0;
                end

                case (stage)
                    FILL: begin
                          input_valve <= 1'b0;
                          output_drain <= 1'b0;
                    end
                    WASH: begin
                        output_drain <= 1'b0;
                        if(count < VALVE_DURATION)
                            input_valve <= 1'b1;
                        else
                            input_valve <= 1'b0;       
                    end
                    RINSE: begin
                            case (count) 
                                4'd0: begin input_valve <= 1'b0 ; output_drain <= 1'b1; end
                                4'd2: begin input_valve <= 1'b1 ; output_drain <= 1'b0; end
                                4'd4: begin input_valve <= 1'b0 ; output_drain <= 1'b1; end
                                4'd6: begin input_valve <= 1'b1 ; output_drain <= 1'b0; end
                                4'd8: begin input_valve <= 1'b0 ; output_drain <= 1'b1; end
                                4'd10:begin input_valve <= 1'b0 ; output_drain <= 1'b1; end
                            endcase
                    end
                    SPIN: begin
                        input_valve <= 1'b0;
                        if(count < VALVE_DURATION)
                            output_drain <= 1'b1;
                        else
                            output_drain <= 1'b0;
                    end
                endcase                
                if(count < TIMER) begin
                    count <= count + 1;
                end
                else begin
                    if (stage == STOP) begin
                        done <= 1'b1;
                        running <= 1'b0;
                        stage <= IDLE;
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
