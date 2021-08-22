
module carrier_multi_sin
#(
	parameter width_sym 	= 16,		// do rong cua 1 ky tu
	parameter width_sel		= 4		// do rong cua bien sel
)
(
	input			clk,
	input			rst_n,
	input 			[width_sel-1:0]		sel,
	input		signed	[width_sym-1:0]		data_in,
	input  		start,
	output reg		[width_sym-1:0]		data_out,	
	output reg  	ready			//Bao da nap xong du lieu
);

	wire [width_sym-1:0] data_out_0    ;
	wire [width_sym-1:0] data_out_1    ;
	wire [width_sym-1:0] data_out_2    ;
	wire [width_sym-1:0] data_out_3    ;
	wire [width_sym-1:0] data_out_4    ;
	wire [width_sym-1:0] data_out_5    ;
	wire [width_sym-1:0] data_out_6    ;
	wire [width_sym-1:0] data_out_7    ;
	wire [width_sym-1:0] data_out_8    ;
	wire [width_sym-1:0] data_out_9    ;
	wire [width_sym-1:0] data_out_10   ;
	wire [width_sym-1:0] data_out_11   ;
	wire [width_sym-1:0] data_out_12   ;
	wire [width_sym-1:0] data_out_13   ;
	wire [width_sym-1:0] data_out_14   ;
	wire [width_sym-1:0] data_out_15   ;
	wire [width_sym-1:0]	data_in_temp;
	wire [width_sym-1:0]	data_in_temp2;
	reg  [width_sym-1:0]	data_out_temp;
	reg						data_in_temp3;
	reg						ready_delay;
	
	assign data_in_temp2= start? data_in:0;
	assign data_in_temp= data_in_temp2[15]? (~(data_in_temp2)+16'b1):data_in_temp2;
	
	
	assign data_out_0  = 0;
	assign data_out_1  = (data_in_temp>>>2)+(data_in_temp>>>3)+(data_in_temp>>>8)+(data_in_temp>>>9)+(data_in_temp>>>10)+(data_in_temp>>>11)+(data_in_temp>>>12); 
	assign data_out_2  = (data_in_temp>>>1)+(data_in_temp>>>3)+(data_in_temp>>>4) +(data_in_temp>>>6) +(data_in_temp>>>8); 
	assign data_out_3  = (data_in_temp>>>1)+(data_in_temp>>>2)+(data_in_temp>>>3) +(data_in_temp>>>5) +(data_in_temp>>>6) +(data_in_temp>>>9);
	assign data_out_4  = data_in_temp;                      
	assign data_out_5  = (data_in_temp>>>1)+(data_in_temp>>>2)+(data_in_temp>>>3) +(data_in_temp>>>5) +(data_in_temp>>>6) +(data_in_temp>>>9);
	assign data_out_6  = (data_in_temp>>>1)+(data_in_temp>>>3)+(data_in_temp>>>4) +(data_in_temp>>>6) +(data_in_temp>>>8); 
	assign data_out_7  = (data_in_temp>>>2)+(data_in_temp>>>3)+(data_in_temp>>>8)+(data_in_temp>>>9)+(data_in_temp>>>10)+(data_in_temp>>>11)+(data_in_temp>>>12); 
	assign data_out_8  = 0;                                 
	assign data_out_9  = ~((data_in_temp>>>2)+(data_in_temp>>>3)+(data_in_temp>>>8)+(data_in_temp>>>9)+(data_in_temp>>>10)+(data_in_temp>>>11)+(data_in_temp>>>12))+16'b1;
	assign data_out_10 = ~((data_in_temp>>>1)+(data_in_temp>>>3)+(data_in_temp>>>4) +(data_in_temp>>>6) +(data_in_temp>>>8))+16'b1;
	assign data_out_11 = ~((data_in_temp>>>1)+(data_in_temp>>>2)+(data_in_temp>>>3) +(data_in_temp>>>5) +(data_in_temp>>>6) +(data_in_temp>>>9))+16'b1;
	assign data_out_12 = ~( data_in_temp)+16'b1;                         
	assign data_out_13 = ~((data_in_temp>>>1)+(data_in_temp>>>2)+(data_in_temp>>>3) +(data_in_temp>>>5) +(data_in_temp>>>6) +(data_in_temp>>>9))+16'b1;
	assign data_out_14 = ~((data_in_temp>>>1)+(data_in_temp>>>3)+(data_in_temp>>>4) +(data_in_temp>>>6) +(data_in_temp>>>8))+16'b1; 
	assign data_out_15 = ~((data_in_temp>>>2)+(data_in_temp>>>3)+(data_in_temp>>>8)+(data_in_temp>>>9)+(data_in_temp>>>10)+(data_in_temp>>>11)+(data_in_temp>>>12))+16'b1;
	
	always @ (posedge clk or negedge rst_n  ) begin
		if(!rst_n) begin 
			data_out <= 0 ;
			ready<=0;
			ready_delay<=0;
			data_out_temp<=0;
		end
		else if(start) 	begin
					
					//data_out<= mem_temp*data_in_temp;					
					case(sel)	
						4'b0000: data_out_temp<= data_out_0  ;
						4'b0001: data_out_temp<= data_out_1  ;
						4'b0010: data_out_temp<= data_out_2  ;
						4'b0011: data_out_temp<= data_out_3  ;
						4'b0100: data_out_temp<= data_out_4  ;
						4'b0101: data_out_temp<= data_out_5  ;
						4'b0110: data_out_temp<= data_out_6  ;
						4'b0111: data_out_temp<= data_out_7  ;
						4'b1000: data_out_temp<= data_out_8  ;
						4'b1001: data_out_temp<= data_out_9  ;
						4'b1010: data_out_temp<= data_out_10 ;
						4'b1011: data_out_temp<= data_out_11 ;
						4'b1100: data_out_temp<= data_out_12 ;
						4'b1101: data_out_temp<= data_out_13 ;
						4'b1110: data_out_temp<= data_out_14 ;
						default: data_out_temp<= data_out_15 ;
					endcase
					
					//assign data_out= data_in_temp[15]? (~(data_out_temp)+1):data_out_temp;
					data_in_temp3<=data_in_temp2[15];// data_in_temp3 la tre cua data_in_temp de viec xac dinh am duong se van giu duoc den khi ra data_out
					if(!data_in_temp3) begin
						data_out<=data_out_temp;
						
					end
					else begin
						data_out<=~(data_out_temp)+16'b1;	
					end
					ready<=ready_delay;
					ready_delay<=1;
					
			end
	end
endmodule 