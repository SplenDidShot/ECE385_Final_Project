////////////module to print scoreboard///////////

module scoreboard(
		input [3:0] score0, score1, score2, score3,
		input [3:0] score0_2, score1_2, score2_2, score3_2,
		input [9:0] DrawX, DrawY,
		input [3:0] hp,
		input [3:0] hp_2,
		//output [18:0] bg_read_address,
		output is_char,
		output [3:0] char_idx,
		output [18:0] char_read_address

);
//////////parameter for score1///////
parameter [9:0] score1_0_x = 600;
parameter [9:0] score1_0_y = 90;
parameter [9:0] score1_1_x = 570;
parameter [9:0] score1_1_y = 90;
parameter [9:0] score1_2_x = 540;
parameter [9:0] score1_2_y = 90;
parameter [9:0] score1_3_x = 510;
parameter [9:0] score1_3_y = 90;
parameter [9:0] score2_0_x = 600;
parameter [9:0] score2_0_y = 330;
parameter [9:0] score2_1_x = 570;
parameter [9:0] score2_1_y = 330;
parameter [9:0] score2_2_x = 540;
parameter [9:0] score2_2_y = 330;
parameter [9:0] score2_3_x = 510;
parameter [9:0] score2_3_y = 330;
parameter [9:0] heart0_p1_x = 510;
parameter [9:0] heart0_p1_y = 150;
parameter [9:0] heart1_p1_x = 540;
parameter [9:0] heart1_p1_y = 150;
parameter [9:0] heart2_p1_x = 570;
parameter [9:0] heart2_p1_y = 150;
parameter [9:0] heart3_p1_x = 600;
parameter [9:0] heart3_p1_y = 150;
parameter [9:0] heart0_p2_x = 510;
parameter [9:0] heart0_p2_y = 385;
parameter [9:0] heart1_p2_x = 540;
parameter [9:0] heart1_p2_y = 385;
parameter [9:0] heart2_p2_x = 570;
parameter [9:0] heart2_p2_y = 385;
parameter [9:0] heart3_p2_x = 600;
parameter [9:0] heart3_p2_y = 385;
//////////parameter for each character/////////
parameter [9:0] char_x_size = 30;
parameter [9:0] char_y_size = 45;


always_comb
begin
////////////////////////////////////score of player1/////////////////////////
		if(DrawX - score1_0_x >= 0 && DrawX - score1_0_x <= char_x_size && DrawY - score1_0_y >= 0 && DrawY - score1_0_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = score0;
			char_read_address = (DrawX-score1_0_x) + (DrawY-score1_0_y)*char_x_size;
		end
		else if(DrawX - score1_1_x >= 0 && DrawX - score1_1_x <= char_x_size && DrawY - score1_1_y >= 0 && DrawY - score1_1_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = score1;
			char_read_address = (DrawX-score1_1_x) + (DrawY-score1_1_y)*char_x_size;
		end
		else if(DrawX - score1_2_x >= 0 && DrawX - score1_2_x <= char_x_size && DrawY - score1_2_y >= 0 && DrawY - score1_2_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = score2;
			char_read_address = (DrawX-score1_2_x) + (DrawY-score1_2_y)*char_x_size;
		end
		else if(DrawX - score1_3_x >= 0 && DrawX - score1_3_x <= char_x_size && DrawY - score1_3_y >= 0 && DrawY - score1_3_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = score3;
			char_read_address = (DrawX-score1_3_x) + (DrawY-score1_3_y)*char_x_size;
		end
////////////////////////////////////score of player2//////////////////////////////
		else if(DrawX - score2_0_x >= 0 && DrawX - score2_0_x <= char_x_size && DrawY - score2_0_y >= 0 && DrawY - score2_0_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = score0_2;
			char_read_address = (DrawX-score2_0_x) + (DrawY-score2_0_y)*char_x_size;
		end
		else if(DrawX - score2_1_x >= 0 && DrawX - score2_1_x <= char_x_size && DrawY - score2_1_y >= 0 && DrawY - score2_1_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = score1_2;
			char_read_address = (DrawX-score2_1_x) + (DrawY-score2_1_y)*char_x_size;
		end
		else if(DrawX - score2_2_x >= 0 && DrawX - score2_2_x <= char_x_size && DrawY - score2_2_y >= 0 && DrawY - score2_2_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = score2_2;
			char_read_address = (DrawX-score2_2_x) + (DrawY-score2_2_y)*char_x_size;
		end
		else if(DrawX - score2_3_x >= 0 && DrawX - score2_3_x <= char_x_size && DrawY - score2_3_y >= 0 && DrawY - score2_3_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = score3_2;
			char_read_address = (DrawX-score2_3_x) + (DrawY-score2_3_y)*char_x_size;
		end
/////////////////////////////////hp of player1/////////////////////
		else if(hp <= 6 && DrawX - heart0_p1_x >= 0 && DrawX - heart0_p1_x <= char_x_size && DrawY - heart0_p1_y >= 0 && DrawY - heart0_p1_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 10;
			char_read_address = (DrawX-heart0_p1_x) + (DrawY-heart0_p1_y)*char_x_size;
		end
		else if(hp <= 7 && DrawX - heart0_p1_x >= 0 && DrawX - heart0_p1_x <= char_x_size && DrawY - heart0_p1_y >= 0 && DrawY - heart0_p1_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 11;
			char_read_address = (DrawX-heart0_p1_x) + (DrawY-heart0_p1_y)*char_x_size;
		end
		else if(hp <= 4 && DrawX - heart1_p1_x >= 0 && DrawX - heart1_p1_x <= char_x_size && DrawY - heart1_p1_y >= 0 && DrawY - heart1_p1_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 10;
			char_read_address = (DrawX-heart1_p1_x) + (DrawY-heart1_p1_y)*char_x_size;
		end
		else if(hp <= 5 && DrawX - heart1_p1_x >= 0 && DrawX - heart1_p1_x <= char_x_size && DrawY - heart1_p1_y >= 0 && DrawY - heart1_p1_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 11;
			char_read_address = (DrawX-heart1_p1_x) + (DrawY-heart1_p1_y)*char_x_size;
		end	
		else if(hp <= 2 && DrawX - heart2_p1_x >= 0 && DrawX - heart2_p1_x <= char_x_size && DrawY - heart2_p1_y >= 0 && DrawY - heart2_p1_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 10;
			char_read_address = (DrawX-heart2_p1_x) + (DrawY-heart2_p1_y)*char_x_size;
		end
		else if(hp <= 3 && DrawX - heart2_p1_x >= 0 && DrawX - heart2_p1_x <= char_x_size && DrawY - heart2_p1_y >= 0 && DrawY - heart2_p1_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 11;
			char_read_address = (DrawX-heart2_p1_x) + (DrawY-heart2_p1_y)*char_x_size;
		end
		else if(hp <= 0 && DrawX - heart3_p1_x >= 0 && DrawX - heart3_p1_x <= char_x_size && DrawY - heart3_p1_y >= 0 && DrawY - heart3_p1_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 10;
			char_read_address = (DrawX-heart3_p1_x) + (DrawY-heart3_p1_y)*char_x_size;
		end
		else if(hp <= 1 && DrawX - heart3_p1_x >= 0 && DrawX - heart3_p1_x <= char_x_size && DrawY - heart3_p1_y >= 0 && DrawY - heart3_p1_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 11;
			char_read_address = (DrawX-heart3_p1_x) + (DrawY-heart3_p1_y)*char_x_size;
		end
		
/////////////////////hp of player2/////////////////
		else if(hp_2 <= 6 && DrawX - heart0_p2_x >= 0 && DrawX - heart0_p2_x <= char_x_size && DrawY - heart0_p2_y >= 0 && DrawY - heart0_p2_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 10;
			char_read_address = (DrawX-heart0_p2_x) + (DrawY-heart0_p2_y)*char_x_size;
		end
		else if(hp_2 <= 7 && DrawX - heart0_p2_x >= 0 && DrawX - heart0_p2_x <= char_x_size && DrawY - heart0_p2_y >= 0 && DrawY - heart0_p2_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 11;
			char_read_address = (DrawX-heart0_p2_x) + (DrawY-heart0_p2_y)*char_x_size;
		end
		else if(hp_2 <= 4 && DrawX - heart1_p2_x >= 0 && DrawX - heart1_p2_x <= char_x_size && DrawY - heart1_p2_y >= 0 && DrawY - heart1_p2_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 10;
			char_read_address = (DrawX-heart1_p2_x) + (DrawY-heart1_p2_y)*char_x_size;
		end
		else if(hp_2 <= 5 && DrawX - heart1_p2_x >= 0 && DrawX - heart1_p2_x <= char_x_size && DrawY - heart1_p2_y >= 0 && DrawY - heart1_p2_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 11;
			char_read_address = (DrawX-heart1_p2_x) + (DrawY-heart1_p2_y)*char_x_size;
		end
		else if(hp_2 <= 2 && DrawX - heart2_p2_x >= 0 && DrawX - heart2_p2_x <= char_x_size && DrawY - heart2_p2_y >= 0 && DrawY - heart2_p2_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 10;
			char_read_address = (DrawX-heart2_p2_x) + (DrawY-heart2_p2_y)*char_x_size;
		end
		else if(hp_2 <= 3 && DrawX - heart2_p2_x >= 0 && DrawX - heart2_p2_x <= char_x_size && DrawY - heart2_p2_y >= 0 && DrawY - heart2_p2_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 11;
			char_read_address = (DrawX-heart2_p2_x) + (DrawY-heart2_p2_y)*char_x_size;
		end
		else if(hp_2 <= 0 && DrawX - heart3_p2_x >= 0 && DrawX - heart3_p2_x <= char_x_size && DrawY - heart3_p2_y >= 0 && DrawY - heart3_p2_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 10;
			char_read_address = (DrawX-heart3_p2_x) + (DrawY-heart3_p2_y)*char_x_size;
		end
		else if(hp_2 <= 1 && DrawX - heart3_p2_x >= 0 && DrawX - heart3_p2_x <= char_x_size && DrawY - heart3_p2_y >= 0 && DrawY - heart3_p2_y <= char_y_size)
		begin 
			is_char = 1;
			char_idx = 11;
			char_read_address = (DrawX-heart3_p2_x) + (DrawY-heart3_p2_y)*char_x_size;
		end
		
//////////////////////////////////default setting/////////////
		else 
		begin
			is_char = 0;
			char_idx = 0;
			char_read_address = 0;
		end

end

endmodule
