module	gen_clk
(
	input		clk,
	input		rst_clk,
	output	clk_40,
	output	clk_41,
	output	clk_656,
	output	clk_16
);
	
	reg	[5:0]	count_40,count_41;
	reg	[3:0]	count_16;
	reg	[9:0]	count_656;
	
	assign clk_40 = (count_40==6'd0)	? 1'b1 : 1'b0;
	assign clk_41 = (count_41==6'd0)	? 1'b1 : 1'b0;
	assign clk_656 = (count_656==10'd0)	? 1'b1 : 1'b0;
	assign clk_16 = (count_16==4'd0)	? 1'b1 : 1'b0;
	
	always @ (posedge clk or negedge rst_clk)begin//clk_40
		if(!rst_clk)begin
			count_40<=0;
		end
		else if(count_40==6'd39)begin
			count_40<=0;
		end
		else begin
			count_40<=count_40+6'd1;
		end
	end
	
	always @ (posedge clk or negedge rst_clk)begin//clk_41
		if(!rst_clk)begin
			count_41<=0;
		end
		else if(count_41==6'd40)begin
			count_41<=0;
		end
		else begin
			count_41<=count_41+6'd1;
		end
	end
	
	always @ (posedge clk or negedge rst_clk)begin//clk_16
		if(!rst_clk)begin
			count_16<=0;
		end
		else begin
			count_16<=count_16+4'd1;
		end
	end
	
	always @ (posedge clk or negedge rst_clk)begin//clk_656
		if(!rst_clk)begin
			count_656<=0;
		end
		else if(count_656==10'd655)begin
			count_656<=0;
		end
		else begin
			count_656<=count_656+10'd1;
		end
	end
	
endmodule
