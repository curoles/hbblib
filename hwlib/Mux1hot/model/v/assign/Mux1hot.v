/**@file
 * @brief     One-hot Mux "assign" implementation 
 * @author    Igor Lesik
 * @copyright Igor Lesik 2015
 *
 */

`define MUX1HOT_TRUST_SELECT

/* verilator lint_off DECLFILENAME */

module Mux1hot3 #(parameter WIDTH=1)
(
  input  [WIDTH-1:0]     in0,
  input  [WIDTH-1:0]     in1,
  input  [WIDTH-1:0]     in2,
  input  [3-1:0]         sel,
  output [WIDTH-1:0] out
);
`ifdef MUX1HOT_TRUST_SELECT
  assign out = (sel[0]) ? in0:
               (sel[1]) ? in1:
               (sel[2]) ? in2:
               {WIDTH{1'bx}};
`else
  assign out = (sel == 3'b001) ? in0:
               (sel == 3'b010) ? in1:
               (sel == 3'b100) ? in2:
               {WIDTH{1'bx}};
`endif
endmodule

module Mux1hot8 #(parameter WIDTH=1)
(
  input  [WIDTH-1:0]     in0,
  input  [WIDTH-1:0]     in1,
  input  [WIDTH-1:0]     in2,
  input  [WIDTH-1:0]     in3,
  input  [WIDTH-1:0]     in4,
  input  [WIDTH-1:0]     in5,
  input  [WIDTH-1:0]     in6,
  input  [WIDTH-1:0]     in7,
  input  [8-1:0]         sel,
  output [WIDTH-1:0] out
);
`ifdef MUX1HOT_TRUST_SELECT
  assign out = (sel[0]) ? in0:
               (sel[1]) ? in1:
               (sel[2]) ? in2:
               (sel[3]) ? in3:
               (sel[4]) ? in4:
               (sel[5]) ? in5:
               (sel[6]) ? in6:
               (sel[7]) ? in7:
               {WIDTH{1'bx}};
`else
  assign out = (sel == 8'b00000001) ? in0:
               (sel == 8'b00000010) ? in1:
               (sel == 8'b00000100) ? in2:
               (sel == 8'b00001000) ? in3:
               (sel == 8'b00010000) ? in4:
               (sel == 8'b00100000) ? in5:
               (sel == 8'b01000000) ? in6:
               (sel == 8'b10000000) ? in7:
               {WIDTH{1'bx}};
`endif
endmodule

