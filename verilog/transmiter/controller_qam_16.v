module	controller_qam_16
#(
	parameter	wid_count = 4
)

(
	input		clk,
	input		rst_clk,
	input		rst_n,
	input		ready_mapper,
	input		ready_zero,
	input		ready_filter,
	output	clk_164,	//clk_164=164clk
	output	clk_41,	//clk_41=41clk	: su dung cho khoi zero_padder va filter
	output	clk_40,	//clk_40=40clk	: su dung cho khoi pilot
	output							sel_zero_pad,
	output							ce_shift,
	output	[wid_count-1:0]	sel_carrier
);
////////////////////////////////////////////////////
//Sinh clock tu clock chuan
gen_clk	
	my_gen_clk(
			.clk(clk),
			.rst_clk(rst_clk),
			.clk_164(clk_164),
			.clk_41(clk_41),
			.clk_40(clk_40)
	);
/////////////////////////////////////////////////////	
//dau ra tin hieu dieu khien
proc_qam	#	(.wid_count(wid_count))
	process_qam(
			.clk(clk_41),
			.rst_n(rst_n),
			.ready_mapper(ready_mapper),
			.ready_filter(ready_filter),
			.ready_zero(ready_zero),
			.sel_zero_pad(sel_zero_pad),
			.sel_carrier(sel_carrier),
			.ce_shift(ce_shift)
	);
	
endmodule
