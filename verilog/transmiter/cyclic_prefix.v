module cyclic_prefix
(
	input 			clk,
	input				rst_n,
	input				data_in,
	input				start,
	output	reg	data_out,
	output	reg	ready
);

	reg	data_in_r;
	reg	[6:0]	count;
	reg	ready_temp;	//:am tre ready 1 chu ki theo spec
	
	always @ (posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			count<=0;
		end
		else if(start) begin
			if(count==7'd99)	count<=0;
			else	count<=count+1;
		end
	end

	always @ (posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			data_in_r<=0;
			ready_temp<=0;
		end
		else if(start) begin
			data_in_r<=data_in;
			ready_temp<=1'b1;
		end
	end

	always @ (posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			data_out<=0;
			ready<=0;
		end
		else if(start) begin
			ready<=ready_temp;
			if(count<7'd90) data_out<=data_in_r;
			else 	data_out<=16'b1;
		end
	end
	
endmodule
