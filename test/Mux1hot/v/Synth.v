/**@file
 * @brief     Top Synthesis module for Mux1hot
 * @author    Igor Lesik
 * @copyright Igor Lesik 2015
 *
 */

module Synth #(parameter W=8)
(
  input [W-1:0] in0,
  input [W-1:0] in1,
  input [W-1:0] in2,
  input [3-1:0] sel,
  output [W-1:0] out
);

  Mux1hot3 #(.WIDTH(W)) mux1h3(.in0(in0), .in1(in1), .in2(in3), .sel(sel), .out(out));

endmodule: Synth
