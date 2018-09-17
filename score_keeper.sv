module score_keeper (input   Clk,
									  Reset,
							input logic	[1:0]	  game_state,
							input logic [13:0]   bonus,
							input logic [13:0]   bonus_2,
							input logic  game_exit, game_exit_2,
							output	[3:0]score0, score1, score2, score3,
							output   [3:0]score0_2, score1_2, score2_2, score3_2,
							output  [1:0]is_winner
							);

							
	logic [50:0]cur_score;
	logic [50:0]next_score;
	logic [15:0]score_buf;
	logic [15:0]score_buf_2;
   logic frame_clk_delayed;
   logic frame_clk_rising_edge;
	logic [3:0]score0_buf, score1_buf, score2_buf, score3_buf;
	logic [3:0]score0_2_buf, score1_2_buf, score2_2_buf, score3_2_buf;
	logic [1:0]is_winner_buf;
	always_ff @ (posedge Clk)
	begin
		if(game_state == 2'b10)
		begin
			cur_score <= cur_score;
			score0 <= score0;
			score1 <= score1;
			score2 <= score2;
			score3 <= score3;
			score0_2 <= score0_2;
			score1_2 <= score1_2;
			score2_2 <= score2_2;
			score3_2 <= score3_2;
			is_winner <= is_winner_buf; 
		end
		else if(Reset)
		begin
			cur_score <= 0;
			score0 <= 0;
			score1 <= 0;
			score2 <= 0;
			score3 <= 0;
			score0_2 <= 0;
			score1_2 <= 0;
			score2_2 <= 0;
			score3_2 <= 0;
			is_winner <= 0;
		end
		else
		begin
			cur_score <= next_score;
			score0 <= score0_buf;
			score1 <= score1_buf;
			score2 <= score2_buf;
			score3 <= score3_buf;
			score0_2 <= score0_2_buf;
			score1_2 <= score1_2_buf;
			score2_2 <= score2_2_buf;
			score3_2 <= score3_2_buf;
			is_winner <= 0;
		end
	end
	
	always_comb
	begin 
		next_score = cur_score + 1;
		score_buf = cur_score[40:25] + bonus;
		score0_buf = score_buf%10;
		score1_buf = (score_buf%100)/10;
		score2_buf = (score_buf%1000)/100;
		score3_buf = (score_buf%10000)/1000;
		if(game_exit)
		begin
			score0_buf = score0;
			score1_buf = score1;
			score2_buf = score2;
			score3_buf = score3;
		end

		score_buf_2 = cur_score[40:25] + bonus_2;
		score0_2_buf = score_buf_2%10;
		score1_2_buf = (score_buf_2%100)/10;
		score2_2_buf = (score_buf_2%1000)/100;
		score3_2_buf = (score_buf_2%10000)/1000;
		if(game_exit_2)
		begin
			score0_2_buf = score0_2;
			score1_2_buf = score1_2;
			score2_2_buf = score2_2;
			score3_2_buf = score3_2;
		end
		
		//decide winner
		is_winner_buf = 0;
		if((score0 + score1*10 + score2*100 + score3*1000) > (score0_2 + score1_2*10 + score2_2*100 + score3_2*1000))
			is_winner_buf = 1;
		else if((score0 + score1*10 + score2*100 + score3*1000) < (score0_2 + score1_2*10 + score2_2*100 + score3_2*1000))
			is_winner_buf = 2;
		
	end
endmodule
