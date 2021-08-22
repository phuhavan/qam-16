module gen_clk
(
	input				clk,
	input				rst_clk,
	output	clk_164,	//clk_164=164clk
	output	clk_41,	//clk_41=41clk	: su dung cho khoi zero_padder va filter
	output	clk_40	//clk_40=40clk	: su dung cho khoi pilot
);
		
	reg	[5:0]	count_41;
	reg	[5:0]	count_40;
	reg	[7:0]	count_164;
	
	assign clk_40 = (count_40==0)	?	1'b1:1'b0;
	assign clk_41 = (count_41==0) ?	1'b1:1'b0;
	assign clk_164 = (count_164==0)	? 1'b1 : 1'b0;
	
	always @ (posedge clk or negedge rst_clk)begin
		if(!rst_clk)begin
			count_40<=6'd39;
		end
		else begin
			if(count_40==6'd39)	count_40<=0;
			else count_40<=count_40+1;
		end
	end
	
	always @ (posedge clk or negedge rst_clk)begin
		if(!rst_clk)begin
			count_41<=6'd40;
		end
		else begin
			if(count_41==6'd40)	count_41<=0;
			else	count_41<=count_41+1;
		end
	end
	
	always @ (posedge clk or negedge rst_clk)begin
		if(!rst_clk)begin
			count_164<=8'd163;
		end
		else begin
			if(count_164==8'd163)	count_164<=0;
			else	count_164<=count_164+1;
		end
	end
	
endmodule
