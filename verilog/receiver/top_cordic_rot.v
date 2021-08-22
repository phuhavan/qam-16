module top_cordic_rot
#(
  parameter COUNT_WIDTH = 4,   // Counter width
  parameter WIDTH = 16,         // do rong du lieu cua goc
  parameter	WIDTH_WIRE =18		//data width
)
(
  input                            	clk,
  input                            	start,
  input                            	rst_n,
  input signed [WIDTH_WIRE-1 : 0]   x_in,
  input signed [WIDTH_WIRE-1 : 0]   y_in,
  output reg   [WIDTH_WIRE-1 : 0]   x_out,
  output reg   [WIDTH_WIRE-1 : 0]   y_out,
  output reg	[WIDTH-1 : 0]			z_out,
  output			ready
);
  wire                             	sign;
  wire         [COUNT_WIDTH-1 : 0]	shift_bit;
  wire                             	mux_sel;
  wire			[WIDTH_WIRE-1 : 0]   x_out_wire;
  wire       	[WIDTH_WIRE-1 : 0]   y_out_wire;
  wire			[WIDTH-1 : 0]			z_out_wire;
  wire			[WIDTH-1 : 0]			z_out_wire_temp;//Chuyen z_out_wire ve [0-2pi]
  
  assign	z_out_wire_temp = (z_out_wire[WIDTH-1])	?	(z_out_wire+16'd25735)	:	(z_out_wire);//pi->25735(16bit)
  
  
  always	@ (posedge clk or negedge rst_n)begin	//Giu gia tri  x_out,y_out trong 16 chu ki
	if(!rst_n)begin
		x_out<=0;
		y_out<=0;
		z_out<=0;
	end
	else if (shift_bit==4'd15)begin
		x_out<=x_out_wire;
		y_out<=y_out_wire;
		z_out<=z_out_wire_temp;
	end
  end
  
  // CORDIC
  rot_eda_cordic
  #(
    .WIDTH        (WIDTH),
	 .COUNT_WIDTH  (COUNT_WIDTH),
	 .WIDTH_WIRE	(WIDTH_WIRE)
  )
  rot_cordic_inst
  (
    .x_in         (x_in),
    .y_in         (y_in),
	 .clk          (clk),
    .ce           (start),
    .rst_n        (rst_n),
    .mux_sel      (mux_sel),
    .shift_bit    (shift_bit),
    .sign_in      (sign),
    .x_out        (x_out_wire),
    .y_out        (y_out_wire),
	 .z_out			(z_out_wire),
    .sign_out     (sign)
  );
  
  // CTRL
  rot_cordic_ctrl
  #(
    .COUNT_WIDTH  (COUNT_WIDTH)
  )
  rot_cordic_ctrl_inst
  (
    .clk          (clk),
    .ce           (start),
    .rst_n        (rst_n),
    .shift_bit    (shift_bit),
    .mux_ctrl     (mux_sel),
	 .ready			(ready)
  );
endmodule
