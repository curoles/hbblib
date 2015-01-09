/**@file
 * @brief     One-hot Mux "if" implementation 
 * @author    Igor Lesik
 * @copyright Igor Lesik 2015
 *
 */

/* verilator lint_off DECLFILENAME */

module Mux1hot3 #(parameter WIDTH=1)
(
  input  [WIDTH-1:0]     in0,
  input  [WIDTH-1:0]     in1,
  input  [WIDTH-1:0]     in2,
  input  [3-1:0]         sel,
  output reg [WIDTH-1:0] out
);
`ifdef MUX1HOT_TRUST_SELECT
  always @(*)
  begin: MUX
    out = {WIDTH{1'bx}};
    if (sel[0]) out = in0;
    if (sel[1]) out = in1;
    if (sel[2]) out = in2;
    if (sel[3]) out = in3;
    if (sel[4]) out = in4;
    if (sel[5]) out = in5;
    if (sel[6]) out = in6;
    if (sel[7]) out = in7;
  end
`else
  always @(*)
  begin: MUX
    out = {WIDTH{1'bx}};
    if (sel == 8'b00000001) out = in0;
    if (sel == 8'b00000010) out = in1;
    if (sel == 8'b00000100) out = in2;
    if (sel == 8'b00001000) out = in3;
    if (sel == 8'b00010000) out = in4;
    if (sel == 8'b00100000) out = in5;
    if (sel == 8'b01000000) out = in6;
    if (sel == 8'b10000000) out = in7;
  end
`endif
endmodule

/* verilator lint_on DECLFILENAME */

