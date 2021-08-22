module	top_qam_receiver
#(
	parameter width_data = 16,
	parameter	width_reg	=18,
	parameter 	COUNT_WIDTH = 4,
	parameter kp=0.026,//0.0000011010100111 6 7 9 11 14 15 16
	parameter ki=0.00069,//0.00000000001011010011
	parameter k =0.02531//kp-ki=0.0000011001111010 6 7 10 11 12 13 15
)
(
	input		[width_data-1:0]	data_in,
	input								clk,
	input								start,
	input								rst_n,
	input								rst_clk,
	output	[width_data-1:0]	data_out_I,
	output	[width_data-1:0]	data_out_Q,
	output							ready
);
	wire		clk_40;//Doc du lieu vao
	wire		clk_41;//doc du lieu ra
	wire		clk_656;
	wire		clk_16;
	wire		[width_data-1:0]	data_cut;
	wire		[width_data-1:0]	data_carry_I,data_carry_Q;
	wire		[width_data-1:0]	data_fil_I,data_fil_Q;
	wire		[width_data-1:0]	data_sam_I,data_sam_Q;
	wire		ready_cut;//cut_pilot
	wire		ready_carry;
	wire		ready_fil;
	wire		ready_sampling;
/////////////////////////////////
//Khoi tao clock
gen_clk
	gen_clock(
			.clk		(clk),
			.rst_clk	(rst_clk),
			.clk_40	(clk_40),
			.clk_41	(clk_41),
			.clk_656	(clk_656),
			.clk_16	(clk_16)
	);

/////////////////////////////////
//cut 10 so 1 trong doan du lieu:cut pilot
cut_pilot	#	(.width_data(width_data))
	cut_pilot_inst(
				.clk1		(clk_40),//Doc du lieu vao
				.clk2		(clk_41),//Ghi du lieu ra
				.rst_n	(rst_n),	
				.data_in	(data_in),
				.start	(start),
				.data_out(data_cut),
				.ready	(ready_cut)
	);

/////////////////////////////////
//carrier mutiplie I
carrier_multi_sin	# (.width_sym(width_data))
	carrier_I(
				.clk		(clk_41),
				.rst_n	(rst_n),
				.data_in	(data_cut),
				.start	(ready_cut),
				.data_out(data_carry_I),
				.ready	(ready_carry)
	);
//carrier mutiplie Q
carrier_multi_cos	# (.width_sym(width_data))
	carrier_Q(
				.clk		(clk_41),
				.rst_n	(rst_n),
				.data_in	(data_cut),
				.start	(ready_cut),
				.data_out(data_carry_Q),
				.ready	()
	);
/////////////////////////////////////
//raised_cosin_filter
//filter_I
raised_cosin_filter # (
								.width_data	(width_data),
								.No_reg		(width_data)
								)
	filter_I(
				.clk		(clk_41),	
				.rst_n	(rst_n),	
				.start	(ready_carry),	
				.data_in	(data_carry_I),			
				.data_out(data_fil_I),	
				.ready	(ready_fil)	
	);
//filter_Q
raised_cosin_filter # (
								.width_data	(width_data),
								.No_reg		(width_data)
								)
	filter_Q(
				.clk		(clk_41),	
				.rst_n	(rst_n),	
				.start	(ready_carry),	
				.data_in	(data_carry_Q),			
				.data_out(data_fil_Q),	
				.ready	()	
	);
////////////////////////////////////////////
//sampling
//sampling_I
sampling	#	(.width(width_data))
	sampling_data_I(
				.data_in	(data_fil_I),
				.clk		(clk_656),
				.rst_n	(rst_n),
				.start	(ready_fil),
				.data_out(data_sam_I),
				.ready	(ready_sampling)
	);
//sampling_Q
sampling	#	(.width(width_data))
	sampling_data_Q(
				.data_in	(data_fil_Q),
				.clk		(clk_656),
				.rst_n	(rst_n),
				.start	(ready_fil),
				.data_out(data_sam_Q),
				.ready	()
	);
//////////////////////////////////////////
//Phase lock loop
top_pll	#	(
					.width_data		(width_data),
					.width_reg		(width_reg),
					.COUNT_WIDTH	(COUNT_WIDTH),
					.kp				(kp),
					.ki				(ki),
					.k					(k)
				)
	phase_lock_loop_qam(
					.x_in		(data_sam_I),
					.y_in		(data_sam_Q),
					.clk		(clk_16),
					.rst_n	(rst_n),
					.start	(ready_sampling),
					.x_out	(data_out_I),
					.y_out	(data_out_Q),
					.ready	(ready)
	);
	

endmodule
