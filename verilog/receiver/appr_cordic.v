/*
	Lam tron (I,Q)->(I',Q') dua ve diem gan nhat tren chom sao
*/
module appr_cordic	
#(
	parameter width_in = 18,	//data width_in
	parameter width_out = 16	//data width_out
)
(
	input	signed	[width_in-1:0]	x_in,
	input	signed	[width_in-1:0]	y_in,
	input									start,
	input									clk,
	input									rst_n,
	output			[width_out-1:0] x_out,
	output			[width_out-1:0] y_out,
	output			[width_out-1:0] phi_right
);

	reg			[width_out-1:0] buffer_x1,buffer_x2,buffer_y1,buffer_y2,buffer_phi1,buffer_phi2;//Dem du lieu de dam bao chac chan khong bi mat sau 16 chu ki
	reg			[width_out-1:0] x_temp,y_temp,phi_temp;
	
	assign	x_out = buffer_x2;
	assign	y_out = buffer_y2;
	assign	phi_right=buffer_phi2;
	
	always @ (x_in)begin// lam tron x_in
		if((x_in<-18'd8192)&&(x_in[width_in-1])) begin	//<-2 va x_in am
			x_temp=-16'd12288;//=-3
		end
		else if((x_in>=-18'd8192)&&(x_in[width_in-1])) begin//-2<=x_in && x_in la so am
			x_temp=-16'd4096;//=-1
		end
		else if((x_in>=18'd0) && (x_in<18'd8192) && (~x_in[width_in-1]))begin//0<=x_in<2 va x_in duong
			x_temp=16'd4096;//=1
		end
		else begin
			x_temp=16'd12288;//=3
		end
	end
	
	always @ (y_in)begin// lam tron y_in
		if((y_in<-18'd8192)&&(y_in[width_in-1])) begin	//<-2 va y_in am
			y_temp=-16'd12288;//=-3
		end
		else if((y_in>=-18'd8192)&&(y_in[width_in-1])) begin//-2<=y_in va y_in am
			y_temp=-16'd4096;//=-1
		end
		else if((y_in>=18'd0) && (y_in<18'd8192) && (~y_in[width_in-1]))begin//0<=y_in<2 va y_in duong
			y_temp=16'd4096;//=1
		end
		else begin
			y_temp=16'd12288;//=3
		end
	end
	
	always @ (x_temp or y_temp)begin
		if(((x_temp==16'd4096)&&(y_temp==16'd4096)) || ((x_temp==16'd12288)&&(y_temp==16'd12288)))begin
			phi_temp=16'd3217;
		end
		else if(((x_temp==-16'd4096)&&(y_temp==-16'd4096)) || ((x_temp==-16'd12288)&&(y_temp==-16'd12288)))begin
			phi_temp=16'd16085;
		end
		else if(((x_temp==-16'd4096)&&(y_temp==16'd4096)) || ((x_temp==-16'd12288)&&(y_temp==16'd12288)))begin
			phi_temp=16'd9651;
		end
		else if(((x_temp==16'd4096)&&(y_temp==-16'd4096)) || ((x_temp==16'd12288)&&(y_temp==-16'd12288)))begin
			phi_temp=16'd22519;
		end
		else if ((x_temp==16'd12288)&&(y_temp==16'd4096))begin
			phi_temp=16'd1318;
		end	
		else if ((x_temp==-16'd12288)&&(y_temp==-16'd4096))begin
			phi_temp=16'd14186;
		end
		else if ((x_temp==16'd4096)&&(y_temp==16'd12288))begin
			phi_temp=16'd5116;
		end
		else if ((x_temp==-16'd4096)&&(y_temp==-16'd12288))begin
			phi_temp=16'd17984;
		end
		else if ((x_temp==-16'd4096)&&(y_temp==16'd12288))begin
			phi_temp=16'd7752;
		end
		else if ((x_temp==16'd4096)&&(y_temp==-16'd12288))begin
			phi_temp=16'd20619;
		end
		else if ((x_temp==-16'd12288)&&(y_temp==16'd4096))begin
			phi_temp=16'd11550;
		end
		else begin
			phi_temp=16'd24418;
		end
	end
	
	always @ (posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			buffer_x1<=0;
			buffer_x2<=0;
			buffer_y1<=0;
			buffer_y2<=0;
			buffer_phi1<=0;
			buffer_phi2<=0;
		end
		else if(start)begin
			buffer_x1<=x_temp;
			buffer_x2<=buffer_x1;
			buffer_y1<=y_temp;
			buffer_y2<=buffer_y1;
			buffer_phi1<=phi_temp;
			buffer_phi2<=buffer_phi1;
		end
	end
	
endmodule
