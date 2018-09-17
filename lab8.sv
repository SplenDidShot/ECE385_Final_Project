//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab8( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
				 input		  	[5:0]SW,
             output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK,	  //SDRAM Clock
				 //audio interface IO
				 input logic  AUD_BCLK, 
								  AUD_ADCDAT, 
								  AUD_DACLRCK, 
								  AUD_ADCLRCK, 
				 
				 output logic AUD_XCK, 
								  I2C_SDAT, 
								  I2C_SCLK, 
								  AUD_DACDAT
                    );
    
    logic Reset_h, Clk;
    logic [15:0] keycode;
    logic left, right;
	 logic game_start, game_exit, game_menu, game_restart, game_exit_2;
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
		  left <= ~KEY[3];
		  right <= ~KEY[2];
		  game_start <= SW[0];
		  //game_exit <= SW[1];
		  game_menu <= SW[2];
		  game_restart <= SW[3];
		  
    end
    
    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs;
    
    // Interface between NIOS II and EZ-OTG chip
    hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),    
                            .OTG_ADDR(OTG_ADDR),    
                            .OTG_RD_N(OTG_RD_N),    
                            .OTG_WR_N(OTG_WR_N),    
                            .OTG_CS_N(OTG_CS_N),    
                            .OTG_RST_N(OTG_RST_N)
    );
     logic [31:0] FLOOR_EXPORT_DATA;
     // You need to make sure that the port names here match the ports in Qsys-generated codes.
     nios_system nios_system(
                             .clk_clk(Clk),         
                             .reset_reset_n(1'b1),    // Never reset NIOS
                             .sdram_wire_addr(DRAM_ADDR), 
                             .sdram_wire_ba(DRAM_BA),   
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),  
                             .sdram_wire_cs_n(DRAM_CS_N), 
                             .sdram_wire_dq(DRAM_DQ),   
                             .sdram_wire_dqm(DRAM_DQM),  
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N), 
                             .sdram_clk_clk(DRAM_CLK),
                             .keycode_export(keycode),  
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w),
									 
    );
  
    // Use PLL to generate the 25MHZ VGA_CLK. Do not modify it.
    // vga_clk vga_clk_instance(
    //     .clk_clk(Clk),
    //     .reset_reset_n(1'b1),
    //     .altpll_0_c0_clk(VGA_CLK),
    //     .altpll_0_areset_conduit_export(),    
    //     .altpll_0_locked_conduit_export(),
    //     .altpll_0_phasedone_conduit_export()
    // );
    always_ff @ (posedge Clk) begin
        if(Reset_h)
            VGA_CLK <= 1'b0;
        else
            VGA_CLK <= ~VGA_CLK;
    end
    
    // TODO: Fill in the connections for the rest of the modules 
	 logic [9:0] DrawX, DrawY;
	 logic [2:0]is_floor;
    VGA_controller vga_controller_instance(.Reset(Reset_h), .*);
	 
    logic [9:0] floor_x[5];
	 logic [9:0] floor_y[5];
	 logic [18:0] stand_read_address;
	 logic [18:0] stand_read_address_2;
	 logic [4:0] stand_data_out;
	 logic [4:0] stand_data_out_2;
	 logic [18:0] floor_read_address;
	 logic [4:0] floor_data_out;
	 logic is_player, is_player_2;
	 logic [18:0] bg_read_address;
	 logic [4:0] bg_data_out;
	 logic [1:0]is_bg;
	 logic [3:0]hp;
	 logic [3:0]hp_2;
	 logic spike_floor_stat;
	 logic spike_floor_stat_2;

    // Which signal should be frame_clk?
	 floor floor_instance(.Reset(~(KEY[1]) | game_reset), .frame_clk(VGA_VS), .*); 
    ball ball_instance(.Reset(~(KEY[1]) | game_reset), .frame_clk(VGA_VS), .KEY, .SW(SW[5:4]), .*);
    
	 standROM stand(.*);
	 floorROM floor(.*);
	 bgCreate bg_create(.*);
 	 bgROM bg(.*);
    color_mapper color_instance(.*);
    
	 //score keeping
	 logic [3:0]score0, score1, score2, score3;
	 logic [3:0]score0_2, score1_2, score2_2, score3_2;
	 logic is_char;
	 logic [3:0] char_idx;
	 logic[18:0] char_read_address;
	 logic [4:0] char_data_out;
	 logic [13:0] bonus;
	 logic [13:0] bonus_2;
	 logic [18:0] ending_read_address;
	 logic [4:0] ending_idx;
	 logic is_ending;
	 logic [4:0] ending_data_out;
	 logic [1:0]is_winner;
	 logic is_starting;
	 logic [4:0] starting_idx;
	 logic [18:0] starting_read_address;
	 logic [4:0] starting_data_out;
	 logic [1:0] direction;
	 
	 score_keeper score_player1(.Reset(score_reset),.*);
	 scoreboard board (.*);
	 charROM character (.*);
	 game_over draw_ending (.*);
	 game_start draw_start (.*);
    // Display keycode on hex display
    HexDriver hex_inst_0 (right, HEX0);
    HexDriver hex_inst_1 (left, HEX1);
	 HexDriver hex_inst_2 (score0, HEX2);
	 HexDriver hex_inst_3 (score1, HEX3);
	 HexDriver hex_inst_4 (score2, HEX4);
	 HexDriver hex_inst_5 (score3, HEX5);
	 HexDriver hex_inst_6 (direction[0], HEX6);
	 HexDriver hex_inst_7 (direction[1], HEX7);
	 
	 /////////////////game state controller////////////////
	 logic [1:0] game_state;
	 logic game_reset, score_reset;
	 state_controller game_controller(.Reset(Reset_h), .*);
	 
	 
	 //////////////sound control/////////////

		logic	[31:0] ADCDATA;	 
	 	logic [15:0] LDATA, RDATA;
		logic INIT, INIT_FINISH, adc_full, data_over;
		logic [15:0] aud_dat;
		logic [20:0] idx;
		
		hexes hexd(.*);
		audio_controller audioc(.Reset(~game_state[0]),.*);

	 	audio_interface sound(.Clk(Clk), .Reset(~game_state[0]), .INIT(INIT), .INIT_FINISH(INIT_FINISH), 
									 .LDATA(LDATA), .RDATA(RDATA), .ADCDATA(ADCDATA), .adc_full(adc_full), .data_over(data_over), 
									 .AUD_DACLRCK(AUD_DACLRCK), .AUD_ADCLRCK(AUD_ADCLRCK),
									 .AUD_BCLK(AUD_BCLK), .AUD_ADCDAT(AUD_ADCDAT), .AUD_MCLK(AUD_XCK), .I2C_SDAT(I2C_SDAT), 
									 .I2C_SCLK(I2C_SCLK), .AUD_DACDAT(AUD_DACDAT));
   
    /**************************************************************************************
        ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
        Hidden Question #1/2:
        What are the advantages and/or disadvantages of using a USB interface over PS/2 interface to
             connect to the keyboard? List any two.  Give an answer in your Post-Lab.
    **************************************************************************************/
endmodule

