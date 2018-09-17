module game_over (input [3:0] score0, score1, score2, score3,
						input [3:0] score0_2, score1_2, score2_2, score3_2,
						input [9:0] DrawX, DrawY,
						input [1:0] game_state,
						input [1:0] is_winner,
						//output [18:0] bg_read_address,
						output is_ending,
						output [4:0] ending_idx,
						output [18:0] ending_read_address

						);
						
parameter [9:0] g_game_x = 185;
parameter [9:0] g_game_y = 165;
parameter [9:0] a_game_x = 215;
parameter [9:0] a_game_y = 165;
parameter [9:0] m_game_x = 245;
parameter [9:0] m_game_y = 165;
parameter [9:0] e_game_x = 275;
parameter [9:0] e_game_y = 165;

parameter [9:0] o_over_x = 335;
parameter [9:0] o_over_y = 165;
parameter [9:0] v_over_x = 365;
parameter [9:0] v_over_y = 165;
parameter [9:0] e_over_x = 395;
parameter [9:0] e_over_y = 165;
parameter [9:0] r_over_x = 425;
parameter [9:0] r_over_y = 165;

parameter [9:0] p_p1_x = 185;
parameter [9:0] p_p1_y = 270;
parameter [9:0] one_p1_x = 215;
parameter [9:0] one_p1_y = 270;
parameter [9:0] p_p2_x = 185;
parameter [9:0] p_p2_y = 345;
parameter [9:0] two_p2_x = 215;
parameter [9:0] two_p2_y = 345;

parameter [9:0] score1_0_x = 390;
parameter [9:0] score1_0_y = 270;
parameter [9:0] score1_1_x = 360;
parameter [9:0] score1_1_y = 270;
parameter [9:0] score1_2_x = 330;
parameter [9:0] score1_2_y = 270;
parameter [9:0] score1_3_x = 300;
parameter [9:0] score1_3_y = 270;

parameter [9:0] score2_0_x = 390;
parameter [9:0] score2_0_y = 345;
parameter [9:0] score2_1_x = 360;
parameter [9:0] score2_1_y = 345;
parameter [9:0] score2_2_x = 330;
parameter [9:0] score2_2_y = 345;
parameter [9:0] score2_3_x = 300;
parameter [9:0] score2_3_y = 345;

parameter [9:0] tro_p1_x = 425;
parameter [9:0] tro_p1_y = 270; 	
parameter [9:0] tro_p2_x = 425;
parameter [9:0] tro_p2_y = 345;

parameter [9:0] p1_stand_x = 260;
parameter [9:0] p1_stand_y = 270;
parameter [9:0] p2_stand_x = 260;
parameter [9:0] p2_stand_y = 345;
 	

parameter [9:0] char_x_size = 30;
parameter [9:0] char_y_size = 45;	


always_comb
begin

		if(game_state == 2'b10 && DrawX - g_game_x >= 0 && DrawX - g_game_x <= char_x_size && DrawY - g_game_y >= 0 && DrawY - g_game_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 10;
			ending_read_address = (DrawX-g_game_x) + (DrawY-g_game_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - a_game_x >= 0 && DrawX - a_game_x <= char_x_size && DrawY - a_game_y >= 0 && DrawY - a_game_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 11;
			ending_read_address = (DrawX-a_game_x) + (DrawY-a_game_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - m_game_x >= 0 && DrawX - m_game_x <= char_x_size && DrawY - m_game_y >= 0 && DrawY - m_game_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 12;
			ending_read_address = (DrawX-m_game_x) + (DrawY-m_game_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - e_game_x >= 0 && DrawX - e_game_x <= char_x_size && DrawY - e_game_y >= 0 && DrawY - e_game_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 13;
			ending_read_address = (DrawX-e_game_x) + (DrawY-e_game_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - o_over_x >= 0 && DrawX - o_over_x <= char_x_size && DrawY - o_over_y >= 0 && DrawY - o_over_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 14;
			ending_read_address = (DrawX-o_over_x) + (DrawY-o_over_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - v_over_x >= 0 && DrawX - v_over_x <= char_x_size && DrawY - v_over_y >= 0 && DrawY - v_over_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 15;
			ending_read_address = (DrawX-v_over_x) + (DrawY-v_over_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - e_over_x >= 0 && DrawX - e_over_x <= char_x_size && DrawY - e_over_y >= 0 && DrawY - e_over_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 16;
			ending_read_address = (DrawX-e_over_x) + (DrawY-e_over_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - r_over_x >= 0 && DrawX - r_over_x <= char_x_size && DrawY - r_over_y >= 0 && DrawY - r_over_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 17;
			ending_read_address = (DrawX-r_over_x) + (DrawY-r_over_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - p_p1_x >= 0 && DrawX - p_p1_x <= char_x_size && DrawY - p_p1_y >= 0 && DrawY - p_p1_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 18;
			ending_read_address = (DrawX-p_p1_x) + (DrawY-p_p1_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - one_p1_x >= 0 && DrawX - one_p1_x <= char_x_size && DrawY - one_p1_y >= 0 && DrawY - one_p1_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 19;
			ending_read_address = (DrawX-one_p1_x) + (DrawY-one_p1_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - p_p2_x >= 0 && DrawX - p_p2_x <= char_x_size && DrawY - p_p2_y >= 0 && DrawY - p_p2_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 20;
			ending_read_address = (DrawX-p_p2_x) + (DrawY-p_p2_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - two_p2_x >= 0 && DrawX - two_p2_x <= char_x_size && DrawY - two_p2_y >= 0 && DrawY - two_p2_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 21;
			ending_read_address = (DrawX-two_p2_x) + (DrawY-two_p2_y)*char_x_size;
		end
		else if(is_winner != 2 && game_state == 2'b10 && DrawX - tro_p1_x >= 0 && DrawX - tro_p1_x <= char_x_size && DrawY - tro_p1_y >= 0 && DrawY - tro_p1_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 22;
			ending_read_address = (DrawX-tro_p1_x) + (DrawY-tro_p1_y)*char_x_size;
		end
		else if(is_winner != 1 && game_state == 2'b10 && DrawX - tro_p2_x >= 0 && DrawX - tro_p2_x <= char_x_size && DrawY - tro_p2_y >= 0 && DrawY - tro_p2_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 23;
			ending_read_address = (DrawX-tro_p2_x) + (DrawY-tro_p2_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - p1_stand_x >= 0 && DrawX - p1_stand_x <= char_x_size && DrawY - p1_stand_y >= 0 && DrawY - p1_stand_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 24;
			ending_read_address = (DrawX-p1_stand_x) + (DrawY-p1_stand_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - p2_stand_x >= 0 && DrawX - p2_stand_x <= char_x_size && DrawY - p2_stand_y >= 0 && DrawY - p2_stand_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = 25;
			ending_read_address = (DrawX-p2_stand_x) + (DrawY-p2_stand_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - score1_0_x >= 0 && DrawX - score1_0_x <= char_x_size && DrawY - score1_0_y >= 0 && DrawY - score1_0_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = score0;
			ending_read_address = (DrawX-score1_0_x) + (DrawY-score1_0_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - score1_1_x >= 0 && DrawX - score1_1_x <= char_x_size && DrawY - score1_1_y >= 0 && DrawY - score1_1_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = score1;
			ending_read_address = (DrawX-score1_1_x) + (DrawY-score1_1_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - score1_2_x >= 0 && DrawX - score1_2_x <= char_x_size && DrawY - score1_2_y >= 0 && DrawY - score1_2_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = score2;
			ending_read_address = (DrawX-score1_2_x) + (DrawY-score1_2_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - score1_3_x >= 0 && DrawX - score1_3_x <= char_x_size && DrawY - score1_3_y >= 0 && DrawY - score1_3_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = score3;
			ending_read_address = (DrawX-score1_3_x) + (DrawY-score1_3_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - score2_0_x >= 0 && DrawX - score2_0_x <= char_x_size && DrawY - score2_0_y >= 0 && DrawY - score2_0_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = score0_2;
			ending_read_address = (DrawX-score2_0_x) + (DrawY-score2_0_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - score2_1_x >= 0 && DrawX - score2_1_x <= char_x_size && DrawY - score2_1_y >= 0 && DrawY - score2_1_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = score1_2;
			ending_read_address = (DrawX-score2_1_x) + (DrawY-score2_1_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - score2_2_x >= 0 && DrawX - score2_2_x <= char_x_size && DrawY - score2_2_y >= 0 && DrawY - score2_2_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = score2_2;
			ending_read_address = (DrawX-score2_2_x) + (DrawY-score2_2_y)*char_x_size;
		end
		else if(game_state == 2'b10 && DrawX - score2_3_x >= 0 && DrawX - score2_3_x <= char_x_size && DrawY - score2_3_y >= 0 && DrawY - score2_3_y <= char_y_size)
		begin 
			is_ending = 1;
			ending_idx = score3_2;
			ending_read_address = (DrawX-score2_3_x) + (DrawY-score2_3_y)*char_x_size;
		end
		else 
		begin
			is_ending = 0;
			ending_idx = 0;
			ending_read_address = 0;
		end

end
endmodule
