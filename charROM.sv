/////////////character////////


 //char ROM
module charROM
(
		input [18:0] char_read_address,
		input [3:0]  char_idx,
		input [18:0] ending_read_address,
		input [4:0] ending_idx,
		input [18:0] starting_read_address,
		input [4:0] starting_idx,
		input Clk,

		output logic [4:0] char_data_out,
		output logic [4:0] ending_data_out,
		output logic [4:0] starting_data_out
);

// mem has width of 4 bits and a total of 600 addresses
logic [4:0] mem_0 [0:1349];
logic [4:0] mem_1 [0:1349];
logic [4:0] mem_2 [0:1349];
logic [4:0] mem_3 [0:1349];
logic [4:0] mem_4 [0:1349];
logic [4:0] mem_5 [0:1349];
logic [4:0] mem_6 [0:1349];
logic [4:0] mem_7 [0:1349];
logic [4:0] mem_8 [0:1349];
logic [4:0] mem_9 [0:1349];
logic [4:0] mem_heart [0:1349];
logic [4:0] mem_half_heart [0:1349];
logic [4:0] mem_a [0:1349];
logic [4:0] mem_c [0:1349];
logic [4:0] mem_e [0:1349];
logic [4:0] mem_f [0:1349];
logic [4:0] mem_g [0:1349];
logic [4:0] mem_h [0:1349];
logic [4:0] mem_l [0:1349];
logic [4:0] mem_m [0:1349];
logic [4:0] mem_n [0:1349];
logic [4:0] mem_o [0:1349];
logic [4:0] mem_p [0:1349];
logic [4:0] mem_r [0:1349];
logic [4:0] mem_s [0:1349];
logic [4:0] mem_t [0:1349];
logic [4:0] mem_v [0:1349];
logic [4:0] mem_one [0:1349];
logic [4:0] mem_two [0:1349];
logic [4:0] mem_tro [0:1349];
logic [4:0] mem_p1 [0:1349];
logic [4:0] mem_p2 [0:1349];


initial
begin
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/0.txt", mem_0);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/1.txt", mem_1);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/2.txt", mem_2);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/3.txt", mem_3);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/4.txt", mem_4);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/5.txt", mem_5);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/6.txt", mem_6);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/7.txt", mem_7);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/8.txt", mem_8);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/9.txt", mem_9);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/heart.txt", mem_heart);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/half_heart.txt", mem_half_heart); 
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/A.txt", mem_a);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/C.txt", mem_c);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/E.txt", mem_e);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/F.txt", mem_f);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/G.txt", mem_g);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/H.txt", mem_h);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/L.txt", mem_l);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/M.txt", mem_m);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/N.txt", mem_n);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/O.txt", mem_o);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/P.txt", mem_p);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/R.txt", mem_r);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/S.txt", mem_s);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/T.txt", mem_t);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/V.txt", mem_v);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/one.txt", mem_one);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/two.txt", mem_two);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/trophy.txt", mem_tro);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/stand1.txt", mem_p1);
	 $readmemh("./ECE385-HelperTools-master/PNG To Hex/On-Chip Memory/sprite_bytes/stand2.txt", mem_p2);

end


always_ff @ (posedge Clk) begin
	if(char_idx == 0)
		char_data_out<= mem_0[char_read_address];
	else if(char_idx == 1)
		char_data_out<= mem_1[char_read_address];
	else if(char_idx == 2)
		char_data_out<= mem_2[char_read_address];
	else if(char_idx == 3)
		char_data_out<= mem_3[char_read_address];
	else if(char_idx == 4)
		char_data_out<= mem_4[char_read_address];
	else if(char_idx == 5)
		char_data_out<= mem_5[char_read_address];
	else if(char_idx == 6)
		char_data_out<= mem_6[char_read_address];
	else if(char_idx == 7)
		char_data_out<= mem_7[char_read_address];
	else if(char_idx == 8)
		char_data_out<= mem_8[char_read_address];
	else if(char_idx == 9)
		char_data_out<= mem_9[char_read_address];
	else if(char_idx == 10)
		char_data_out<= mem_heart[char_read_address];
	else if(char_idx == 11)
		char_data_out<= mem_half_heart[char_read_address];
	else 
		char_data_out<=0;
		
	////////////ending char//////////////
	if(ending_idx == 0)
		ending_data_out <= mem_0[ending_read_address];
	else if(ending_idx == 1)
		ending_data_out <= mem_1[ending_read_address];
	else if(ending_idx == 2)
		ending_data_out <= mem_2[ending_read_address];
	else if(ending_idx == 3)
		ending_data_out <= mem_3[ending_read_address];
	else if(ending_idx == 4)
		ending_data_out <= mem_4[ending_read_address];
	else if(ending_idx == 5)
		ending_data_out <= mem_5[ending_read_address];
	else if(ending_idx == 6)
		ending_data_out <= mem_6[ending_read_address];
	else if(ending_idx == 7)
		ending_data_out <= mem_7[ending_read_address];
	else if(ending_idx == 8)
		ending_data_out <= mem_8[ending_read_address];
	else if(ending_idx == 9)
		ending_data_out <= mem_9[ending_read_address];
	else if(ending_idx == 10)
		ending_data_out <= mem_g[ending_read_address];
	else if(ending_idx == 11)
		ending_data_out <= mem_a[ending_read_address];
	else if(ending_idx == 12)
		ending_data_out <= mem_m[ending_read_address];
	else if(ending_idx == 13)
		ending_data_out <= mem_e[ending_read_address];
	else if(ending_idx == 14)
		ending_data_out <= mem_o[ending_read_address];
	else if(ending_idx == 15)
		ending_data_out <= mem_v[ending_read_address];	
	else if(ending_idx == 16)
		ending_data_out <= mem_e[ending_read_address];
	else if(ending_idx == 17)
		ending_data_out <= mem_r[ending_read_address];	
	else if(ending_idx == 18)
		ending_data_out <= mem_p[ending_read_address];	
	else if(ending_idx == 19)
		ending_data_out <= mem_one[ending_read_address];	
	else if(ending_idx == 20)
		ending_data_out <= mem_p[ending_read_address];	
	else if(ending_idx == 21)
		ending_data_out <= mem_two[ending_read_address];	
	else if(ending_idx == 22)
		ending_data_out <= mem_tro[ending_read_address];	
	else if(ending_idx == 23)
		ending_data_out <= mem_tro[ending_read_address];
	else if(ending_idx == 24)
		ending_data_out <= mem_p1[ending_read_address];
	else if(ending_idx == 25)
		ending_data_out <= mem_p2[ending_read_address];
	else 
		ending_data_out <= 0;
		
	////////draw start char//////////
	if(starting_idx == 0)
		starting_data_out <= mem_n[starting_read_address];
	else if(starting_idx == 1)
		starting_data_out <= mem_s[starting_read_address];
	else if(starting_idx == 2)
		starting_data_out <= mem_s[starting_read_address];
	else if(starting_idx == 3)
		starting_data_out <= mem_h[starting_read_address];
	else if(starting_idx == 4)
		starting_data_out <= mem_a[starting_read_address];
	else if(starting_idx == 5)
		starting_data_out <= mem_f[starting_read_address];
	else if(starting_idx == 6)
		starting_data_out <= mem_t[starting_read_address];
	else if(starting_idx == 7)
		starting_data_out <= mem_p1[starting_read_address];
	else if(starting_idx == 8)
		starting_data_out <= mem_p2[starting_read_address];
	else 
		starting_data_out <= 0;
	
end


endmodule
