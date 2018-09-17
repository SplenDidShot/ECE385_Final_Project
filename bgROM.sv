/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */

 //background ROM
module bgROM
(
		input [18:0] bg_read_address,
		input Clk,
		input [1:0] is_bg,

		output logic [4:0] bg_data_out
);

// mem has width of 4 bits and a total of 600 addresses
logic [4:0] mem_bg [0:153599];
logic [4:0] mem_p1 [0:76799];
logic [4:0] mem_p2 [0:76799];

initial
begin
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/nbg.txt", mem_bg);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/p1.txt", mem_p1);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/p2.txt", mem_p2);
end


always_ff @ (posedge Clk)
begin
	bg_data_out = 0;
	if(is_bg == 1)
		bg_data_out <= mem_bg[bg_read_address];
	else 	if(is_bg == 2)
		bg_data_out <= mem_p1[bg_read_address];
	else 	if(is_bg == 3)
		bg_data_out <= mem_p2[bg_read_address];
end


endmodule
