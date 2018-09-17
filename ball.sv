//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball ( input         Clk,                // 50 MHz clock
                             Reset,              // Active-high reset signal
                             frame_clk,          // The clock indicating a new frame (~60Hz)
					input [15:0]	  keycode,
					input [3:0]   KEY,				 	//keyboard inputs
					input [1:0]   SW,
               input [9:0]   DrawX, DrawY,       // Current pixel coordinates
					input [9:0]   floor_x[5],
					input [9:0]   floor_y[5],
					output logic  [2:0]is_floor,				//whether it is floor
					output logic  [18:0] stand_read_address,			// draw the player
					output logic  [18:0] stand_read_address_2,
					output logic  [18:0] floor_read_address,			// draw the player
					output logic  is_player, is_player_2,
					output		  game_exit,								//end game condition
					output 		  game_exit_2,
					output [13:0]  bonus,										//bonus add to final score
					output [13:0]  bonus_2,
					output spike_floor_stat,
					output spike_floor_stat_2,
					output [3:0]hp,													//players' health
					output [3:0]hp_2,
					output [1:0] direction
					
              );
    

	 
	 ///////////player information////////////////////
	 parameter [9:0] player_x_size = 30;
	 parameter [9:0] player_y_size = 45;
    parameter [9:0] player_x_center=80;  // Center position on the X axis
    parameter [9:0] player_y_center=100;  // Center position on the X axis
	 parameter [9:0] player2_x_center=240;  // Center position on the X axis
    parameter [9:0] player2_y_center=100;  // Center position on the X axis
    parameter [9:0] player_x_min=0;       // Leftmost point on the X axis
    parameter [9:0] player_x_max=319;     // Rightmost point on the X axis
    parameter [9:0] player_y_min=0;       // Topmost point on the Y axis
    parameter [9:0] player_y_max=479;     // Bottommost point on the Y axis
    parameter [9:0] player_x_step=3;      // Step size on the X axis
    parameter [9:0] player_y_step=2;      // Step size on the Y axis
	 parameter [9:0] floor_step=1;
	 parameter [9:0] spike_height = 35;
	 parameter [9:0] drop_height = 60;

	 logic [9:0] floor_1_X;  //first floor
    logic [9:0] floor_1_Y;
	 
    logic [9:0] floor_2_X;  //second floor
    logic [9:0] floor_2_Y;
	 
    logic [9:0] floor_3_X;  //third floor
    logic [9:0] floor_3_Y;
	 	 
    logic [9:0] floor_4_X;  //forth floor
    logic [9:0] floor_4_Y;
	 
	 logic [9:0] floor_5_X;  //fifth floor
    logic [9:0] floor_5_Y;
	 
	 assign floor_1_X = floor_x[0];
	 assign floor_2_X = floor_x[1];
	 assign floor_3_X = floor_x[2];
	 assign floor_4_X = floor_x[3];
	 assign floor_5_X = floor_x[4];
	 assign floor_1_Y = floor_y[0];
	 assign floor_2_Y = floor_y[1];
	 assign floor_3_Y = floor_y[2];
	 assign floor_4_Y = floor_y[3];
	 assign floor_5_Y = floor_y[4];
	 
    parameter [9:0] floor_X_size=90;  //floor size parameter
    parameter [9:0] floor_Y_size=20;
	 parameter [9:0] jump_boundary = 75;
	 parameter [9:0] full_health = 8;
	 parameter [9:0] death_space = 500;
	 /////jump state of p1///////
	 logic on_jump_floor;
	 logic jump_state;
	 logic [1:0]on_belt_floor;
	 /////jump state of p2///////
	 logic on_jump_floor_2;
	 logic jump_state_2;
	 logic [1:0]on_belt_floor_2;
	 //////other state of p1//////
	 //logic spike_floor_stat; 	//spike floor behavior
	 logic spike_floor_stat_buf; 	//spike floor behavior
	 logic [9:0] belt_step;			//belt speed on belt floor  
	 logic [9:0] jump_step;   //jump height on bounce floor 
	 logic is_spiked;   //is player is spiked by top spike
	 logic is_spiked_buf;
	 //logic hp;
	 logic [3:0]hp_buf;
	 //////other state of p2//////
	 //logic spike_floor_stat; 	//spike floor behavior
	 logic spike_floor_stat_buf_2; 	//spike floor behavior
	 logic [9:0] belt_step_2;			//belt speed on belt floor  
	 logic [9:0] jump_step_2;   //jump height on bounce floor 
	 logic is_spiked_2;   //is player is spiked by top spike
	 logic is_spiked_buf_2;
	 //logic hp;
	 logic [3:0]hp_buf_2;
	 

	 ////////////player postion control////////////////
    logic [9:0] player_x_pos, player_x_motion, player_y_pos, player_y_motion;
	 logic [9:0] player2_x_pos, player2_x_motion, player2_y_pos, player2_y_motion;
    logic [9:0] player_x_pos_in, player_x_motion_in, player_y_pos_in, player_y_motion_in;
	 logic [9:0] player2_x_pos_in, player2_x_motion_in, player2_y_pos_in, player2_y_motion_in;
	 //logic [1:0] direction;		//direction of player1
	 logic [1:0] direction_2;  //direction of player2
 	 //////////////////bonus of p1//////////////
	 logic [13:0] bonus_buffer;
	 logic b_flag;
	 logic b_flag_buf;
	 //////////////////bonus of p2//////////////
	 logic [13:0] bonus_buffer_2;
	 logic b_flag_2;
	 logic b_flag_buf_2;
    
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed;
    logic frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
		  //direction[1] <= ~KEY[3];
		  //direction[0] <= ~KEY[2];
		  //direction_2[1] <= SW[1];
		  //direction_2[0] <= SW[0];
    end
    assign frame_clk_rising_edge = (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    // Update ball position and motion
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
				/////////palyer initial//////////
				//////player1////////////
            player_x_pos <= player_x_center;
            player_y_pos <= player_y_center;
            player_x_motion <= 10'd0;
            player_y_motion <= 10'd0;
				///////player2//////////
				player2_x_pos <= player2_x_center;
            player2_y_pos <= player2_y_center;
            player2_x_motion <= 10'd0;
            player2_y_motion <= 10'd0;
				////////player1////////////
				is_spiked <= is_spiked_buf;
				hp <= 0;
				bonus <= 0;
				b_flag <= 0;
				spike_floor_stat <= 0;
				////////player1////////////
				is_spiked_2 <= is_spiked_buf_2;
				hp_2 <= 0;
				bonus_2 <= 0;
				b_flag_2 <= 0;
				spike_floor_stat_2 <= 0;
        end
        else if (frame_clk_rising_edge)        // Update only at rising edge of frame clock
        begin
		  //////////////player1///////////////
            player_x_pos <= player_x_pos_in;
            player_y_pos <= player_y_pos_in;
            player_x_motion <= player_x_motion_in;
            player_y_motion <= player_y_motion_in;
		////////////////player2/////////////////
				player2_x_pos <= player2_x_pos_in;
            player2_y_pos <= player2_y_pos_in;
            player2_x_motion <= player2_x_motion_in;
            player2_y_motion <= player2_y_motion_in;
		/////////////////player1//////////////////
				jump_state <= on_jump_floor;
				is_spiked <= is_spiked_buf;
				hp <= hp_buf;
				bonus <= bonus_buffer;
				b_flag <= b_flag_buf;
				spike_floor_stat <= spike_floor_stat_buf;
		/////////////////player2//////////////////
				jump_state_2 <= on_jump_floor_2;
				is_spiked_2 <= is_spiked_buf_2;
				hp_2 <= hp_buf_2;
				bonus_2 <= bonus_buffer_2;
				b_flag_2 <= b_flag_buf_2;
				spike_floor_stat_2 <= spike_floor_stat_buf_2;
        end
        // By defualt, keep the register values.
    end
    
    // You need to modify always_comb block.
    always_comb
    begin

	 
        // Update player1
        player_x_pos_in = player_x_pos + player_x_motion;
        player_y_pos_in = player_y_pos + player_y_motion;
		  is_spiked_buf = 0;
		  game_exit = 0;
		  hp_buf = hp;
		  
		  //parameter of player2
		  player2_x_pos_in = player2_x_pos + player2_x_motion;
        player2_y_pos_in = player2_y_pos + player2_y_motion;
		  is_spiked_buf_2 = 0;
		  game_exit_2 = 0;
		  hp_buf_2 = hp_2;
        //////////////player1//////////////////////
        // e.g. player_y_pos - player_y_size <= player_y_min 
        // If player_y_pos is 0, then player_y_pos - player_y_size will not be -4, but rather a large positive number.
		  if(hp >= 8)
		  begin
				player_y_pos_in = death_space;
				game_exit = 1;
		  end
        else if( player_y_pos + player_y_size >= player_y_max )  // player1 is at the bottom edge
		  begin
				is_spiked_buf = 0;
				game_exit = 1;
            player_y_pos_in = death_space;  // 2's complement. 
				hp_buf = 8;
		  end	
		  else if( player_y_pos <= spike_height)  // Ball is at the top edge
		  begin
				hp_buf = hp + 1;
				is_spiked_buf = 1;
            player_y_pos_in = player_y_pos + player_y_step;  // 2's complement. 
		  end
		  else if( player_y_pos >= 0 && player_y_pos <= spike_height + drop_height && is_spiked == 1) 
		  begin
				is_spiked_buf = 1;
            player_y_pos_in = player_y_pos + player_y_step;  // 2's complement. 
		  end
		  else if(player_y_pos >= spike_height + drop_height && is_spiked == 1) 
		  begin
				is_spiked_buf = 0;
            player_y_pos_in = player_y_pos + player_y_motion;  // 2's complement. 
		  end
		  
		  /////////////////////player2//////////////////////
		  // e.g. player_y_pos - player_y_size <= player_y_min 
        // If player_y_pos is 0, then player_y_pos - player_y_size will not be -4, but rather a large positive number.
		  if(hp_2 >= 8)
		  begin
				player2_y_pos_in = death_space;
				game_exit_2 = 1;
		  end
        else if( player2_y_pos + player_y_size >= player_y_max )  // player1 is at the bottom edge
		  begin
				is_spiked_buf_2 = 0;
				game_exit_2 = 1;
            player2_y_pos_in = death_space;  // 2's complement. 
				hp_buf_2 = 8;
		  end	
		  else if( player2_y_pos <= spike_height)  // Ball is at the top edge
		  begin
				hp_buf_2 = hp_2 + 1;
				is_spiked_buf_2 = 1;
            player2_y_pos_in = player2_y_pos + player_y_step;  // 2's complement. 
		  end
		  else if( player2_y_pos >= 0 && player2_y_pos <= spike_height + drop_height && is_spiked_2 == 1) 
		  begin
				is_spiked_buf_2 = 1;
            player2_y_pos_in = player2_y_pos + player_y_step;  // 2's complement. 
		  end
		  else if(player2_y_pos >= spike_height + drop_height && is_spiked_2 == 1) 
		  begin
				is_spiked_buf_2 = 0;
            player2_y_pos_in = player2_y_pos + player2_y_motion;  // 2's complement. 
		  end
		  //////get direction//////////
		  		direction[0] = 0;
				direction[1] = 0;
				direction_2[0] = 0;
				direction_2[1] = 0;
			if(keycode == 16'h0004)
			begin
				direction[1] = 1;
			end
			else if(keycode == 16'h0007)
			begin
				direction[0] = 1;
			end
			
			else if(keycode == 16'h000d)
			begin
				direction_2[1] = 1;
			end
			else if(keycode == 16'h000f)
			begin
				direction_2[0] = 1;
			end
			//////////////////
			else if(keycode == 16'h040d)
			begin
				direction[1] = 1;
				direction_2[1] = 1;
			end
			
			else if(keycode == 16'h040f)
			begin
				direction[1] = 1;
				direction_2[0] = 1;
			end
			else if(keycode == 16'h070d)
			begin
				direction[0] = 1;
				direction_2[1] = 1;
			end
			else if(keycode == 16'h070f)
			begin
				direction[0] = 1;
				direction_2[0] = 1;
			end
			///////////////////
			
			
        
        
		  ///////player1 //////////
        // TODO: Add other boundary conditions and handle keypress here.
		  if( (player_x_pos+player_x_size) >= player_x_max && direction[1:0]!=2'b10)  // player is at the right edge
            player_x_pos_in = player_x_pos;  // 2's complement.  
        else if ( player_x_pos <= (player_x_min+5) && direction[1:0]!=2'b01)  // player is at the left edge
            player_x_pos_in = player_x_pos;
			//////player2 ////////////	
        // TODO: Add other boundary conditions and handle keypress here.
		  if( (player2_x_pos+player_x_size) >= player_x_max && direction_2[1:0]!=2'b10)  // player is at the right edge
            player2_x_pos_in = player2_x_pos;  // 2's complement.  
        else if ( player2_x_pos <= (player_x_min+5) && direction_2[1:0]!=2'b01)  // player is at the left edge
            player2_x_pos_in = player2_x_pos;
			////////player1//////////	
        // By default, keep motion downwards
        player_x_motion_in = belt_step;
        player_y_motion_in = player_y_step + jump_step;		
			////////player2//////////
			// By default, keep motion downwards
        player2_x_motion_in = belt_step_2;
        player2_y_motion_in = player_y_step + jump_step_2;		
		  	///////player1///////////
			//key input motions
			unique case(direction[1:0])
			2'b10:		//A, move left
			begin
					player_x_motion_in = -player_x_step + belt_step;
					//when ball is on belt floor
			end			
			2'b01:		//D, move right
			begin
					player_x_motion_in = player_x_step + belt_step;
					//when ball is on belt floor 
			end
			default:
					player_x_motion_in = belt_step;
			endcase
			//////////player2//////////
			//key input motions
			unique case(direction_2[1:0])
			2'b10:		//A, move left
			begin
					player2_x_motion_in = -player_x_step + belt_step_2;
					//when ball is on belt floor
			end			
			2'b01:		//D, move right
			begin
					player2_x_motion_in = player_x_step + belt_step_2;
					//when ball is on belt floor 
			end
			default:
					player2_x_motion_in = belt_step_2;
			endcase
			
			on_jump_floor = 0;
			on_belt_floor = 2'b00;
			on_jump_floor_2 = 0;
			on_belt_floor_2 = 2'b00;
			//hp_buf = hp;
			bonus_buffer = bonus;
			bonus_buffer_2 = bonus_2;
			b_flag_buf = 0;
			b_flag_buf_2 = 0;
			spike_floor_stat_buf = 0;
			spike_floor_stat_buf_2 = 0;
			
			/////////////player1/////////////////
			//ball fall on floor
			if(b_flag == 0 && is_spiked == 0 && player_y_pos + player_y_size-floor_1_Y >= 10'd0 && player_y_pos + player_y_size-floor_1_Y <= floor_Y_size && player_x_pos + player_x_size  >= floor_1_X && player_x_pos <= floor_X_size + floor_1_X )
			begin
				player_y_pos_in = floor_1_Y - player_y_size - floor_step;
				player_y_motion_in = 10'd0;
				bonus_buffer = bonus + 10;
				b_flag_buf = 1;
			end
			else if(b_flag == 1 && is_spiked == 0 && player_y_pos + player_y_size-floor_1_Y >= 10'd0 && player_y_pos + player_y_size-floor_1_Y <= floor_Y_size && player_x_pos + player_x_size >= floor_1_X  && player_x_pos <= floor_X_size + floor_1_X )
			begin
				player_y_pos_in = floor_1_Y - player_y_size - floor_step;
				player_y_motion_in = 10'd0;
				bonus_buffer = bonus;
				b_flag_buf = b_flag;
			end
			else if(b_flag == 0 && is_spiked == 0 && player_y_pos + player_y_size-floor_2_Y >= 10'd0 && player_y_pos + player_y_size-floor_2_Y <= floor_Y_size && player_x_pos + player_x_size >= floor_2_X  && player_x_pos <= floor_X_size + floor_2_X  )
			begin
				on_belt_floor = 2'b01;
				player_y_pos_in = floor_2_Y - player_y_size - floor_step;
				player_y_motion_in = 10'd0;
				bonus_buffer = bonus + 10;
				b_flag_buf = 1;
			end
			else if(b_flag == 1 && is_spiked == 0 && player_y_pos + player_y_size-floor_2_Y >= 10'd0 && player_y_pos + player_y_size-floor_2_Y <= floor_Y_size && player_x_pos + player_x_size >= floor_2_X  && player_x_pos <= floor_X_size + floor_2_X  )
			begin
				on_belt_floor = 2'b01;
				player_y_pos_in = floor_2_Y - player_y_size - floor_step;
				player_y_motion_in = 10'd0;
				bonus_buffer = bonus;
				b_flag_buf = b_flag;
			end
			else if(b_flag == 0 && is_spiked == 0 && player_y_pos + player_y_size-floor_3_Y >= 10'd0 && player_y_pos + player_y_size-floor_3_Y <= floor_Y_size && player_x_pos + player_x_size  >= floor_3_X && player_x_pos <= floor_X_size + floor_3_X  )
			begin
				on_belt_floor = 2'b10;
				player_y_pos_in = floor_3_Y - player_y_size - floor_step;
				player_y_motion_in = 10'd0;
				bonus_buffer = bonus + 10;
				b_flag_buf = 1;
			end
			else if(b_flag == 1 && is_spiked == 0 && player_y_pos + player_y_size-floor_3_Y >= 10'd0 && player_y_pos + player_y_size-floor_3_Y <= floor_Y_size && player_x_pos + player_x_size >= floor_3_X  && player_x_pos <= floor_X_size + floor_3_X  )
			begin
				on_belt_floor = 2'b10;
				player_y_pos_in = floor_3_Y - player_y_size - floor_step;
				player_y_motion_in = 10'd0;
				bonus_buffer = bonus;
				b_flag_buf = b_flag;
			end
			else if(b_flag == 0 && is_spiked == 0 && player_y_pos + player_y_size-floor_4_Y >= 10'd0 && player_y_pos + player_y_size-floor_4_Y <= floor_Y_size && player_x_pos + player_x_size >= floor_4_X  && player_x_pos <= floor_X_size + floor_4_X  )
			begin
				on_jump_floor = 1;
				//player_y_pos_in = floor_4_Y - player_y_size - floor_step;
				//player_y_motion_in = 10'd0;
				bonus_buffer = bonus + 10;
				b_flag_buf = 1;
			end
			else if(b_flag == 1 && is_spiked == 0 && player_y_pos + player_y_size-floor_4_Y >= 10'd0 && player_y_pos + player_y_size-floor_4_Y <= floor_Y_size && player_x_pos + player_x_size >= floor_4_X  && player_x_pos <= floor_X_size + floor_4_X  )
			begin
				on_jump_floor = 1;
				//player_y_pos_in = floor_4_Y - player_y_size - floor_step;
				//player_y_motion_in = 10'd0;
				bonus_buffer = bonus;
				b_flag_buf = b_flag;
			end
			else if(spike_floor_stat == 0 && is_spiked == 0 && player_y_pos + player_y_size-floor_5_Y >= 10'd0 && player_y_pos + player_y_size-floor_5_Y <= floor_Y_size && player_x_pos + player_x_size >= floor_5_X  && player_x_pos <= floor_X_size + floor_5_X  )
			begin
				hp_buf = hp + 1;
				spike_floor_stat_buf = 1;
				player_y_pos_in = floor_5_Y - player_y_size - floor_step;
				player_y_motion_in = 10'd0;
			end
			else if(spike_floor_stat == 1 && is_spiked == 0 && player_y_pos + player_y_size-floor_5_Y >= 10'd0 && player_y_pos + player_y_size-floor_5_Y <= floor_Y_size && player_x_pos + player_x_size >= floor_5_X  && player_x_pos <= floor_X_size + floor_5_X  )
			begin
				hp_buf = hp;
				spike_floor_stat_buf = spike_floor_stat;
				player_y_pos_in = floor_5_Y - player_y_size - floor_step;
				player_y_motion_in = 10'd0;
			end
			else if(b_flag == 0 && is_spiked == 0 && floor_4_Y - player_y_pos  >= 10'd0 && floor_4_Y - player_y_pos <= jump_boundary && player_x_pos + player_x_size >= floor_4_X  && player_x_pos <= floor_X_size + floor_4_X  )
			begin
				on_jump_floor = jump_state;
				//player_y_pos_in = floor_4_Y - player_y_size - floor_step;
				//player_y_motion_in = 10'd0;
				bonus_buffer = bonus + 10;
				b_flag_buf = 1;
			end
			else if(b_flag == 1 && is_spiked == 0 && floor_4_Y - player_y_pos  >= 10'd0 && floor_4_Y - player_y_pos <= jump_boundary && player_x_pos + player_x_size >= floor_4_X  && player_x_pos <= floor_X_size + floor_4_X  )
			begin
				on_jump_floor = jump_state;
				//player_y_pos_in = floor_4_Y - player_y_size - floor_step;
				//player_y_motion_in = 10'd0;
				bonus_buffer = bonus;
				b_flag_buf = b_flag;		
			end
		/*	else if(is_spiked == 0 && floor_5_Y - player_y_pos  >= 10'd0 && floor_5_Y - player_y_pos <= jump_boundary && player_x_pos >= floor_5_X - player_x_size && player_x_pos <= floor_X_size + floor_5_X  )
			begin
				on_jump_floor = jump_state;
				//player_y_pos_in = floor_5_Y - player_y_size - floor_step;
				//player_y_motion_in = 10'd0;
			end
		*/
		
		/////////////////////////////////player2//////////////////////////////
			if(b_flag_2 == 0 && is_spiked_2 == 0 && player2_y_pos + player_y_size-floor_1_Y >= 10'd0 && player2_y_pos + player_y_size-floor_1_Y <= floor_Y_size && player2_x_pos + player_x_size  >= floor_1_X && player2_x_pos <= floor_X_size + floor_1_X )
			begin
				player2_y_pos_in = floor_1_Y - player_y_size - floor_step;
				player2_y_motion_in = 10'd0;
				bonus_buffer_2 = bonus_2 + 10;
				b_flag_buf_2 = 1;
			end
			else if(b_flag_2 == 1 && is_spiked_2 == 0 && player2_y_pos + player_y_size-floor_1_Y >= 10'd0 && player2_y_pos + player_y_size-floor_1_Y <= floor_Y_size && player2_x_pos + player_x_size >= floor_1_X  && player2_x_pos <= floor_X_size + floor_1_X )
			begin
				player2_y_pos_in = floor_1_Y - player_y_size - floor_step;
				player2_y_motion_in = 10'd0;
				bonus_buffer_2 = bonus_2;
				b_flag_buf_2 = b_flag_2;
			end
			else if(b_flag_2 == 0 && is_spiked_2 == 0 && player2_y_pos + player_y_size-floor_2_Y >= 10'd0 && player2_y_pos + player_y_size-floor_2_Y <= floor_Y_size && player2_x_pos + player_x_size >= floor_2_X  && player2_x_pos <= floor_X_size + floor_2_X  )
			begin
				on_belt_floor_2 = 2'b01;
				player2_y_pos_in = floor_2_Y - player_y_size - floor_step;
				player2_y_motion_in = 10'd0;
				bonus_buffer_2 = bonus_2 + 10;
				b_flag_buf_2 = 1;
			end
			else if(b_flag_2 == 1 && is_spiked_2 == 0 && player2_y_pos + player_y_size-floor_2_Y >= 10'd0 && player2_y_pos + player_y_size-floor_2_Y <= floor_Y_size && player2_x_pos + player_x_size >= floor_2_X  && player2_x_pos <= floor_X_size + floor_2_X  )
			begin
				on_belt_floor_2 = 2'b01;
				player2_y_pos_in = floor_2_Y - player_y_size - floor_step;
				player2_y_motion_in = 10'd0;
				bonus_buffer_2 = bonus_2;
				b_flag_buf_2 = b_flag_2;
			end
			else if(b_flag_2 == 0 && is_spiked_2 == 0 && player2_y_pos + player_y_size-floor_3_Y >= 10'd0 && player2_y_pos + player_y_size-floor_3_Y <= floor_Y_size && player2_x_pos + player_x_size  >= floor_3_X && player2_x_pos <= floor_X_size + floor_3_X  )
			begin
				on_belt_floor_2 = 2'b10;
				player2_y_pos_in = floor_3_Y - player_y_size - floor_step;
				player2_y_motion_in = 10'd0;
				bonus_buffer_2 = bonus_2 + 10;
				b_flag_buf_2 = 1;
			end
			else if(b_flag_2 == 1 && is_spiked_2 == 0 && player2_y_pos + player_y_size-floor_3_Y >= 10'd0 && player2_y_pos + player_y_size-floor_3_Y <= floor_Y_size && player2_x_pos + player_x_size >= floor_3_X  && player2_x_pos <= floor_X_size + floor_3_X  )
			begin
				on_belt_floor_2 = 2'b10;
				player2_y_pos_in = floor_3_Y - player_y_size - floor_step;
				player2_y_motion_in = 10'd0;
				bonus_buffer_2 = bonus_2;
				b_flag_buf_2 = b_flag_2;
			end
			else if(b_flag_2 == 0 && is_spiked_2 == 0 && player2_y_pos + player_y_size-floor_4_Y >= 10'd0 && player2_y_pos + player_y_size-floor_4_Y <= floor_Y_size && player2_x_pos + player_x_size >= floor_4_X  && player2_x_pos <= floor_X_size + floor_4_X  )
			begin
				on_jump_floor_2 = 1;
				//player_y_pos_in = floor_4_Y - player_y_size - floor_step;
				//player_y_motion_in = 10'd0;
				bonus_buffer_2 = bonus_2 + 10;
				b_flag_buf_2 = 1;
			end
			else if(b_flag_2 == 1 && is_spiked_2 == 0 && player2_y_pos + player_y_size-floor_4_Y >= 10'd0 && player2_y_pos + player_y_size-floor_4_Y <= floor_Y_size && player2_x_pos + player_x_size >= floor_4_X  && player2_x_pos <= floor_X_size + floor_4_X  )
			begin
				on_jump_floor_2 = 1;
				//player_y_pos_in = floor_4_Y - player_y_size - floor_step;
				//player_y_motion_in = 10'd0;
				bonus_buffer_2 = bonus_2;
				b_flag_buf_2 = b_flag_2;
			end
			else if(spike_floor_stat_2 == 0 && is_spiked_2 == 0 && player2_y_pos + player_y_size-floor_5_Y >= 10'd0 && player2_y_pos + player_y_size-floor_5_Y <= floor_Y_size && player2_x_pos + player_x_size >= floor_5_X  && player2_x_pos <= floor_X_size + floor_5_X  )
			begin
				hp_buf_2 = hp_2 + 1;
				spike_floor_stat_buf_2 = 1;
				player2_y_pos_in = floor_5_Y - player_y_size - floor_step;
				player2_y_motion_in = 10'd0;
			end
			else if(spike_floor_stat_2 == 1 && is_spiked_2 == 0 && player2_y_pos + player_y_size-floor_5_Y >= 10'd0 && player2_y_pos + player_y_size-floor_5_Y <= floor_Y_size && player2_x_pos + player_x_size >= floor_5_X  && player2_x_pos <= floor_X_size + floor_5_X  )
			begin
				hp_buf_2 = hp_2;
				spike_floor_stat_buf_2 = spike_floor_stat_2;
				player2_y_pos_in = floor_5_Y - player_y_size - floor_step;
				player2_y_motion_in = 10'd0;
			end
			else if(b_flag_2 == 0 && is_spiked_2 == 0 && floor_4_Y - player2_y_pos  >= 10'd0 && floor_4_Y - player2_y_pos <= jump_boundary && player2_x_pos + player_x_size >= floor_4_X  && player2_x_pos <= floor_X_size + floor_4_X  )
			begin
				on_jump_floor_2 = jump_state_2;
				//player_y_pos_in = floor_4_Y - player_y_size - floor_step;
				//player_y_motion_in = 10'd0;
				bonus_buffer_2 = bonus_2 + 10;
				b_flag_buf_2 = 1;
			end
			else if(b_flag_2 == 1 && is_spiked_2 == 0 && floor_4_Y - player2_y_pos  >= 10'd0 && floor_4_Y - player2_y_pos <= jump_boundary && player2_x_pos + player_x_size >= floor_4_X  && player2_x_pos <= floor_X_size + floor_4_X  )
			begin
				on_jump_floor_2 = jump_state_2;
				//player_y_pos_in = floor_4_Y - player_y_size - floor_step;
				//player_y_motion_in = 10'd0;
				bonus_buffer_2 = bonus_2;
				b_flag_buf_2 = b_flag_2;		
			end

        
    /**************************************************************************************
        ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
        Hidden Question #2/2:
          Notice that player_y_pos is updated using player_y_motion. 
          Will the new value of player_y_motion be used when player_y_pos is updated, or the old? 
          What is the difference between writing
            "player_y_pos_in = player_y_pos + player_y_motion;" and 
            "player_y_pos_in = player_y_pos + player_y_motion_in;"?
          How will this impact behavior of the ball during a bounce, and how might that interact with a response to a keypress?
          Give an answer in your Post-Lab.
    **************************************************************************************/
		is_player = 0;
		is_player_2 = 0;
		stand_read_address = 0;
		stand_read_address_2 = 0;
				
		//draw the player1
		if(DrawX-player_x_pos >= 10'd0 && DrawX-player_x_pos <= player_x_size && DrawY-player_y_pos >= 10'd0 && DrawY-player_y_pos <= player_y_size)
		begin
				stand_read_address = (DrawX-player_x_pos) + (DrawY-player_y_pos)*player_x_size;
				is_player = 1;
		end
		//draw the player2
		if(DrawX-player2_x_pos >= 10'd0 && DrawX-player2_x_pos <= player_x_size && DrawY-player2_y_pos >= 10'd0 && DrawY-player2_y_pos <= player_y_size)
		begin
				stand_read_address_2 = (DrawX-player2_x_pos) + (DrawY-player2_y_pos) * player_x_size;
				is_player_2 = 1;
		end
				
        ////////////////////////draw floor tiles methods////////////////////////////
			  
		 if(DrawX-floor_1_X >= 10'd0 && DrawX-floor_1_X <= floor_X_size && DrawY-floor_1_Y >= 10'd0 && DrawY-floor_1_Y <= floor_Y_size)
		 begin
			floor_read_address = (DrawX-floor_1_X) + (DrawY-floor_1_Y)*floor_X_size;
			is_floor = 3'b001;
		 end
		 else if(DrawX-floor_2_X >= 10'd0 && DrawX-floor_2_X <= floor_X_size && DrawY-floor_2_Y >= 10'd0 && DrawY-floor_2_Y <= floor_Y_size)
		 begin
		   floor_read_address = (DrawX-floor_2_X) + (DrawY-floor_2_Y)*floor_X_size;
			is_floor = 3'b010;
		 end
		 else if(DrawX-floor_3_X >= 10'd0 && DrawX-floor_3_X <= floor_X_size && DrawY-floor_3_Y >= 10'd0 && DrawY-floor_3_Y <= floor_Y_size)
		 begin
		   floor_read_address = (DrawX-floor_3_X) + (DrawY-floor_3_Y)*floor_X_size;
			is_floor = 3'b011;
		 end
		 else if(DrawX-floor_4_X >= 10'd0 && DrawX-floor_4_X <= floor_X_size && DrawY-floor_4_Y >= 10'd0 && DrawY-floor_4_Y <= floor_Y_size)
		 begin
		   floor_read_address = (DrawX-floor_4_X) + (DrawY-floor_4_Y)*floor_X_size;
			is_floor = 3'b100;
		 end
		 else if(DrawX-floor_5_X >= 10'd0 && DrawX-floor_5_X <= floor_X_size && DrawY-floor_5_Y >= 10'd0 && DrawY-floor_5_Y <= floor_Y_size)
		 begin
		   floor_read_address = (DrawX-floor_5_X) + (DrawY-floor_5_Y)*floor_X_size;
			is_floor = 3'b101;
		 end 
		else 
		begin
			floor_read_address = 0;
			is_floor = 3'b000;
		end
			
			
		////////////////////player1: conditions on differet floors //////////////
		belt_step = 0;
		jump_step = 0;
		if(on_belt_floor == 2'b01 )
			belt_step = 2;
		if(on_belt_floor == 2'b10 )
			belt_step = -2;
		if(jump_state == 1)
			jump_step = -6;
			
		//////////////////player2//////////////////////////
		belt_step_2 = 0;
		jump_step_2 = 0;
		if(on_belt_floor_2 == 2'b01 )
			belt_step_2 = 2;
		if(on_belt_floor_2 == 2'b10 )
			belt_step_2 = -2;
		if(jump_state_2 == 1)
			jump_step_2 = -6;
			
        
    end
    
endmodule


