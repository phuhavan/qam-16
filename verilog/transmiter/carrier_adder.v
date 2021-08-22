module carrier_adder
#(
	parameter width_data = 16
)
(
	input	[width_data-1:0]	carrier_1, carrier_2,
	input							clk,
	input							rst_n,
	output reg [width_data-1:0]	carrier_sum
);

	always @ (posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			carrier_sum<=0;
		end
		else begin
			carrier_sum<=carrier_1+carrier_2;
		end
	end
	
endmodule
