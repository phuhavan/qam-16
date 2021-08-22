module proc_qam
#(
	parameter	wid_count = 4
)

(
	input		clk,
	input		rst_n,
	input		ready_mapper,
	input		ready_zero,
	input		ready_filter,
	output	reg					sel_zero_pad,
	output							ce_shift,
	output	[wid_count-1:0]	sel_carrier
);
	reg	[wid_count-1:0]	count_zero;
	reg	[wid_count-1:0]	count_carrier;
	
	assign	ce_shift = ready_zero;
	assign	sel_carrier = count_carrier;
	
////////////////////////////////////////////////////////////////
//Khoi tao bo dem	
	always @ (posedge clk or negedge rst_n)begin	//Bo dem cua khoi zero_padder
		if(!rst_n)begin
			count_zero<=4'b1111;
		end
		else if(ready_mapper)begin
			count_zero<=count_zero+1;
		end
	end
	
	always @ (posedge clk or negedge rst_n)begin	//Bo dem cua khoi multiplier_carrier
		if(!rst_n)begin
			count_carrier<=4'b0;
		end
		else if(ready_filter)begin
			count_carrier<=count_carrier+1;
		end
	end
////////////////////////////////////////////////////////////////
//Dieu khien tin hieu sel_zero_pad
	always @ (posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			sel_zero_pad<=1'b1;
		end
		else begin
			if((count_zero==0)&&(ready_mapper))	sel_zero_pad<=1'b0;
			else	sel_zero_pad<=1'b1;
		end
	end

endmodule
