module zero_padder
#(
	parameter width_data = 16
)

(
	input 							clk,
	input								rst_n,
	input								start,
	input								sel,
	input		[width_data-1:0]	data_in,
	output	[width_data-1:0]	data_out,
	output	reg					ready
);

	reg		[width_data-1:0]	data;
	wire		[width_data-1:0]	data_in_wire;	//Day luu gia tri  data_in
	
	assign data_in_wire = (start)	? data_in : 16'b0;
	assign data_out = data;
	
	always @ (posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			data<=16'b0;
			ready<=1'b0;
		end
		else begin
			if(!sel)	begin 
							data<=data_in_wire;
							ready	<=1;
						end
			else		data<=16'b0;
		end
	end
	
endmodule
