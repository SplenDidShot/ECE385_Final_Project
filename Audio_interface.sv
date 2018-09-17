module Audio(input logic [15:0] LDATA, RDATA,
							  input logic		Clk, Reset,
													AUD_BCLK, 			  //Digital audio bit clock
													AUD_ADCDAT,  		  //ADC data line
													AUD_DACLRCK,		  	  //DAC data left/right select
													AUD_ADCLRCK, 		  //ADC data left/right select
													INIT,
													
							  output logic	[31:0] ADCDATA,		  
							  output logic 	AUD_MCLK,			  //Codec master clock OUTPUT
													AUD_DACDAT, 		  //DAC data line
													I2C_SDAT, 			  //Serial interface data line
													I2C_SCLK,			  //Serial interface clock
													INIT_FINISH,
													adc_full, 
													data_over
													);
	audio_interface audio(.Clk(Clk), .Reset(Reset),
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
