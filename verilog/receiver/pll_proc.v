/*
	operation: thuc hien ham sau:
	teta = |phi_err-phi_right|
	e=e'+kp*teta + (ki-kp)*teta'
	phi=phi'+e
	trong do:
		.e',phi',teta'  la cac gia tri tinh tu chu ki truoc do
		.phi la dau ra de dieu chinh goc PLL
		.phi_err: dau ra cua khoi CORDIC_TO_ROT
		.phi_right: dau ra cua khoi lam tron
*/

module	pll_proc
#(
	parameter kp=0.026,//0.0000011010100111 6 7 9 11 14 15 16
	parameter ki=0.00069,//0.00000000001011010011
	parameter k =0.02531,//kp-ki=0.0000011001111010 6 7 10 11 12 13 15
	parameter width = 16	//data width
)
(	
	input		[width-1:0]		phi_err,phi_right,
	input		[width-1:0]		phi_in,	//phi'
	input		[width-1:0]		e_in,		//e'
	input		[width-1:0]		teta_in,	//teta'
	input							clk,
	input							rst_n,
	input							start,
	output 	[width-1:0]		e_out,
	output 	[width-1:0]		teta_out,
	output 	[width-1:0]		phi_out
);

	wire		[width-1:0]		teta_temp,teta;
	wire		[width-1:0]		e_temp,phi_tem;
	wire		[width-1:0]		e_initial,phi_initial;
	reg		[width-1:0]		e_reg,teta_reg,phi_reg;
	reg		start_delay;
	wire		[width-1:0]		teta1,teta2;
	
	assign	e_out = e_reg;
	assign	teta_out = teta_reg;
	assign	phi_out = phi_reg;
	
	assign	e_initial = (start)	?	(e_in)	:16'b0;
	assign	phi_initial = (start) ? (phi_in)	:16'b0;
	assign	teta_temp = (start)	?	(phi_err-phi_right)	:	16'b0;
	assign	teta		 =	(teta_temp[width-1])	?	(-teta_temp)	:	teta_temp;
	assign	teta1=(teta>>6) + (teta>>7) + (teta>>9) + (teta>>11) + (teta>>14) + (teta>>15) + (teta>>16);//Kp*teta:6 7 9 11 14 15 16
	assign	teta2=(teta_in>>6) + (teta_in>>7) + (teta_in>>10) + (teta_in>>11) + (teta_in>>12) + (teta_in>>13) + (teta_in>>15);//k*teta_in:6 7 10 11 12 13 15
	assign	e_temp = e_initial + teta1 - teta2;
	assign	phi_tem = phi_initial + e_temp;
	
	always @ (posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			e_reg<=0;
			teta_reg<=0;
			phi_reg<=0;
		end
		else if(start)begin
			e_reg<=e_temp;
			teta_reg<=teta;
			phi_reg<=phi_tem;
		end
	end
	
endmodule
