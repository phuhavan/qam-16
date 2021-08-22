module rot_cordic_rot90
#(
  parameter WIDTH = 16    // Counter width
)
(
  input signed [WIDTH-1 : 0] x_in,
  input signed [WIDTH-1 : 0] y_in,
  output       [WIDTH-1 : 0] x_out,
  output       [WIDTH-1 : 0] y_out
);
  assign x_out = (y_in[WIDTH-1])? (-y_in) : y_in;
  assign y_out = (y_in[WIDTH-1])? (x_in) : (-x_in);
endmodule
