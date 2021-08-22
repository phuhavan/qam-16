module vec_cordic_rot90
#(
  parameter WIDTH = 16,    // Counter width
  parameter WIDTH_WIRE =18 //Mo rong dau
)
(
  input signed [WIDTH_WIRE-1 : 0] x_in,
  input signed [WIDTH_WIRE-1 : 0] y_in,
  input signed	[WIDTH-1 : 0] 		 z_in,
  output reg      [WIDTH_WIRE-1 : 0] x_out,
  output reg      [WIDTH_WIRE-1 : 0] y_out,
  output	reg		[WIDTH-1 : 0] 		 z_out
);
  
  always @ (x_in or y_in or z_in)begin
		if((z_in >= 16'd6433) && (z_in<16'd12867)) begin //>=pi/2 va <pi
			x_out = -y_in;
			y_out = x_in;
			z_out = z_in - 16'd6433; //-pi/2
		end
		else if((z_in>=16'd12867) && (z_in<16'd19301))begin	//>=pi  &  <3*pi/2
			x_out = -x_in;
			y_out = -y_in;
			z_out = z_in - 16'd12867; //-pi
		end
		else if((z_in>=16'd19301) &&(z_in<16'd25735))begin	// >=3pi/2 & <2pi
			x_out = y_in;
			y_out = -x_in;
			z_out = z_in - 16'd19301; //-3pi/2
		end
		else begin
			x_out = x_in;
			y_out = y_in;
			z_out = z_in;
		end
  end
  
endmodule
