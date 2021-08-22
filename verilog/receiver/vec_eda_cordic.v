module vec_eda_cordic
#(
  parameter WIDTH_IN = 16,        // Data width
  parameter COUNT_WIDTH = 4,    // Counter width
  parameter	WIDTH_OUT = 18	//mo rong bit dau
)
(
  input signed [WIDTH_IN-1 : 0]    x_in,
  input signed [WIDTH_IN-1 : 0]    y_in,
  input signed	[WIDTH_IN-1 : 0]	  z_in,
  input                            clk,
  input                            ce,
  input                            rst_n,
  input                            mux_sel,
  input        [COUNT_WIDTH-1 : 0] shift_bit,
  input                            sign_in,
  output       [WIDTH_OUT-1 : 0]   x_out,
  output       [WIDTH_OUT-1 : 0]   y_out,	
  output                           sign_out
);
  
  wire         [WIDTH_OUT-1 : 0]       x_rot, y_rot;
  wire			[WIDTH_IN -1 : 0]			z_rot;
  wire         [WIDTH_OUT-1 : 0]       x_mux, y_mux;
  wire			[WIDTH_IN -1 : 0]			z_mux;
  wire         [WIDTH_OUT-1 : 0]       x_result, y_result; 
  wire			[WIDTH_IN -1 : 0]			z_result;
  wire         [WIDTH_OUT-1 : 0]       x_shift, y_shift;
  reg				[WIDTH_IN-1 : 0]		   mem [0:15];	//Luu tru gia tri arctan_mem
  wire			[WIDTH_OUT-1 : 0]		   x_in_wire,y_in_wire;	//Tang 2 bit cho x_in,y_in
  
  
  assign x_in_wire = {{2{x_in[WIDTH_IN-1]}},x_in};
  assign y_in_wire = {{2{y_in[WIDTH_IN-1]}},y_in};
  
  //initial arctan_mem
  initial begin
	mem[0]=	16'b0000110010010000;
	mem[1]=	16'b0000011101101011;
	mem[2]=	16'b0000001111101011;
	mem[3]=	16'b0000000111111101;
	mem[4]=	16'b0000000011111111;
	mem[5]=	16'b0000000001111111;
	mem[6]=	16'b0000000000111111;
	mem[7]=	16'b0000000000011111;
	mem[8]=	16'b0000000000001111;
	mem[9]=	16'b0000000000000111;
	mem[10]=	16'b0000000000000011;
	mem[11]=	16'b0000000000000001;
	mem[12]=	16'b0000000000000000;
	mem[13]=	16'b0000000000000000;
	mem[14]=	16'b0000000000000000;
	mem[15]=	16'b0000000000000000;
  end
  
  
  // ROTATION 90
  vec_cordic_rot90
  #(
    .WIDTH         (WIDTH_IN),
	 .WIDTH_WIRE	 (WIDTH_OUT)
  )
  vec_cordic_rot90_inst
  (
    .x_in          (x_in_wire),
	 .y_in          (y_in_wire),
	 .z_in			 (z_in),
	 .x_out         (x_rot),
	 .y_out         (y_rot),
	 .z_out			 (z_rot)
  );
  
  // MUX
  vec_cordic_mux
  #(
    .WIDTH         (WIDTH_OUT)
  )
  vec_cordic_mux_inst_x
  (
    .in0           (x_rot),
	 .in1           (x_result),
	 .sel           (mux_sel),
	 .clk           (clk),
	 .ce            (ce),
	 .rst_n         (rst_n),
	 .out           (x_mux)
  );
  
  vec_cordic_mux
  #(
    .WIDTH         (WIDTH_OUT)
  )
  vec_cordic_mux_inst_y
  (
    .in0           (y_rot),
	 .in1           (y_result),
	 .sel           (mux_sel),
	 .clk           (clk),
	 .ce            (ce),
	 .rst_n         (rst_n),
	 .out           (y_mux)
  );
  
  vec_cordic_mux
  #(
    .WIDTH         (WIDTH_IN)
  )
  vec_cordic_mux_inst_z
  (
    .in0           (z_rot),
	 .in1           (z_result),
	 .sel           (mux_sel),
	 .clk           (clk),
	 .ce            (ce),
	 .rst_n         (rst_n),
	 .out           (z_mux),
	 .msb				 (sign_out)
  );
  
  // SHIFT
  vec_cordic_shift
  #(
    .WIDTH         (WIDTH_OUT),
	 .COUNT_WIDTH   (COUNT_WIDTH)
  )
 vec_cordic_shift_inst_x
  (
    .data_in       (x_mux),
	 .shift_bit     (shift_bit),
	 .data_out      (x_shift)
  );
  
  vec_cordic_shift
  #(
    .WIDTH         (WIDTH_OUT),
	 .COUNT_WIDTH   (COUNT_WIDTH)
  )
  vec_cordic_shift_inst_y
  (
    .data_in       (y_mux),
	 .shift_bit     (shift_bit),
	 .data_out      (y_shift)
  );
  
  // ADD/SUB
  vec_cordic_addsub
  #(
    .WIDTH         (WIDTH_OUT)
  )
  vec_cordic_addsub_inst_x
  (
    .in0           (x_mux),
	 .in1           (y_shift),
	 .sel           (~sign_in),
	 .result        (x_result)
  );
  
  vec_cordic_addsub
  #(
    .WIDTH         (WIDTH_OUT)
  )
  vec_cordic_addsub_inst_y
  (
    .in0           (y_mux),
	 .in1           (x_shift),
	 .sel           (sign_in),
	 .result        (y_result)
  );
  
  vec_cordic_addsub
  #(
    .WIDTH         (WIDTH_IN)
  )
  vec_cordic_addsub_inst_z
  (
    .in0           (z_mux),
	 .in1           (mem[shift_bit]),
	 .sel           (~sign_in),
	 .result        (z_result)
  );
  
  // MUL CONST
  vec_cordic_mulconst
  #(
    .WIDTH         (WIDTH_OUT)
  )
  vec_cordic_mulconst_inst_x
  (
    .in            (x_result),
	 .out           (x_out)
  );
  
  vec_cordic_mulconst
  #(
    .WIDTH         (WIDTH_OUT)
  )
  vec_cordic_mulconst_inst_y
  (
    .in            (y_result),
	 .out           (y_out)
  );
  
endmodule
