module rot_cordic_ctrl
#(
  parameter COUNT_WIDTH = 4    // Counter width
)
(
  input                            clk,
  input                            ce,
  input                            rst_n,
  output reg   [COUNT_WIDTH-1 : 0] shift_bit,
  output                           mux_ctrl,
  output	reg	ready	//Bao du lieu ra
);
  reg          [COUNT_WIDTH-1 : 0] counter;
  reg	ready_delay;
  
  
  assign mux_ctrl = |counter;
  
  always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
	   counter <= 4'b0;
		shift_bit <= 4'b0;
	 end
	 else if(ce) begin
	   counter <= counter + 4'd1;
		shift_bit <= counter;
	 end
  end
  
  always	@ (posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		ready_delay<=0;
	end
	else if(shift_bit==4'd14) begin
		ready_delay<=1;
	end
  end
  
  always @ (posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		ready<=0;
	end
	else if(ready_delay) begin
		ready<=1;
	end
  end
  
  
endmodule
