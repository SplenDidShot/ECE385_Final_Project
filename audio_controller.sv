module audio_controller(	
									input logic Clk, Reset, INIT_FINISH,  data_over, 
									output logic INIT,
									output [20:0] idx
									);
									


enum logic [3:0] {IDLE, DAC, NEWDATA} State, Next_State;

//logic [20:0] idx, a;
//logic [15:0] aud_buf;
logic [20:0] idx_buf; 
//logic [15:0] aud_dat;

//hexes hexd(.*);



always_ff @(posedge Clk)
begin
	if(Reset)
	begin
		State <= IDLE;
		idx <= 0;
	end
	else
	begin
		State <= Next_State;
		if(idx>=20'd192000)
			idx<=0;
		else
			idx <= idx_buf;
	end
end


always_comb
begin
	Next_State = State;
	unique case(State)
		IDLE:
		begin
			if(INIT_FINISH)
				Next_State = DAC;
		end
		DAC:
		begin
			if(data_over)
				Next_State = NEWDATA;
		end
		NEWDATA:
			if(!data_over)
			begin
				Next_State = DAC;
			end
		default:;
			
	endcase
	INIT = 1;
	idx_buf = idx + data_over;
end

endmodule
