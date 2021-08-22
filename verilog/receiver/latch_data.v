module latch_data
#(
	parameter width=16
)
(
	input		[width-1:0]	x_in,
	input		[width-1:0]	y_in,
	input		[width-1:0]	phi_in,e_in,teta_in,phi_right_in,
	input		[width-1:0]	x_i,y_i,//Giu tin hieu x_output va y_output den clk thu 37 roi dua ra
	input						start,clk,rst_n,
	output	[width-1:0]	x_out,
	output	[width-1:0]	y_out,
	output	[width-1:0]	phi_out,
	output	[width-1:0]	x_o,y_o,//Dieu chinh clk cho dau ra x,y cua top_pll
	output	reg			ce_vec,ce_rot,
	output	reg [width-1:0] phi,teta,e,phi_right_out,
	output	reg			ready
);
	reg		[5:0]	count;
	reg		[width-1:0]	x_temp,y_temp,phi_temp,x_io_temp,y_io_temp;
	reg		[width-1:0]	e_tp,phi_tp,teta_tp;//Lay dau vao e_in,teta_in,phi_in
	
	assign x_out=x_temp;
	assign y_out=y_temp;
	assign phi_out=phi_temp;
	assign x_o=x_io_temp;
	assign y_o=y_io_temp;
//Dung
	always @ (posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			count<=0;
		end
		else if(start)begin
			if(count==6'd40)	count<=0;
			else	count<=count+1;
		end
	end
	
	always @ (posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			x_temp<=0;
			y_temp<=0;
			phi_temp<=0;
		end
		else if((start)&&(count==0))begin
			x_temp<=x_in;
			y_temp<=y_in;
			phi_temp<=phi_in;
		end
	end
//	
	always @ (posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			x_io_temp<=0;
			y_io_temp<=0;
		end
		else if((start)&&(count==6'd40)) begin
			x_io_temp<=x_i;
			y_io_temp<=y_i;
		end
	end

//Dieu khien ce cua 2 top module VEC va ROT
	always @ (posedge clk or negedge rst_n)begin	//CE_VEC
		if(!rst_n)begin
			ce_vec<=0;
		end
		else if(start) begin
			if((count>=6'd0)&&(count<=6'd15)) ce_vec<=1'b1;
			else	ce_vec<=1'b0;
		end
	end
	
	always @ (posedge clk or negedge rst_n)begin//CE_ROT
		if(!rst_n)begin
			ce_rot<=0;
		end
		else if(start)begin
			if((count>=6'd17)&&(count<=6'd32))	ce_rot<=1'b1;
			else	ce_rot<=1'b0;
		end
	end
	
	always @ (posedge clk or negedge rst_n)begin// lay gia tri cua e',phi',teta'
		if(!rst_n)begin
			e_tp<=0;
			teta_tp<=0;
			phi_tp<=0;
			ready<=0;
		end
		else if((start)&&(count==6'd40))begin
			e_tp<=e_in;
			phi_tp<=phi_in;
			teta_tp<=teta_in;
			ready<=1'b1;
		end
	end
	
	always @ (posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			e<=0;
			teta<=0;
			phi<=0;
			phi_right_out<=0;
		end
		else if((start)&&(count==6'd34))begin
			e<=e_tp;
			phi<=phi_tp;
			teta<=teta_tp;
			phi_right_out<=phi_right_in;
		end
	end
	
endmodule
