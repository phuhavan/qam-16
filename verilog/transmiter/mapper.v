module mapper
#(
	parameter width_data = 16
)
(
	input									data_in,
	input									clk,
	input									rst_n,
	input									start,
	output reg [width_data-1:0]	data_I,
	output reg [width_data-1:0]	data_Q,
	output reg							ready
);
	wire		data_in_wire;//Day noi voi data_in
	reg		[3:0]	reg_sh;//thanh ghi dich
	reg		[1:0]	count;
	reg		[3:0] reg_I,reg_Q;
	reg	start_a,start_b,start_c,start_d;
	
	assign data_in_wire = (start) ?	data_in : 1'b0;
	
	always @ (posedge clk or negedge rst_n)begin	//Khoi tao count va dich thanh ghi reg_sh
		if(!rst_n)begin
				count<=0;
				reg_sh<=0;
		end
		else if(start) begin
				count<=count+1;
				reg_sh<={data_in_wire,reg_sh[3:1]};
		end
	end
	
	always @ (posedge clk or negedge rst_n)begin //xu ly ready
		if(!rst_n)begin
			ready<=0;
			start_a<=0;
			start_b<=0;
			start_c<=0;
			start_d<=0;
		end
		else if(start) begin
			start_a<=1;
			start_b<=start_a;
			start_c<=start_b;
			start_d<=start_c;
			ready<=start_d;
		end
	end
	
	always @ (posedge clk or negedge rst_n)begin//data out
		if(!rst_n)begin
			data_I<=0;
			data_Q<=0;
		end
		else begin
			data_I<={reg_I,12'b0};
			data_Q<={reg_Q,12'b0};
		end
	end
	
	always @ (count or reg_sh or start)begin	// Mapper
		if((count==0)&&(start))begin
				case(reg_sh[3:2])
					2'b00:
							reg_I=-4'd3;
					2'b01:
							reg_I=-4'd1;
					2'b10:
							reg_I=4'd3;
					default:
							reg_I=4'd1;
				endcase
				
				case(reg_sh[1:0])
					2'b00:
							reg_Q=-4'd3;
					2'b01:
							reg_Q=-4'd1;
					2'b10:
							reg_Q=4'd3;
					default:
							reg_Q=4'd1;
				endcase
		end
		else begin
				reg_I=4'b0000;
				reg_Q=4'b0000;
		end
	end
	endmodule
