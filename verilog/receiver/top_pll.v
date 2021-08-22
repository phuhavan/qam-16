module	top_pll
#(
	parameter	width_data = 16,
	parameter	width_reg	=18,
	parameter 	COUNT_WIDTH = 4,
	parameter kp=0.026,//0.0000011010100111 6 7 9 11 14 15 16
	parameter ki=0.00069,//0.00000000001011010011
	parameter k =0.02531//kp-ki=0.0000011001111010 6 7 10 11 12 13 15
)
(
	input		[width_data-1:0]	x_in,
	input		[width_data-1:0]	y_in,
	input								clk,rst_n,
	input								start,
	output	[width_data-1:0]	x_out,
	output	[width_data-1:0]	y_out,
	output							ready
);
	wire		[width_data-1:0]	phi_ht;//Phi hoi tiep
	wire		[width_data-1:0]	x_latch,y_latch,phi_latch;
	wire		[width_reg-1:0]	x_vec,y_vec;
	wire		[width_data-1:0]	phi_err,phi_right,phi_right_out;
	wire		[width_data-1:0]	phi_temp,teta_temp,e_temp;//hoi tiep cua pll_proc
	wire		[width_data-1:0]	e_o,teta_o;//Output cua khoi pll_proc
	wire		[width_data-1:0]	x_appr,y_appr;
	wire		ready_latch;
	wire		ready_vec;
	wire		ready_rot;
	wire		ce_rot,ce_vec;
	
	
latch_data	#(.width(width_data))
	latch_data_inst(
			.x_in		(x_in),
			.y_in		(y_in),
			.phi_in	(phi_ht),
			.e_in		(e_o),
			.teta_in	(teta_o),
			.phi_right_in(phi_right),
			.x_i		(x_appr),
			.y_i 		(y_appr),
			.start	(start),
			.clk		(clk),
			.rst_n	(rst_n),
			.x_out	(x_latch),
			.y_out	(y_latch),
			.phi_out (phi_latch),
			.x_o 		(x_out),
			.y_o 		(y_out),
			.ce_vec	(ce_vec),
			.ce_rot	(ce_rot),
			.phi		(phi_temp),
			.teta		(teta_temp),
			.e			(e_temp),
			.phi_right_out(phi_right_out),
			.ready	(ready)
	);

vec_cordic_top #(
						.COUNT_WIDTH	(COUNT_WIDTH),
						.WIDTH_IN		(width_data),
						.WIDTH_OUT		(width_reg)
					)
	cordic_to_vec(
					.clk		(clk),
					.start	(ce_vec),
					.rst_n	(rst_n),
					.x_in		(x_latch),
					.y_in		(y_latch),
					.z_in		(phi_latch),
					.x_out	(x_vec),
					.y_out	(y_vec),
					.ready	(ready_vec)
	);
	
top_cordic_rot #(
						.COUNT_WIDTH	(COUNT_WIDTH),
						.WIDTH			(width_data),
						.WIDTH_WIRE		(width_reg)
					)
	cordic_to_rot(
					.clk		(clk),
					.start	(ce_rot),
					.rst_n	(rst_n),
					.x_in		(x_vec),
					.y_in		(y_vec),
					.x_out(),
					.y_out(),
					.z_out	(phi_err),
					.ready	(ready_rot)
	);

appr_cordic #(
					.width_in	(width_reg),
					.width_out	(width_data)
				)
	appr_cordic_inst(
					.x_in(x_vec),
					.y_in(y_vec),
					.start(ready_vec),
					.clk(clk),
					.rst_n(rst_n),
					.x_out(x_appr),
					.y_out(y_appr),
					.phi_right(phi_right)
	);

pll_proc #(
				.kp	(kp),
				.ki	(ki),
				.k 	(k),
				.width(width_data)
			)
	pll_proc_inst(
				.phi_err		(phi_err),
				.phi_right	(phi_right_out),
				.phi_in		(phi_temp),	
				.e_in			(e_temp),	
				.teta_in		(teta_temp),
				.clk			(clk),
				.rst_n		(rst_n),
				.start		(ready_rot),
				.e_out		(e_o),
				.teta_out	(teta_o),
				.phi_out		(phi_ht)
	);
	
endmodule
