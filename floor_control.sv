//file to control floors in the VGA

module  floor ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
					input     [3:0]score1, score0,
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates	
					output [9:0]   floor_x[5],
					output [9:0]   floor_y[5]

              );
				  

	 parameter [9:0] floor_step = 1;
    parameter [9:0] floor_y_min=0;       // Topmost floor on the Y axis
    parameter [9:0] floor_y_max=479;     // Bottommost floor on the Y axis
    parameter [9:0] floor_x_size=90;  //floor size parameter
    parameter [9:0] floor_y_size=20;
	 
	 logic [9:0] floor_x_pos[5];
	 logic [9:0] floor_y_pos[5];
	 logic [9:0] floor_x_pos_in[5];
	 logic [9:0] floor_y_pos_in[5];

    logic frame_clk_delayed;
    logic frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
    end
    assign frame_clk_rising_edge = (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);	 
	 
	 always_ff @ (posedge Clk)
    begin
			if (Reset)
				begin
					floor_x_pos[0] <= 60;
					floor_x_pos[1] <= 80;
					floor_x_pos[2] <= 50;
					floor_x_pos[3] <= 190;
					floor_x_pos[4] <= 140;					
					floor_y_pos[0] <= 30;
					floor_y_pos[1] <= 140;
					floor_y_pos[2] <= 250;
					floor_y_pos[3] <= 370;
					floor_y_pos[4] <= 450;
				end
			else if (frame_clk_rising_edge)        // Update only at rising edge of frame clock
				begin
					floor_x_pos <= floor_x_pos_in;
					floor_y_pos <= floor_y_pos_in;
				end
				//default keep register value
	 end
	 
	 always_comb
	 begin
			floor_y_pos_in[0] = floor_y_pos[0] - floor_step;
			floor_y_pos_in[1] = floor_y_pos[1] - floor_step;
			floor_y_pos_in[2] = floor_y_pos[2] - floor_step;
			floor_y_pos_in[3] = floor_y_pos[3] - floor_step;
			floor_y_pos_in[4] = floor_y_pos[4] - floor_step;
			
			floor_x_pos_in[0] = floor_x_pos[0];
			floor_x_pos_in[1] = floor_x_pos[1];
			floor_x_pos_in[2] = floor_x_pos[2];
			floor_x_pos_in[3] = floor_x_pos[3];
			floor_x_pos_in[4] = floor_x_pos[4];
			//check if floor meets bottom
			if(floor_y_pos[0] <= floor_y_min)
			begin
				floor_y_pos_in[0] = floor_y_max - floor_y_size;
				floor_x_pos_in[0] = score1*12 + score0*13;
			end
			if(floor_y_pos[1] <= floor_y_min)
			begin
				floor_y_pos_in[1] = floor_y_max - floor_y_size;
				floor_x_pos_in[1] = score1*8 + score0*17;
			end
			if(floor_y_pos[2] <= floor_y_min)
			begin
				floor_y_pos_in[2] = floor_y_max - floor_y_size;
				floor_x_pos_in[2] = score1*4 + score0*21;
			end
			if(floor_y_pos[3] <= floor_y_min)
			begin
				floor_y_pos_in[3] = floor_y_max - floor_y_size;
				floor_x_pos_in[3] = score1*16 + score0*9;
			end
			if(floor_y_pos[4] <= floor_y_min)
			begin
				floor_y_pos_in[4] = floor_y_max - floor_y_size;
				floor_x_pos_in[4] = score1 * 20 + score0* 5;
			end
			
		//pass parameter to output	
			floor_x = floor_x_pos;
			floor_y = floor_y_pos;
			
	 end

endmodule
