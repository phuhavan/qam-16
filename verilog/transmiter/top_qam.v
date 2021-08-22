module top_qam
#(
	parameter	width_data = 16,
	parameter	wid_count  = 4,
	parameter	No_reg	=	16
)
(
	input								clk,
	input								rst_n,
	input								rst_clk,
	input								start,
	input								data_in,
	output	[width_data-1:0]	data_transmitter,
	output	[width_data-1:0]	sum	//tong 2 song mang
);
	wire	data_out_CP;	//output cua Cyclic prefix 
	wire	ready_CP;
	wire	[width_data-1:0]	data_I;
	wire	[width_data-1:0] 	data_Q;
	wire 	[width_data-1:0]	data_out_zp_I;
	wire 	[width_data-1:0]	data_out_zp_Q;
	wire	[width_data-1:0]	data_out_fil_I;
	wire	[width_data-1:0]	data_out_fil_Q;
	wire 	[width_data-1:0]	data_out_carry_I;
	wire 	[width_data-1:0]	data_out_carry_Q;
	wire	[width_data-1:0]	carrier_sum;
	wire							ready_mapper;
	wire							ready_zero;
	wire							ready_filter;
	wire							ready_carrier;
	wire							clk_164;	//clk_164=12clk
	wire							clk_41;	//clk_41=3clk	: su dung cho khoi zero_padder va filter
	wire							clk_40;	//clk_40=2clk	: su dung cho khoi pilot
	wire							sel_zero_pad;
	wire							ce_shift;
	wire	[wid_count-1:0]	sel_carrier;
	
	assign sum=carrier_sum;
	
controller_qam_16 # (.wid_count(wid_count))
	controller(
			.clk(clk),
			.rst_clk(rst_clk),
			.rst_n(rst_n),
			.ready_mapper(ready_mapper),
			.ready_zero(ready_zero),
			.ready_filter(ready_filter),
			.clk_40(clk_40),
			.clk_41(clk_41),
			.clk_164(clk_164),
			.sel_zero_pad(sel_zero_pad),
			.sel_carrier(sel_carrier),
			.ce_shift(ce_shift)
	);
	
cyclic_prefix
	cyclic_prefix_block(
		.clk(clk_164),
		.rst_n(rst_n),
		.data_in(data_in),
		.start(start),
		.data_out(data_out_CP),
		.ready(ready_CP)
	);

mapper	#(.width_data(width_data))
	mapper_qam(
			.data_in(data_out_CP),
			.clk(clk_164),
			.rst_n(rst_n),
			.start(ready_CP),
			.data_I(data_I),
			.data_Q(data_Q),
			.ready(ready_mapper)
	);

zero_padder # (.width_data(width_data))
	zero_padder_I(
				.clk(clk_41),
				.rst_n(rst_n),
				.start(ready_mapper),
				.sel(sel_zero_pad),
				.data_in(data_I),
				.data_out(data_out_zp_I),
				.ready(ready_zero)
	);
	
zero_padder # (.width_data(width_data))
	zero_padder_Q(
				.clk(clk_41),
				.rst_n(rst_n),
				.start(ready_mapper),
				.sel(sel_zero_pad),
				.data_in(data_Q),
				.data_out(data_out_zp_Q),
				.ready()
	);
	
raised_cosin_filter	#(
								.width_data(width_data),
								.No_reg(No_reg)
								)
	filter_I(
			.clk(clk_41),	
			.rst_n(rst_n),	
			.start(ready_zero),	
			.data_in(data_out_zp_I),	
			.ce_shift(ce_shift),	
			.data_out(data_out_fil_I),
			.ready(ready_filter)	
	);
	
raised_cosin_filter	#(
								.width_data(width_data),
								.No_reg(No_reg)
								)
	filter_Q(
			.clk(clk_41),	
			.rst_n(rst_n),	
			.start(ready_zero),	
			.data_in(data_out_zp_Q),	
			.ce_shift(ce_shift),	
			.data_out(data_out_fil_Q),
			.ready()	
	);

carrier_multi_sin	#(
							.width_sym(width_data),
							.width_sel(wid_count)
							)
	carrier_multi_sin_I(
			.clk(clk_41),
			.rst_n(rst_n),
			.sel(sel_carrier),
			.data_in(data_out_fil_I),
			.start(ready_filter),
			.data_out(data_out_carry_I),	
			.ready(ready_carrier)
	);

carrier_multi_cos	#(
							.width_sym(width_data),
							.width_sel(wid_count)
							)
	carrier_multi_cos_Q(
			.clk(clk_41),
			.rst_n(rst_n),
			.sel(sel_carrier),
			.data_in(data_out_fil_Q),
			.start(ready_filter),
			.data_out(data_out_carry_Q),	
			.ready()
	);	

carrier_adder #(.width_data(width_data))
	signal_carrier(
				.carrier_1(data_out_carry_I),
				.carrier_2(data_out_carry_Q),
				.clk(clk_41),
				.rst_n(rst_n),
				.carrier_sum(carrier_sum)
	);
	
pilot	# (.width_data(width_data))
	pilot_inserter(
			.clk1(clk_41),
			.clk2(clk_40),
			.rst_n(rst_n),
			.data_in(carrier_sum),
			.start(ready_carrier),
			.data_out(data_transmitter)
	);
	
endmodule
