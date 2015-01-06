/**@file
 * @brief     Multiplexer 
 * @author    Igor Lesik
 * @copyright Igor Lesik 2014
 *
 *
 *
 */

module Mux (in, sel, out);
   
  parameter WIDTH = 1;
  parameter SIZE  = 1;
  parameter CHANNELS  = 2**SIZE;

  input  [(CHANNELS*WIDTH)-1:0] in;
  input  [SIZE-1:0]   sel;

  output [WIDTH-1:0] out;


  genvar ig;
    
  wire [WIDTH-1:0] input_array [0:CHANNELS-1];

  assign out = input_array[sel][WIDTH-1:0];

  generate
    for(ig=0; ig < CHANNELS; ig=ig+1) begin: array_assignments
      assign input_array[ig][WIDTH-1:0] = in[(ig*WIDTH)+:WIDTH];
      // use [((ig+1)*WIDTH)-1:(ig*WIDTH)] if +: not supported
    end
  endgenerate

endmodule

/* verilator lint_off DECLFILENAME */

module Mux2 #(parameter WIDTH=1)
(
  input  [WIDTH-1:0]   in0,
  input  [WIDTH-1:0]   in1,
  input  [1-1:0]       sel,
  output [WIDTH-1:0]   out
);

  Mux #(.WIDTH(WIDTH), .SIZE(1))
    mux2(.in({in1,in0}), .sel(sel), .out(out));
endmodule

module Mux4 #(parameter WIDTH=1)
(
  input  [WIDTH-1:0]   in0,
  input  [WIDTH-1:0]   in1,
  input  [WIDTH-1:0]   in2,
  input  [WIDTH-1:0]   in3,
  input  [2-1:0]       sel,
  output [WIDTH-1:0]   out
);

  Mux #(.WIDTH(WIDTH), .SIZE(2))
    mux4(.in({in3,in2,in1,in0}), .sel(sel), .out(out));
endmodule

module Mux3 #(parameter WIDTH=1)
(
  input  [WIDTH-1:0]   in0,
  input  [WIDTH-1:0]   in1,
  input  [WIDTH-1:0]   in2,
  input  [2-1:0]       sel,
  output [WIDTH-1:0]   out
);

  Mux4 #(.WIDTH(WIDTH))
    mux3(.in0(in0),.in1(in1),.in2(in2),.in3({WIDTH{1'b0}}), .sel(sel), .out(out));
endmodule

/* verilator lint_on DECLFILENAME */
