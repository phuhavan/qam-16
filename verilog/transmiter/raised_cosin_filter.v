module raised_cosin_filter 
#(
	parameter 	width_data =	16,
	parameter 	No_reg	=		16
)
(
	input						clk		,	
	input						rst_n	,	
	input						start	,	
	input	[width_data-1:0]	data_in	,	
	input						ce_shift,		
	output	reg	[width_data-1:0]	data_out,	
	output	reg					ready	

);
	reg 	[width_data-1:0]	shift_reg	[No_reg-1:0];
	reg	ready_inv_delay;
	reg	ready_inv_delay2;
	
	reg [width_data-1:0] data_out_0_temp   ;
	reg [width_data-1:0] data_out_1_temp   ;
	reg [width_data-1:0] data_out_2_temp   ;
	reg [width_data-1:0] data_out_3_temp   ;
	reg [width_data-1:0] data_out_4_temp   ;
	reg [width_data-1:0] data_out_5_temp   ;
	reg [width_data-1:0] data_out_6_temp   ;
	reg [width_data-1:0] data_out_7_temp   ;
	reg [width_data-1:0] data_out_8_temp   ;
	reg [width_data-1:0] data_out_9_temp   ;
	reg [width_data-1:0] data_out_10_temp   ;
	reg [width_data-1:0] data_out_11_temp   ;
	reg [width_data-1:0] data_out_12_temp   ;
	reg [width_data-1:0] data_out_13_temp   ;
	reg [width_data-1:0] data_out_14_temp   ;
	reg [width_data-1:0] data_out_15_temp   ;
	
	wire	[width_data-1:0]	data_in_temp;
	wire [width_data-1:0] data_out_0    ;
	wire [width_data-1:0] data_out_1    ;
	wire [width_data-1:0] data_out_2    ;
	wire [width_data-1:0] data_out_3    ;
	wire [width_data-1:0] data_out_4    ;
	wire [width_data-1:0] data_out_5    ;
	wire [width_data-1:0] data_out_6    ;
	wire [width_data-1:0] data_out_7    ;
	wire [width_data-1:0] data_out_8    ;
	wire [width_data-1:0] data_out_9    ;
	wire [width_data-1:0] data_out_10   ;
	wire [width_data-1:0] data_out_11   ;
	wire [width_data-1:0] data_out_12   ;
	wire [width_data-1:0] data_out_13   ;
	wire [width_data-1:0] data_out_14   ;
	wire [width_data-1:0] data_out_15   ;
	
	wire [width_data-1:0] shift_reg_0    ;
	wire [width_data-1:0] shift_reg_1    ;
	wire [width_data-1:0] shift_reg_2    ;
	wire [width_data-1:0] shift_reg_3    ;
	wire [width_data-1:0] shift_reg_4    ;
	wire [width_data-1:0] shift_reg_5    ;
	wire [width_data-1:0] shift_reg_6    ;
	wire [width_data-1:0] shift_reg_7    ;
	wire [width_data-1:0] shift_reg_8    ;
	wire [width_data-1:0] shift_reg_9    ;
	wire [width_data-1:0] shift_reg_10   ;
	wire [width_data-1:0] shift_reg_11   ;
	wire [width_data-1:0] shift_reg_12   ;
	wire [width_data-1:0] shift_reg_13   ;
	wire [width_data-1:0] shift_reg_14   ;
	wire [width_data-1:0] shift_reg_15   ;
	

	
	assign shift_reg_0 = shift_reg[0 ][15]? (~(shift_reg[0 ])+16'b1):shift_reg[0 ];
	assign shift_reg_1 = shift_reg[1 ][15]? (~(shift_reg[1 ])+16'b1):shift_reg[1 ];
	assign shift_reg_2 = shift_reg[2 ][15]? (~(shift_reg[2 ])+16'b1):shift_reg[2 ];
	assign shift_reg_3 = shift_reg[3 ][15]? (~(shift_reg[3 ])+16'b1):shift_reg[3 ];
	assign shift_reg_4 = shift_reg[4 ][15]? (~(shift_reg[4 ])+16'b1):shift_reg[4 ];
	assign shift_reg_5 = shift_reg[5 ][15]? (~(shift_reg[5 ])+16'b1):shift_reg[5 ];
	assign shift_reg_6 = shift_reg[6 ][15]? (~(shift_reg[6 ])+16'b1):shift_reg[6 ];
	assign shift_reg_7 = shift_reg[7 ][15]? (~(shift_reg[7 ])+16'b1):shift_reg[7 ];
	assign shift_reg_8 = shift_reg[8 ][15]? (~(shift_reg[8 ])+16'b1):shift_reg[8 ];
	assign shift_reg_9 = shift_reg[9 ][15]? (~(shift_reg[9 ])+16'b1):shift_reg[9 ];
	assign shift_reg_10= shift_reg[10][15]? (~(shift_reg[10])+16'b1):shift_reg[10];
	assign shift_reg_11= shift_reg[11][15]? (~(shift_reg[11])+16'b1):shift_reg[11];
	assign shift_reg_12= shift_reg[12][15]? (~(shift_reg[12])+16'b1):shift_reg[12];
	assign shift_reg_13= shift_reg[13][15]? (~(shift_reg[13])+16'b1):shift_reg[13];
	assign shift_reg_14= shift_reg[14][15]? (~(shift_reg[14])+16'b1):shift_reg[14];
	assign shift_reg_15= shift_reg[15][15]? (~(shift_reg[15])+16'b1):shift_reg[15];

	assign	data_in_temp	= (start)?data_in:0;
	
	assign data_out_0  = 0;
	assign data_out_1  = ~((shift_reg_1>>>4)+(shift_reg_1>>>5)+(shift_reg_1>>>10)+(shift_reg_1>>>11))+16'b1; 
	assign data_out_2  = ~((shift_reg_2>>>3)+(shift_reg_2>>>5)+(shift_reg_2>>>7) +(shift_reg_2>>>9)+(shift_reg_2>>>10)+(shift_reg_2>>>11))+16'b1; 
	assign data_out_3  = ~((shift_reg_3>>>3)+(shift_reg_3>>>8)+(shift_reg_3>>>9) +(shift_reg_3>>>10))+16'b1; 
	assign data_out_4  = (shift_reg_4>>>4)+(shift_reg_4>>>10)+(shift_reg_4>>>11);                      
	assign data_out_5  = (shift_reg_5>>>2)+(shift_reg_5>>>3)+(shift_reg_5>>>6) +(shift_reg_5>>>9) +(shift_reg_5>>>12);
	assign data_out_6  = (shift_reg_6>>>1)+(shift_reg_6>>>3)+(shift_reg_6>>>4) +(shift_reg_6>>>5) +(shift_reg_6>>>6)+(shift_reg_6>>>7) +(shift_reg_6>>>11)+(shift_reg_6>>>12); 
	assign data_out_7  = (shift_reg_7>>>1)+(shift_reg_7>>>2)+(shift_reg_7>>>3)+(shift_reg_7>>>4)+(shift_reg_7>>>5)+(shift_reg_7>>>12); 
	assign data_out_8  = (shift_reg_8>>>1)+(shift_reg_8>>>2)+(shift_reg_8>>>3)+(shift_reg_8>>>4)+(shift_reg_8>>>5)+(shift_reg_8>>>12);                                 
	assign data_out_9  = (shift_reg_9>>>1)+(shift_reg_9>>>3)+(shift_reg_9>>>4) +(shift_reg_9>>>5) +(shift_reg_9>>>6)+(shift_reg_9>>>7) +(shift_reg_9>>>11)+(shift_reg_9>>>12);
	assign data_out_10 = (shift_reg_10>>>2)+(shift_reg_10>>>3)+(shift_reg_10>>>6) +(shift_reg_10>>>9) +(shift_reg_10>>>12);
	assign data_out_11 = (shift_reg_11>>>4)+(shift_reg_11>>>10)+(shift_reg_11>>>11);  
	assign data_out_12 = ~((shift_reg_12>>>3)+(shift_reg_12>>>8)+(shift_reg_12>>>9) +(shift_reg_12>>>10))+16'b1;                       
	assign data_out_13 = ~((shift_reg_13>>>3)+(shift_reg_13>>>5)+(shift_reg_13>>>7) +(shift_reg_13>>>9)+(shift_reg_13>>>10)+(shift_reg_13>>>11))+16'b1; 
	assign data_out_14 = ~((shift_reg_14>>>4)+(shift_reg_14>>>5)+(shift_reg_14>>>10)+(shift_reg_14>>>11))+16'b1; 
	assign data_out_15 = 0;
	
	always @ (posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			shift_reg[0 ] <=0;
			shift_reg[1 ] <=0;
			shift_reg[2 ] <=0;
			shift_reg[3 ] <=0;
			shift_reg[4 ] <=0;
			shift_reg[5 ] <=0;
			shift_reg[6 ] <=0;
			shift_reg[7 ] <=0;
			shift_reg[8 ] <=0;
			shift_reg[9 ] <=0;
			shift_reg[10] <=0;
			shift_reg[11] <=0;
			shift_reg[12] <=0;
			shift_reg[13] <=0;
			shift_reg[14] <=0;
			shift_reg[15] <=0;
			ready_inv_delay<=0;
			ready<=0;
			data_out<=0;
		end
		else if(ce_shift) begin
			//shift_reg[No_reg-1:0]	<= {data_in_temp,shift_reg[No_reg-1:1]};
			shift_reg[0 ] <=data_in_temp;
			shift_reg[1 ] <=shift_reg[0 ];
			shift_reg[2 ] <=shift_reg[1 ];
			shift_reg[3 ] <=shift_reg[2 ];
			shift_reg[4 ] <=shift_reg[3 ];
			shift_reg[5 ] <=shift_reg[4 ];
			shift_reg[6 ] <=shift_reg[5 ];
			shift_reg[7 ] <=shift_reg[6 ];
			shift_reg[8 ] <=shift_reg[7 ];
			shift_reg[9 ] <=shift_reg[8 ];
			shift_reg[10] <=shift_reg[9 ];
			shift_reg[11] <=shift_reg[10];
			shift_reg[12] <=shift_reg[11];
			shift_reg[13] <=shift_reg[12];
			shift_reg[14] <=shift_reg[13];
			shift_reg[15] <=shift_reg[14];
			

			
			if(!shift_reg[0][15] )begin
				data_out_0_temp <=data_out_0 ;
			end	
			else begin	
				data_out_0_temp<=~(data_out_0)+16'b1;	
			end					
			if(!shift_reg[1][15] )begin
			    data_out_1_temp <=data_out_1 ;
			end	
			else begin	
				data_out_1_temp<=~(data_out_1)+16'b1;	
			end					
			if(!shift_reg[2][15] )begin
			    data_out_2_temp <=data_out_2 ;
			end			
			else begin	
				data_out_2_temp<=~(data_out_2)+16'b1;	
			end					
			if(!shift_reg[3][15] )begin
			    data_out_3_temp <=data_out_3 ;
			end	
			else begin	
				data_out_3_temp<=~(data_out_3)+16'b1;	
			end					
			if(!shift_reg[4][15] )begin
			    data_out_4_temp <=data_out_4 ;
			end	
			else begin	
				data_out_4_temp<=~(data_out_4)+16'b1;	
			end	
			if(!shift_reg[5][15] )begin
			    data_out_5_temp <=data_out_5 ;
			end	
			else begin	
				data_out_5_temp<=~(data_out_5)+16'b1;	
			end	
			if(!shift_reg[6][15] )begin
			    data_out_6_temp <=data_out_6 ;
			end	
			else begin	
				data_out_6_temp<=~(data_out_6)+16'b1;	
			end	
			if(!shift_reg[7][15] )begin
			    data_out_7_temp <=data_out_7 ;
			end	
			else begin	
				data_out_7_temp<=~(data_out_7)+16'b1;	
			end	
			if(!shift_reg[8][15] )begin
			    data_out_8_temp <=data_out_8 ;
			end	
			else begin	
				data_out_8_temp<=~(data_out_8)+16'b1;	
			end	
			if(!shift_reg[9][15] )begin
			    data_out_9_temp <=data_out_9 ;
			end	
			else begin	
				data_out_9_temp<=~(data_out_9)+16'b1;	
			end	
			if(!shift_reg[10][15])begin
			    data_out_10_temp<=data_out_10;
			end	
			else begin	
				data_out_10_temp<=~(data_out_10)+16'b1;	
			end	
			if(!shift_reg[11][15])begin
			    data_out_11_temp<=data_out_11;
			end	
			else begin	
				data_out_11_temp<=~(data_out_11)+16'b1;	
			end	
			if(!shift_reg[12][15])begin
			    data_out_12_temp<=data_out_12;
			end	
			else begin	
				data_out_12_temp<=~(data_out_12)+16'b1;	
			end	
			if(!shift_reg[13][15])begin
			    data_out_13_temp<=data_out_13;
			end	
			else begin	
				data_out_13_temp<=~(data_out_13)+16'b1;	
			end	
			if(!shift_reg[14][15])begin
			    data_out_14_temp<=data_out_14;
			end	
			else begin	
				data_out_14_temp<=~(data_out_14)+16'b1;	
			end	
			if(!shift_reg[15][15])begin
			    data_out_15_temp<=data_out_15;
			end	
			else begin	
				data_out_15_temp<=~(data_out_15)+16'b1;	
			end	

			data_out	<=	data_out_0_temp +data_out_1_temp +data_out_2_temp +data_out_3_temp +data_out_4_temp +data_out_5_temp +data_out_6_temp +data_out_7_temp +data_out_8_temp +data_out_9_temp +data_out_10_temp +data_out_11_temp +data_out_12_temp +data_out_13_temp +data_out_14_temp +data_out_15_temp;
			ready_inv_delay2			<=ready_inv_delay;
			ready							<=ready_inv_delay2;
			ready_inv_delay			<=1;
		end
	end
	
endmodule
	