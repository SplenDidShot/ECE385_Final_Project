module testbench(input SW);

timeunit 10ns;
timeprecision 1ns;

logic Reset, game_exit, game_exit_2, game_start,game_restart,game_menu, game_reset, score_reset;			
logic [3:0] hp;
logic [1:0] game_state;
state_controller control(.*);
logic Clk = 0;
integer	errors;

always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 

initial begin: TEST_VECTORS
 game_exit = 0;
 game_exit_2 = 0;
 game_start = 0;
 game_restart = 0;
 game_menu = 0;
 #1 Reset = 1;
 #1 Reset = 0;
 errors = 0;
	if(game_state != 2'b00)
		errors++;
		
	#5 game_start = 1;
	#5 game_start = 0;
	
	if(game_state != 2'b01)
		errors++;
	
	#5 game_exit = 1;
	#5 game_exit_2 = 1;

	#10 if(game_state != 2'b10)
		errors++;
		
	#5 game_exit = 0;
	#5 game_exit_2 = 0;
	#5 game_restart = 1;
	#5 game_restart = 0;
	
	#10 if(game_state != 2'b01)
		errors++;
		

	
	#5 game_exit_2 = 1;
	#5 game_exit = 1;
	
	#10 if(game_state != 2'b10)
		errors++;
	
	#5 game_exit_2 = 0;
	#5 game_exit = 0;
	
	#5 game_menu = 1;
	#5 game_menu = 0;
	
	if(game_state != 2'b00)
		errors++;
	
	if(errors == 0)
		$display("Success!");


end
endmodule
