module vec_cordic_addsub
#(
  parameter WIDTH = 16         // Data width
)
(
  input signed [WIDTH-1 : 0]       in0,
  input signed [WIDTH-1 : 0]       in1,
  input                            sel,
  output       [WIDTH-1 : 0]       result
);
  assign result = (sel)? (in0 - in1) : (in0+in1);

endmodule
