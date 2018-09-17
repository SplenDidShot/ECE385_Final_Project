////////////////state controller///////////////

module state_controller (input logic		 Clk,
														 Reset,
														 game_exit,			//end game signal
														 game_exit_2,
														 game_start,		//start game signal
														 game_restart,		//restart game signal
														 game_menu,			//return to menu signal
								input logic 		[3:0]  hp,
								output logic [1:0] game_state,
								output logic		 game_reset,
														 score_reset);
								
							
							
					
 enum logic [2:0] {pre_game,
							in_game,
							post_game
							}cur_state, next_state;
							
							
always_ff @ (posedge Clk)
begin 
		if(Reset)
			cur_state <= pre_game;
		else
			cur_state <= next_state;
end

always_comb
begin
	next_state = cur_state;
	unique case(cur_state)
		pre_game: 
			if(game_start)
				next_state = in_game;
		in_game:
			if(game_exit && game_exit_2)
				next_state = post_game;
		post_game:
			if(game_restart)			//maybe add a state in between to reset the score values for replay
				next_state = in_game;
			else if(game_menu)
				next_state = pre_game;
				
		default: ;
	endcase
	
	game_reset = 1;
	score_reset = 1;
	
	case(cur_state)
		pre_game:
		begin
			game_state = 2'b00;
		end
		in_game:
		begin
			score_reset = 0;
			game_state = 2'b01;
			game_reset = 0;
		end
		post_game:
		begin
			game_state = 2'b10;
		end
		default: ;
	endcase
end
endmodule
