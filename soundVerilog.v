module top (LDATA, RDATA,Clk,Reset, INIT, INIT_FINISH, adc_full, data_over, AUD_MCLK, AUD_BCLK, AUD_ADCDAT, AUD_DACDAT, AUD_DACLRCK, AUD_ADCLRCK, I2C_SDAT, I2C_SCLK, ADCDATA);
		input [15:0]LDATA, RDATA;
		input Clk, Reset, INIT; 
		output INIT_FINISH;
		output adc_full;
		output data_over;
		output AUD_MCLK;
		input AUD_BCLK;
		input AUD_ADCDAT;
		output AUD_DACDAT;
		input AUD_DACLRCK, AUD_ADCLRCK;
		output I2C_SDAT;
		output I2C_SCLK;
		output ADCDATA;
		audio_interface audio (.Clk(Clk), .Reset(Reset),
													.AUD_BCLK(AUD_BCLK), 			  //Digital audio bit clock
													.AUD_ADCDAT(AUD_ADCDAT),  		  //ADC data line
													.AUD_DACLRCK(AUD_DACLRCK),		  	  //DAC data left/right select
													.AUD_ADCLRCK(AUD_ADCLRCK), 		  //ADC data left/right select
													.INIT(INIT), .LDATA(LDATA), .RDATA(RDATA),
													.AUD_MCLK(AUD_MCLK),			  //Codec master clock OUTPUT
													.AUD_DACDAT(AUD_DACDAT), 		  //DAC data line
													.I2C_SDAT(I2C_SDAT), 			  //Serial interface data line
													.I2C_SCLK(I2C_SCLK),			  //Serial interface clock
													.INIT_FINISH(INIT_FINISH),
													.adc_full(adc_full), 
													.data_over(data_over),
													.ADCDATA(ADCDATA));
		
endmodule

