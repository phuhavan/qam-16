module vec_cordic_mulconst
#(
  parameter WIDTH = 16         // Data width
)
(
  input signed [WIDTH-1 : 0]       in,
  output       [WIDTH-1 : 0]       out
);
  // 0.1001101101110100111011011 = 0.607252925634384
  assign out = (in>>>1)+(in>>>4)+(in>>>5)+(in>>>7)+(in>>>8)+(in>>>10)+(in>>>11)+(in>>>12)
         +(in>>>14)+(in>>>17)+(in>>>18)+(in>>>19)+(in>>>21)+(in>>>22)+(in>>>24)+(in>>>25);

endmodule
