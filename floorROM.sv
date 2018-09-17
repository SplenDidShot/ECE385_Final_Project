module floorROM
(
		input [18:0] floor_read_address,
		input Clk,
		input [2:0] is_floor, 
		output logic [4:0] floor_data_out
);

// mem has width of 4 bits and a total of 2400 addresses
logic [4:0] normal_mem [0:2399];
logic [4:0] left_mem [0:2399];
logic [4:0] right_mem [0:2399];
logic [4:0] jump_mem [0:2399];
logic [4:0] spike_mem [0:2399];

logic [4:0] floor_buf;

initial
begin
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/normal.txt", normal_mem);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/roll_left.txt", left_mem);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/roll_right.txt", right_mem);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/spring.txt", jump_mem);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/spikes.txt", spike_mem);
	 
end
always_comb
begin
	floor_buf = 0;
	if(is_floor == 3'b001)
		floor_buf = normal_mem[floor_read_address];	
	else if(is_floor == 3'b010)
		floor_buf = right_mem[floor_read_address];
	else if(is_floor == 3'b011)
		floor_buf = left_mem[floor_read_address];
	else if(is_floor == 3'b100)
		floor_buf = jump_mem[floor_read_address];
	else if(is_floor == 3'b101)
		floor_buf = spike_mem[floor_read_address];
end

always_ff @ (posedge Clk) begin
	floor_data_out<= floor_buf;
end

endmodule