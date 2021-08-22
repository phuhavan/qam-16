module	sampling
#(
	parameter width=16
)
(	
	input		[width-1:0]	data_in,
	input						clk,
	input						rst_n,
	input						start,
	output	[width-1:0] data_out,
	output	reg			ready
);	
	reg		[width-1:0]	data;
	
	assign data_out=data;
	
	always @ (posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			data<=0;
			ready<=0;
		end
		else if(start)begin
			ready<=1'b1;
			data<=data_in;
		end
	end

endmodule
