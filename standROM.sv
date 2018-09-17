/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

module standROM
(
		input [18:0] stand_read_address, stand_read_address_2,
		input Clk,
		input is_player, is_player_2,

		output logic [4:0] stand_data_out,
		output logic [4:0] stand_data_out_2
);

// mem has width of 4 bits and a total of 600 addresses
logic [4:0] mem_stand2 [0:1349];
logic [4:0] mem_stand1 [0:1349];

initial
begin
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/stand2.txt", mem_stand2);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/stand1.txt", mem_stand1);
end


always_ff @ (posedge Clk) begin
	stand_data_out = 0;
	stand_data_out_2 = 0;
	if(is_player)
		stand_data_out<= mem_stand1[stand_read_address];
	if(is_player_2)
		stand_data_out_2<= mem_stand2[stand_read_address_2];
end

endmodule
