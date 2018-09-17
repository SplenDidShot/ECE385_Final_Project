//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.
module  color_mapper ( 
							  input        [2:0]is_floor,					//whether it is floor
                       input        [9:0] DrawX, DrawY,       // Current pixel coordinates
							  input 			[4:0] stand_data_out,		//player image
							  input			[4:0] stand_data_out_2,
							  input 			[4:0] floor_data_out,		//floor image
							  input 			[4:0] char_data_out,
							  input 			is_char,
							  input        [1:0]game_state,
							  input 			[4:0] bg_data_out,
							  input 			[1:0] is_bg,
							  input 			is_player, is_player_2,
							  input 			is_ending,
							  input 			[4:0] ending_data_out,
							  input        is_starting,
							  input        [4:0] starting_data_out,
                       output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    logic [7:0] Red, Green, Blue;
    
    // Output colors to VGA
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
	 
	 logic [23:0]stand_palette_hex [27];
	assign stand_palette_hex [0] =  24'h000000;
	assign stand_palette_hex [1] =  24'hFFFFFF;
	assign stand_palette_hex [2] =  24'hC36633;
	assign stand_palette_hex [3] =  24'hC5A400;
	assign stand_palette_hex [4] =  24'h651C0F;
	assign stand_palette_hex [5] =  24'hA51914;
	assign stand_palette_hex [6] =  24'hE3D4D4;
	assign stand_palette_hex [7] =  24'hCD827E;
	assign stand_palette_hex [8] =  24'h976E5A;
	assign stand_palette_hex [9] =  24'h604A2F;
	assign stand_palette_hex [10] =  24'h7B4118;
	assign stand_palette_hex [11] =  24'hB3392B;
	assign stand_palette_hex [12] =  24'hFC4D66;
	assign stand_palette_hex [13] =  24'h3D72A0;
	assign stand_palette_hex [14] =  24'h7499CD;
	assign stand_palette_hex [15] =  24'hB4E3FF;
	assign stand_palette_hex [16] =  24'h6F94D2;
	assign stand_palette_hex [17] =  24'h4D70B1;
	assign stand_palette_hex [18] =  24'h2A3032;
	assign stand_palette_hex [19] =  24'hA3A8A5;
	assign stand_palette_hex [20] =  24'hF9FF00;
	assign stand_palette_hex [21] =  24'h52CE4F;
	assign stand_palette_hex [22] =  24'h5BAA90;
	assign stand_palette_hex [23] =  24'h48887E;
	assign stand_palette_hex [24] =  24'hFFC7BD;
	assign stand_palette_hex [25] =  24'hFFC7BD;
	assign stand_palette_hex [26] =  24'hFFC7BD;
	
	logic [23:0]player_color;
	logic [23:0]player_color_2;
	logic [23:0]floor_color;
	logic [23:0]char_color;
	logic [23:0]ending_color;
	logic [23:0]starting_color;
	logic [23:0]bg_color;
	 assign player_color = stand_palette_hex[stand_data_out];
	 assign player_color_2 = stand_palette_hex[stand_data_out_2];
	 assign floor_color = stand_palette_hex[floor_data_out];
	 assign char_color = stand_palette_hex[char_data_out];
	 assign ending_color = stand_palette_hex[ending_data_out];
	 assign starting_color = stand_palette_hex[starting_data_out];
	 assign bg_color = stand_palette_hex[bg_data_out];
    
    // Assign color based on is_ball signal
    always_comb
    begin
	 	  ////////////////draw the startup menu////////////
		  if (game_state == 2'b00 && is_starting != 0)
		  begin
				Red = starting_color[23:16];
				Green = starting_color[15:8];
				Blue = starting_color[7:0];
		  end
		  else if (game_state == 2'b00)
		  begin
				Red = 8'h00;
				Green = 8'h00;
				Blue = 8'h00;
		  end
		  ////////////////////ending char//////////////
		  else if (game_state == 2'b10 && is_ending != 0)
		  begin
				Red = ending_color[23:16];
				Green = ending_color[15:8];
				Blue = ending_color[7:0];
		  end
		  ///////////////draw the game over panel////////////
		  else if (game_state == 2'b10)
			begin
				Red = 8'h00;
				Green = 8'h00;
				Blue = 8'h00;
			end
	 	 ////////////////draw the player1/////////  
        else if (is_player != 0 && stand_data_out != 0)
			begin
				Red = player_color[23:16];
				Green = player_color[15:8];
				Blue = player_color[7:0];
			end
		////////////////draw the player2/////////  
        else if (is_player_2 != 0 && stand_data_out_2 != 0)
			begin
				Red = player_color_2[23:16];
				Green = player_color_2[15:8];
				Blue = player_color_2[7:0];
			end
		////////////////////draw the floor///////////  
	     else if (is_floor != 0 && floor_data_out != 0) 
        begin
            // black floor
				Red = floor_color[23:16];
				Green = floor_color[15:8];
				Blue = floor_color[7:0];
        end
		  
		  /////////////////draw the characters////////
		  else if (is_char != 0 && char_data_out != 0)
		  begin
				Red = char_color[23:16];
				Green = char_color[15:8];
				Blue = char_color[7:0];  
		  end
			///////////////fill background////////////////
        else 
        begin
            // Background with nice color gradient
				if(is_bg != 0 && bg_data_out != 0)
				begin
					Red = bg_color[23:16];
					Green = bg_color[15:8];
					Blue = bg_color[7:0];
				end
				else if(is_bg == 2)
				begin
					Red = 8'h0E;
					Green = 8'hBF;
					Blue = 8'h0E9;
				end
				else if(is_bg == 3)
				begin
					Red = 8'hFA;
					Green = 8'h80;
					Blue = 8'h072;
				end
				else 	
				begin
					Red = 8'h3f; 
					Green = 8'h00;
					Blue = 8'h7f - {1'b0, DrawX[9:3]};
				end
        end


    end 

    
endmodule
