module hexes(input logic Clk,
				 input logic[20:0] idx,
				 output logic[15:0] LDATA, RDATA
					);

			
logic [15:0]aud_dat;

always_comb
begin
	LDATA = aud_dat;
	RDATA = aud_dat;
end
always_ff@(posedge Clk)
begin
if(idx<20'd48000)
	aud_dat <= 16'h5FFF;
else if(idx<20'd96000)
	aud_dat <= 16'h8000;
else if(idx<20'd144000)
	aud_dat <= 16'hAA83;
else
	aud_dat <= 16'hE84A;

end

endmodule
