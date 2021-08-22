module vec_cordic_top
#(
  parameter COUNT_WIDTH = 4,   // Counter width
  parameter WIDTH_IN = 16,         // Counter width
  parameter	WIDTH_OUT =18		//Mo rong bit dau
)
(
  input                            clk,
  input                            start,
  input                            rst_n,
  input signed [WIDTH_IN-1 : 0]    x_in,
  input signed [WIDTH_IN-1 : 0]    y_in,
  input signed	[WIDTH_IN-1 : 0]	  z_in,
  output reg   [WIDTH_OUT-1 : 0]   x_out,
  output reg   [WIDTH_OUT-1 : 0]   y_out,
  output			ready
);
  wire                             sign;
  wire         [COUNT_WIDTH-1 : 0] shift_bit;
  wire                             mux_sel;
  wire   	   [WIDTH_OUT-1 : 0]   x_out_wire;
  wire	      [WIDTH_OUT-1 : 0]   y_out_wire;
  
  always	@ (posedge clk or negedge rst_n)begin	//Giu gia tri  x_out,y_out trong 16 chu ki
	if(!rst_n)begin
		x_out<=0;
		y_out<=0;
	end
	else if (shift_bit==4'd15)begin
		x_out<=x_out_wire;
		y_out<=y_out_wire;
	end
  end
  
  // CORDIC
  vec_eda_cordic
  #(
    .WIDTH_IN     (WIDTH_IN),
	 .COUNT_WIDTH  (COUNT_WIDTH),
	 .WIDTH_OUT	(WIDTH_OUT)
  )
  eda_cordic_inst
  (
    .x_in         (x_in),
    .y_in         (y_in),
	 .z_in			(z_in),
	 .clk          (clk),
    .ce           (start),
    .rst_n        (rst_n),
    .mux_sel      (mux_sel),
    .shift_bit    (shift_bit),
    .sign_in      (sign),
    .x_out        (x_out_wire),
    .y_out        (y_out_wire),
    .sign_out     (sign)
  );
  
  // CTRL
  vec_cordic_ctrl
  #(
    .COUNT_WIDTH  (COUNT_WIDTH)
  )
  eda_cordic_ctrl_inst
  (
    .clk          (clk),
    .ce           (start),
    .rst_n        (rst_n),
    .shift_bit    (shift_bit),
    .mux_ctrl     (mux_sel),
	 .ready			(ready)
  );
endmodule
