module rot_cordic_shift
#(
  parameter WIDTH = 16,         // Data width
  parameter COUNT_WIDTH = 4     // Counter width
)
(
  input signed [WIDTH-1 : 0]       data_in,
  input        [COUNT_WIDTH-1 : 0] shift_bit,
  output       [WIDTH-1 : 0]       data_out
);
  assign data_out = data_in >>> shift_bit;

endmodule
