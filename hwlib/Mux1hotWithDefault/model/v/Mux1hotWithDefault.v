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


