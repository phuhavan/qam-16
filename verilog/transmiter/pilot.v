module pilot
#(
	parameter width_data = 16
)
(
	input								clk1,//Doc du lieu vao
	input 							clk2,//Ghi du lieu ra
	input 							rst_n,
	input [width_data-1:0]		data_in,
	input								start,
	output [width_data-1:0]		data_out
);
	
	reg	[width_data-1:0]		data_in_r [0:399];//Thanh ghi luu tru kqua doc du lieu vao
	reg	[width_data-1:0]		data_out_r;//Thanh ghi luu tru kqua dau ra 
	reg								start_delay,start_delay1;//Lam tre start
	reg	[8:0]	count_out;
	reg	[8:0]	count_in;
	wire	[8:0]	sel_out;
	wire	[8:0]	sel_in;
	
	assign sel_in = count_in;
	assign sel_out = count_out;
	assign data_out = data_out_r;
	
	always @ (posedge clk1 or negedge rst_n)begin	//Xu ly start. start cho phep doc du lieu vao, 
		if(!rst_n)begin										//start_delay cho phep ghi du lieu ra, 
			start_delay<=0;									//muc dich la cho doc vao xay ra truoc khi doc ra
			start_delay1<=0;
		end
		else if(start) begin
			start_delay<=start;
			start_delay1<=start_delay;
		end
	end
	
	always @ (posedge clk1 or negedge rst_n)begin	//Tao bo dem du lieu vao
		if(!rst_n)begin
			count_in<=0;
		end
		else if(start_delay)begin
			if(count_in==9'd399) count_in<=0;
			else	count_in<=count_in+1;
		end
	end
	
	always @ (posedge clk1 or negedge rst_n)begin	//Dua du lieu vao
		if(!rst_n)begin
			data_in_r[0]<=0;
			data_in_r[1]<=0;
			data_in_r[2]<=0;
			data_in_r[3]<=0;
			data_in_r[4]<=0;
			data_in_r[5]<=0;
			data_in_r[6]<=0;
			data_in_r[7]<=0;
			data_in_r[8]<=0;
			data_in_r[9]<=0;
			data_in_r[10]<=0;
			data_in_r[11]<=0;
			data_in_r[12]<=0;
			data_in_r[13]<=0;
			data_in_r[14]<=0;
			data_in_r[15]<=0;
			data_in_r[16]<=0;
			data_in_r[17]<=0;
			data_in_r[18]<=0;
			data_in_r[19]<=0;
			data_in_r[20]<=0;
			data_in_r[21]<=0;
			data_in_r[22]<=0;
			data_in_r[23]<=0;
			data_in_r[24]<=0;
			data_in_r[25]<=0;
			data_in_r[26]<=0;
			data_in_r[27]<=0;
			data_in_r[28]<=0;
			data_in_r[29]<=0;
			data_in_r[30]<=0;
			data_in_r[31]<=0;
			data_in_r[32]<=0;
			data_in_r[33]<=0;
			data_in_r[34]<=0;
			data_in_r[35]<=0;
			data_in_r[36]<=0;
			data_in_r[37]<=0;
			data_in_r[38]<=0;
			data_in_r[39]<=0;
			data_in_r[40]<=0;
			data_in_r[41]<=0;
			data_in_r[42]<=0;
			data_in_r[43]<=0;
			data_in_r[44]<=0;
			data_in_r[45]<=0;
			data_in_r[46]<=0;
			data_in_r[47]<=0;
			data_in_r[48]<=0;
			data_in_r[49]<=0;
			data_in_r[50]<=0;
			data_in_r[51]<=0;
			data_in_r[52]<=0;
			data_in_r[53]<=0;
			data_in_r[54]<=0;
			data_in_r[55]<=0;
			data_in_r[56]<=0;
			data_in_r[57]<=0;
			data_in_r[58]<=0;
			data_in_r[59]<=0;
			data_in_r[60]<=0;
			data_in_r[61]<=0;
			data_in_r[62]<=0;
			data_in_r[63]<=0;
			data_in_r[64]<=0;
			data_in_r[65]<=0;
			data_in_r[66]<=0;
			data_in_r[67]<=0;
			data_in_r[68]<=0;
			data_in_r[69]<=0;
			data_in_r[70]<=0;
			data_in_r[71]<=0;
			data_in_r[72]<=0;
			data_in_r[73]<=0;
			data_in_r[74]<=0;
			data_in_r[75]<=0;
			data_in_r[76]<=0;
			data_in_r[77]<=0;
			data_in_r[78]<=0;
			data_in_r[79]<=0;
			data_in_r[80]<=0;
			data_in_r[81]<=0;
			data_in_r[82]<=0;
			data_in_r[83]<=0;
			data_in_r[84]<=0;
			data_in_r[85]<=0;
			data_in_r[86]<=0;
			data_in_r[87]<=0;
			data_in_r[88]<=0;
			data_in_r[89]<=0;
			data_in_r[90]<=0;
			data_in_r[91]<=0;
			data_in_r[92]<=0;
			data_in_r[93]<=0;
			data_in_r[94]<=0;
			data_in_r[95]<=0;
			data_in_r[96]<=0;
			data_in_r[97]<=0;
			data_in_r[98]<=0;
			data_in_r[99]<=0;
			data_in_r[100]<=0;
			data_in_r[101]<=0;
			data_in_r[102]<=0;
			data_in_r[103]<=0;
			data_in_r[104]<=0;
			data_in_r[105]<=0;
			data_in_r[106]<=0;
			data_in_r[107]<=0;
			data_in_r[108]<=0;
			data_in_r[109]<=0;
			data_in_r[110]<=0;
			data_in_r[111]<=0;
			data_in_r[112]<=0;
			data_in_r[113]<=0;
			data_in_r[114]<=0;
			data_in_r[115]<=0;
			data_in_r[116]<=0;
			data_in_r[117]<=0;
			data_in_r[118]<=0;
			data_in_r[119]<=0;
			data_in_r[120]<=0;
			data_in_r[121]<=0;
			data_in_r[122]<=0;
			data_in_r[123]<=0;
			data_in_r[124]<=0;
			data_in_r[125]<=0;
			data_in_r[126]<=0;
			data_in_r[127]<=0;
			data_in_r[128]<=0;
			data_in_r[129]<=0;
			data_in_r[130]<=0;
			data_in_r[131]<=0;
			data_in_r[132]<=0;
			data_in_r[133]<=0;
			data_in_r[134]<=0;
			data_in_r[135]<=0;
			data_in_r[136]<=0;
			data_in_r[137]<=0;
			data_in_r[138]<=0;
			data_in_r[139]<=0;
			data_in_r[140]<=0;
			data_in_r[141]<=0;
			data_in_r[142]<=0;
			data_in_r[143]<=0;
			data_in_r[144]<=0;
			data_in_r[145]<=0;
			data_in_r[146]<=0;
			data_in_r[147]<=0;
			data_in_r[148]<=0;
			data_in_r[149]<=0;
			data_in_r[150]<=0;
			data_in_r[151]<=0;
			data_in_r[152]<=0;
			data_in_r[153]<=0;
			data_in_r[154]<=0;
			data_in_r[155]<=0;
			data_in_r[156]<=0;
			data_in_r[157]<=0;
			data_in_r[158]<=0;
			data_in_r[159]<=0;
			data_in_r[160]<=0;
			data_in_r[161]<=0;
			data_in_r[162]<=0;
			data_in_r[163]<=0;
			data_in_r[164]<=0;
			data_in_r[165]<=0;
			data_in_r[166]<=0;
			data_in_r[167]<=0;
			data_in_r[168]<=0;
			data_in_r[169]<=0;
			data_in_r[170]<=0;
			data_in_r[171]<=0;
			data_in_r[172]<=0;
			data_in_r[173]<=0;
			data_in_r[174]<=0;
			data_in_r[175]<=0;
			data_in_r[176]<=0;
			data_in_r[177]<=0;
			data_in_r[178]<=0;
			data_in_r[179]<=0;
			data_in_r[180]<=0;
			data_in_r[181]<=0;
			data_in_r[182]<=0;
			data_in_r[183]<=0;
			data_in_r[184]<=0;
			data_in_r[185]<=0;
			data_in_r[186]<=0;
			data_in_r[187]<=0;
			data_in_r[188]<=0;
			data_in_r[189]<=0;
			data_in_r[190]<=0;
			data_in_r[191]<=0;
			data_in_r[192]<=0;
			data_in_r[193]<=0;
			data_in_r[194]<=0;
			data_in_r[195]<=0;
			data_in_r[196]<=0;
			data_in_r[197]<=0;
			data_in_r[198]<=0;
			data_in_r[199]<=0;
			data_in_r[200]<=0;
			data_in_r[201]<=0;
			data_in_r[202]<=0;
			data_in_r[203]<=0;
			data_in_r[204]<=0;
			data_in_r[205]<=0;
			data_in_r[206]<=0;
			data_in_r[207]<=0;
			data_in_r[208]<=0;
			data_in_r[209]<=0;
			data_in_r[210]<=0;
			data_in_r[211]<=0;
			data_in_r[212]<=0;
			data_in_r[213]<=0;
			data_in_r[214]<=0;
			data_in_r[215]<=0;
			data_in_r[216]<=0;
			data_in_r[217]<=0;
			data_in_r[218]<=0;
			data_in_r[219]<=0;
			data_in_r[220]<=0;
			data_in_r[221]<=0;
			data_in_r[222]<=0;
			data_in_r[223]<=0;
			data_in_r[224]<=0;
			data_in_r[225]<=0;
			data_in_r[226]<=0;
			data_in_r[227]<=0;
			data_in_r[228]<=0;
			data_in_r[229]<=0;
			data_in_r[230]<=0;
			data_in_r[231]<=0;
			data_in_r[232]<=0;
			data_in_r[233]<=0;
			data_in_r[234]<=0;
			data_in_r[235]<=0;
			data_in_r[236]<=0;
			data_in_r[237]<=0;
			data_in_r[238]<=0;
			data_in_r[239]<=0;
			data_in_r[240]<=0;
			data_in_r[241]<=0;
			data_in_r[242]<=0;
			data_in_r[243]<=0;
			data_in_r[244]<=0;
			data_in_r[245]<=0;
			data_in_r[246]<=0;
			data_in_r[247]<=0;
			data_in_r[248]<=0;
			data_in_r[249]<=0;
			data_in_r[250]<=0;
			data_in_r[251]<=0;
			data_in_r[252]<=0;
			data_in_r[253]<=0;
			data_in_r[254]<=0;
			data_in_r[255]<=0;
			data_in_r[256]<=0;
			data_in_r[257]<=0;
			data_in_r[258]<=0;
			data_in_r[259]<=0;
			data_in_r[260]<=0;
			data_in_r[261]<=0;
			data_in_r[262]<=0;
			data_in_r[263]<=0;
			data_in_r[264]<=0;
			data_in_r[265]<=0;
			data_in_r[266]<=0;
			data_in_r[267]<=0;
			data_in_r[268]<=0;
			data_in_r[269]<=0;
			data_in_r[270]<=0;
			data_in_r[271]<=0;
			data_in_r[272]<=0;
			data_in_r[273]<=0;
			data_in_r[274]<=0;
			data_in_r[275]<=0;
			data_in_r[276]<=0;
			data_in_r[277]<=0;
			data_in_r[278]<=0;
			data_in_r[279]<=0;
			data_in_r[280]<=0;
			data_in_r[281]<=0;
			data_in_r[282]<=0;
			data_in_r[283]<=0;
			data_in_r[284]<=0;
			data_in_r[285]<=0;
			data_in_r[286]<=0;
			data_in_r[287]<=0;
			data_in_r[288]<=0;
			data_in_r[289]<=0;
			data_in_r[290]<=0;
			data_in_r[291]<=0;
			data_in_r[292]<=0;
			data_in_r[293]<=0;
			data_in_r[294]<=0;
			data_in_r[295]<=0;
			data_in_r[296]<=0;
			data_in_r[297]<=0;
			data_in_r[298]<=0;
			data_in_r[299]<=0;
			data_in_r[300]<=0;
			data_in_r[301]<=0;
			data_in_r[302]<=0;
			data_in_r[303]<=0;
			data_in_r[304]<=0;
			data_in_r[305]<=0;
			data_in_r[306]<=0;
			data_in_r[307]<=0;
			data_in_r[308]<=0;
			data_in_r[309]<=0;
			data_in_r[310]<=0;
			data_in_r[311]<=0;
			data_in_r[312]<=0;
			data_in_r[313]<=0;
			data_in_r[314]<=0;
			data_in_r[315]<=0;
			data_in_r[316]<=0;
			data_in_r[317]<=0;
			data_in_r[318]<=0;
			data_in_r[319]<=0;
			data_in_r[320]<=0;
			data_in_r[321]<=0;
			data_in_r[322]<=0;
			data_in_r[323]<=0;
			data_in_r[324]<=0;
			data_in_r[325]<=0;
			data_in_r[326]<=0;
			data_in_r[327]<=0;
			data_in_r[328]<=0;
			data_in_r[329]<=0;
			data_in_r[330]<=0;
			data_in_r[331]<=0;
			data_in_r[332]<=0;
			data_in_r[333]<=0;
			data_in_r[334]<=0;
			data_in_r[335]<=0;
			data_in_r[336]<=0;
			data_in_r[337]<=0;
			data_in_r[338]<=0;
			data_in_r[339]<=0;
			data_in_r[340]<=0;
			data_in_r[341]<=0;
			data_in_r[342]<=0;
			data_in_r[343]<=0;
			data_in_r[344]<=0;
			data_in_r[345]<=0;
			data_in_r[346]<=0;
			data_in_r[347]<=0;
			data_in_r[348]<=0;
			data_in_r[349]<=0;
			data_in_r[350]<=0;
			data_in_r[351]<=0;
			data_in_r[352]<=0;
			data_in_r[353]<=0;
			data_in_r[354]<=0;
			data_in_r[355]<=0;
			data_in_r[356]<=0;
			data_in_r[357]<=0;
			data_in_r[358]<=0;
			data_in_r[359]<=0;
			data_in_r[360]<=0;
			data_in_r[361]<=0;
			data_in_r[362]<=0;
			data_in_r[363]<=0;
			data_in_r[364]<=0;
			data_in_r[365]<=0;
			data_in_r[366]<=0;
			data_in_r[367]<=0;
			data_in_r[368]<=0;
			data_in_r[369]<=0;
			data_in_r[370]<=0;
			data_in_r[371]<=0;
			data_in_r[372]<=0;
			data_in_r[373]<=0;
			data_in_r[374]<=0;
			data_in_r[375]<=0;
			data_in_r[376]<=0;
			data_in_r[377]<=0;
			data_in_r[378]<=0;
			data_in_r[379]<=0;
			data_in_r[380]<=0;
			data_in_r[381]<=0;
			data_in_r[382]<=0;
			data_in_r[383]<=0;
			data_in_r[384]<=0;
			data_in_r[385]<=0;
			data_in_r[386]<=0;
			data_in_r[387]<=0;
			data_in_r[388]<=0;
			data_in_r[389]<=0;
			data_in_r[390]<=0;
			data_in_r[391]<=0;
			data_in_r[392]<=0;
			data_in_r[393]<=0;
			data_in_r[394]<=0;
			data_in_r[395]<=0;
			data_in_r[396]<=0;
			data_in_r[397]<=0;
			data_in_r[398]<=0;
			data_in_r[399]<=0;
		end
		else if(start_delay) begin
				data_in_r[sel_in]	<= data_in;
		end
	end
	
	always @ (posedge clk2 or negedge rst_n)begin	//Tao bo dem du lieu ra
		if(!rst_n)begin
			count_out<=0;
		end
		else if(start_delay1) begin
			if(count_out==9'd409)	count_out<=0;
			else	count_out<=count_out+1;
		end
	end
	
	always @ (posedge clk2 or negedge rst_n)begin	//Dua du lieu ra
		if(!rst_n)begin
			data_out_r<=0;
		end
		else if(start_delay1) begin
			if(sel_out<9'd10) data_out_r<={1'b0,3'b111,12'b0};
			else	data_out_r<=data_in_r[sel_out-9'd10][width_data-1:0];
		end
	end
	
endmodule
