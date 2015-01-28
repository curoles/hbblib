/**@file
 * @brief     One-hot Multiplexer with default output 
 * @author    Igor Lesik
 * @copyright Igor Lesik 2015
 *
 */
module Mux1hotWithDefault
#(parameter INPUTS = 2,
  parameter WIDTH  = 1)
(
  input  [WIDTH*INPUTS-1:0] in,
  input  [WIDTH-1:0]        dflt,
  input  [INPUTS-1:0]       sel,
  output [WIDTH-1:0]        out
);

  wire [WIDTH-1:0] mux_out;

  Mux1hot #(.WIDTH(WIDTH), .INPUTS(INPUTS))
    mux1h(.in(in), .sel(sel), .out(mux_out));

  assign out = (sel == {WIDTH{1'b0}}) ? dflt : mux_out;

endmodule: Mux1hotWithDefault

module Mux1hotWithDefault8 #(parameter WIDTH=1)
(
  input  [WIDTH-1:0]   in0,
  input  [WIDTH-1:0]   in1,
  input  [WIDTH-1:0]   in2,
  input  [WIDTH-1:0]   in3,
  input  [WIDTH-1:0]   in4,
  input  [WIDTH-1:0]   in5,
  input  [WIDTH-1:0]   in6,
  input  [WIDTH-1:0]   in7,
  input  [WIDTH-1:0]   dflt,
  input  [8-1:0]       sel,
  output [WIDTH-1:0]   out
);

  Mux1hotWithDefault #(.WIDTH(WIDTH), .INPUTS(8))
    mux1h8(.in({in7,in6,in5,in4,in3,in2,in1,in0}), .dflt(dflt), .sel(sel), .out(out));
endmodule

