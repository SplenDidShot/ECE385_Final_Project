module game_start (input [9:0] DrawX, DrawY,
						input [1:0] game_state,
						//output [18:0] bg_read_address,
						output is_starting,
						output [4:0] starting_idx,
						output [18:0] starting_read_address

						);


parameter [9:0] n_ns_x = 200;
parameter [9:0] n_ns_y = 165;
parameter [9:0] s_ns_x = 230;
parameter [9:0] s_ns_y = 165;
parameter [9:0] s_shaft_x = 290;
parameter [9:0] s_shaft_y = 165;
parameter [9:0] h_shaft_x = 320;
parameter [9:0] h_shaft_y = 165;
parameter [9:0] a_shaft_x = 350;
parameter [9:0] a_shaft_y = 165;
parameter [9:0] f_shaft_x = 380;
parameter [9:0] f_shaft_y = 165;
parameter [9:0] t_shaft_x = 410;
parameter [9:0] t_shaft_y = 165;

parameter [9:0] p1_x = 260;
parameter [9:0] p1_y = 270;
parameter [9:0] p2_x = 350;
parameter [9:0] p2_y = 270;

parameter [9:0] char_x_size = 30;
parameter [9:0] char_y_size = 45;
						
always_comb
begin
		if(game_state == 2'b00 && DrawX - n_ns_x >= 0 && DrawX - n_ns_x <= char_x_size && DrawY - n_ns_y >= 0 && DrawY - n_ns_y <= char_y_size)
		begin 
			is_starting = 1;
			starting_idx = 0;
			starting_read_address = (DrawX-n_ns_x) + (DrawY-n_ns_y)*char_x_size;
		end
		else if(game_state == 2'b00 && DrawX - s_ns_x >= 0 && DrawX - s_ns_x <= char_x_size && DrawY - s_ns_y >= 0 && DrawY - s_ns_y <= char_y_size)
		begin 
			is_starting = 1;
			starting_idx = 1;
			starting_read_address = (DrawX-s_ns_x) + (DrawY-s_ns_y)*char_x_size;
		end
		else if(game_state == 2'b00 && DrawX - s_shaft_x >= 0 && DrawX - s_shaft_x <= char_x_size && DrawY - s_shaft_y >= 0 && DrawY - s_shaft_y <= char_y_size)
		begin 
			is_starting = 1;
			starting_idx = 2;
			starting_read_address = (DrawX-s_shaft_x) + (DrawY-s_shaft_y)*char_x_size;
		end
		else if(game_state == 2'b00 && DrawX - h_shaft_x >= 0 && DrawX - h_shaft_x <= char_x_size && DrawY - h_shaft_y >= 0 && DrawY - h_shaft_y <= char_y_size)
		begin 
			is_starting = 1;
			starting_idx = 3;
			starting_read_address = (DrawX-h_shaft_x) + (DrawY-h_shaft_y)*char_x_size;
		end
		else if(game_state == 2'b00 && DrawX - a_shaft_x >= 0 && DrawX - a_shaft_x <= char_x_size && DrawY - a_shaft_y >= 0 && DrawY - a_shaft_y <= char_y_size)
		begin 
			is_starting = 1;
			starting_idx = 4;
			starting_read_address = (DrawX-a_shaft_x) + (DrawY-a_shaft_y)*char_x_size;
		end
		else if(game_state == 2'b00 && DrawX - f_shaft_x >= 0 && DrawX - f_shaft_x <= char_x_size && DrawY - f_shaft_y >= 0 && DrawY - f_shaft_y <= char_y_size)
		begin 
			is_starting = 1;
			starting_idx = 5;
			starting_read_address = (DrawX-f_shaft_x) + (DrawY-f_shaft_y)*char_x_size;
		end
		else if(game_state == 2'b00 && DrawX - t_shaft_x >= 0 && DrawX - t_shaft_x <= char_x_size && DrawY - t_shaft_y >= 0 && DrawY - t_shaft_y <= char_y_size)
		begin 
			is_starting = 1;
			starting_idx = 6;
			starting_read_address = (DrawX-t_shaft_x) + (DrawY-t_shaft_y)*char_x_size;
		end
		else if(game_state == 2'b00 && DrawX - p1_x >= 0 && DrawX - p1_x <= char_x_size && DrawY - p1_y >= 0 && DrawY - p1_y <= char_y_size)
		begin 
			is_starting = 1;
			starting_idx = 7;
			starting_read_address = (DrawX-p1_x) + (DrawY-p1_y)*char_x_size;
		end
		else if(game_state == 2'b00 && DrawX - p2_x >= 0 && DrawX - p2_x <= char_x_size && DrawY - p2_y >= 0 && DrawY - p2_y <= char_y_size)
		begin 
			is_starting = 1;
			starting_idx = 8;
			starting_read_address = (DrawX-p2_x) + (DrawY-p2_y)*char_x_size;
		end
		else
		begin
			is_starting = 0;
			starting_idx = 0;
			starting_read_address = 0;
		end


end						
endmodule
