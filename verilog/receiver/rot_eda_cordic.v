module rot_eda_cordic
#(
  parameter COUNT_WIDTH = 4,   // Counter width
  parameter WIDTH = 16,         // do rong du lieu cua goc
  parameter	WIDTH_WIRE =18		//data width
)
(
  input signed [WIDTH_WIRE-1 : 0]  x_in,
  input signed [WIDTH_WIRE-1 : 0]  y_in,
  input                            clk,
  input                            ce,
  input                            rst_n,
  input                            mux_sel,
  input        [COUNT_WIDTH-1 : 0] shift_bit,
  input                            sign_in,
  output       [WIDTH_WIRE-1 : 0]  x_out,
  output       [WIDTH_WIRE-1 : 0]  y_out,
  output			[WIDTH 	  -1 : 0]  z_out,
  output                           sign_out
);
  
  wire         [WIDTH_WIRE-1 : 0]  x_rot, y_rot;
  wire         [WIDTH_WIRE-1 : 0]  x_mux, y_mux;
  wire 			[WIDTH-1	: 0]		  z_mux;
  wire         [WIDTH_WIRE-1 : 0]  x_result, y_result; 
  wire			[WIDTH-1 : 0]		  z_result;
  wire         [WIDTH_WIRE-1 : 0]  x_shift, y_shift;
  reg				[WIDTH-1 : 0]		  mem [0:15];	//Luu tru gia tri arctan_mem
  reg				[WIDTH-1 : 0]		  z_initial;	//Khoi tao cho z la pi/2 hoac -pi/2
  wire			[WIDTH_WIRE-1 : 0]  x_in_wire,y_in_wire;	//Tang 2 bit cho x_in,y_in
 
  

  assign	z_out = z_result;
  assign x_in_wire = x_in;
  assign y_in_wire = y_in;
  
  always @ (*)begin
	if(y_in_wire[WIDTH_WIRE-1])	z_initial = 16'b1110011011011111;
	else	z_initial = 16'b0001100100100001 ;
  end
  
  
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
  rot_cordic_rot90
  #(
    .WIDTH         (WIDTH_WIRE)
  )
  rot_cordic_rot90_inst
  (
    .x_in          (x_in_wire),
	 .y_in          (y_in_wire),
	 .x_out         (x_rot),
	 .y_out         (y_rot)
  );
  
  // MUX
  rot_cordic_mux
  #(
    .WIDTH         (WIDTH_WIRE)
  )
  rot_cordic_mux_inst_x
  (
    .in0           (x_rot),
	 .in1           (x_result),
	 .sel           (mux_sel),
	 .clk           (clk),
	 .ce            (ce),
	 .rst_n         (rst_n),
	 .out           (x_mux)
  );
  
  rot_cordic_mux
  #(
    .WIDTH         (WIDTH_WIRE)
  )
  rot_cordic_mux_inst_y
  (
    .in0           (y_rot),
	 .in1           (y_result),
	 .sel           (mux_sel),
	 .clk           (clk),
	 .ce            (ce),
	 .rst_n         (rst_n),
	 .out           (y_mux),
	 .msb           (sign_out)
  );
  
  rot_cordic_mux
  #(
    .WIDTH         (WIDTH)
  )
  rot_cordic_mux_inst_z
  (
    .in0           (z_initial),
	 .in1           (z_result),
	 .sel           (mux_sel),
	 .clk           (clk),
	 .ce            (ce),
	 .rst_n         (rst_n),
	 .out           (z_mux)
  );
  
  // SHIFT
  rot_cordic_shift
  #(
    .WIDTH         (WIDTH_WIRE),
	 .COUNT_WIDTH   (COUNT_WIDTH)
  )
  rot_cordic_shift_inst_x
  (
    .data_in       (x_mux),
	 .shift_bit     (shift_bit),
	 .data_out      (x_shift)
  );
  
  rot_cordic_shift
  #(
    .WIDTH         (WIDTH_WIRE),
	 .COUNT_WIDTH   (COUNT_WIDTH)
  )
  rot_cordic_shift_inst_y
  (
    .data_in       (y_mux),
	 .shift_bit     (shift_bit),
	 .data_out      (y_shift)
  );
  
  // ADD/SUB
  rot_cordic_addsub
  #(
    .WIDTH         (WIDTH_WIRE)
  )
  rot_cordic_addsub_inst_x
  (
    .in0           (x_mux),
	 .in1           (y_shift),
	 .sel           (~sign_in),
	 .result        (x_result)
  );
  
  rot_cordic_addsub
  #(
    .WIDTH         (WIDTH_WIRE)
  )
  rot_cordic_addsub_inst_y
  (
    .in0           (y_mux),
	 .in1           (x_shift),
	 .sel           (sign_in),
	 .result        (y_result)
  );
  
  rot_cordic_addsub
  #(
    .WIDTH         (WIDTH)
  )
  rot_cordic_addsub_inst_z
  (
    .in0           (z_mux),
	 .in1           (mem[shift_bit]),
	 .sel           (~sign_in),
	 .result        (z_result)
  );
  
  // MUL CONST
  rot_cordic_mulconst
  #(
    .WIDTH         (WIDTH_WIRE)
  )
  rot_cordic_mulconst_inst_x
  (
    .in            (x_result),
	 .out           (x_out)
  );
  
  rot_cordic_mulconst
  #(
    .WIDTH         (WIDTH_WIRE)
  )
  rot_cordic_mulconst_inst_y
  (
    .in            (y_result),
	 .out           (y_out)
  );
  
endmodule
