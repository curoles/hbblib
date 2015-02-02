/**@file
 * @brief     Top Synthesis module for Mux
 * @author    Igor Lesik
 * @copyright Igor Lesik 2015
 *
 */

module Synth #(parameter W=8)
(
  input [W-1:0] in0,
  input [W-1:0] in1,
  input [W-1:0] in2,
  input [W-1:0] in3,
  input [W-1:0] in4,
  input [W-1:0] in5,
  input [W-1:0] in6,
  input [W-1:0] in7,

  input [3-1:0] sel,
  output [W-1:0] out
);

  Mux8 #(.WIDTH(W)) mux8(
      .in0(in0), .in1(in1), .in2(in2), .in3(in3),
      .in4(in4), .in5(in5), .in6(in6), .in7(in7),
      .sel(sel), .out(out));

endmodule: Synth
