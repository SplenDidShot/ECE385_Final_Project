///////////module to draw the background///////

module bgCreate(
		input [9:0]DrawX,
		input [9:0]DrawY,
		output [18:0] bg_read_address,
		output [1:0] is_bg

);
//////////parameter for game background///////
parameter [9:0] map_x_size = 320;
parameter [9:0] map_y_size = 480;
parameter [9:0] map_x_pos = 0;
parameter [9:0] map_y_pos = 0;
//////////parameter for scoreboard/////////
parameter [9:0] score_x_size = 320;
parameter [9:0] score_y_size = 240;
parameter [9:0] score_1_x_pos = 320;
parameter [9:0] score_1_y_pos = 0;
parameter [9:0] score_2_x_pos = 320;
parameter [9:0] score_2_y_pos = 240;

always_comb
begin
		if(DrawX - map_x_pos >= 0 && DrawX - map_x_pos <= map_x_size && DrawY - map_y_pos >= 0 && DrawY - map_y_pos <= map_y_size)
		begin 
			is_bg = 1;
			bg_read_address = (DrawX-map_x_pos) + (DrawY-map_y_pos)*map_x_size;
		end
		else if(DrawX - score_1_x_pos >= 0 && DrawX - score_1_x_pos <= score_x_size && DrawY - score_1_y_pos >= 0 && DrawY - score_1_y_pos <= score_y_size)
		begin 
			is_bg = 2;
			bg_read_address = (DrawX-score_1_x_pos) + (DrawY - score_1_y_pos)*score_x_size;
		end
		else if(DrawX - score_2_x_pos >= 0 && DrawX - score_2_x_pos <= score_x_size && DrawY - score_2_y_pos >= 0 && DrawY - score_2_y_pos <= score_y_size)
		begin 
			is_bg = 3;
			bg_read_address = (DrawX-score_2_x_pos) + (DrawY - score_2_y_pos)*score_x_size;
		end
		else 
		begin
			is_bg = 0;
			bg_read_address = 0;
		end

end

endmodule
