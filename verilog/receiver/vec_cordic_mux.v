module vec_cordic_mux
#(
  parameter WIDTH = 16          // Data width
)
(
  input      [WIDTH-1 : 0] in0,
  input      [WIDTH-1 : 0] in1,
  input                    sel,
  input                    clk,
  input                    ce,
  input                    rst_n,
  output reg [WIDTH-1 : 0] out,
  output                   msb
);
  wire       [WIDTH-1 : 0] data;
  assign data = (sel)? in1 : in0;
  assign msb = out[WIDTH-1];
  
  always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin            // Reset
	   out <= 0;
	 end
	 else if(ce) begin
	   out <= data;
	 end
  end
endmodule


