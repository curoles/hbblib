/**@file
 * @brief     One-hot Mux "if-else" implementation 
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
    if      (sel[0]) out = in0;
    else if (sel[1]) out = in1;
    else if (sel[2]) out = in2;
    else             out = {WIDTH{1'bx}};
  end
`else
  always @(*)
  begin: MUX
    if      (sel == 3'b001) out = in0;
    else if (sel == 3'b010) out = in1;
    else if (sel == 3'b100) out = in2;
    else                    out = {WIDTH{1'bx}};
  end
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
  output reg [WIDTH-1:0] out
);
`ifdef MUX1HOT_TRUST_SELECT
  always @(*)
  begin: MUX
    if      (sel[0]) out = in0;
    else if (sel[1]) out = in1;
    else if (sel[2]) out = in2;
    else if (sel[3]) out = in3;
    else if (sel[4]) out = in4;
    else if (sel[5]) out = in5;
    else if (sel[6]) out = in6;
    else if (sel[7]) out = in7;
    else             out = {WIDTH{1'bx}};
  end
`else
  always @(*)
  begin: MUX
    if      (sel == 8'b00000001) out = in0;
    else if (sel == 8'b00000010) out = in1;
    else if (sel == 8'b00000100) out = in2;
    else if (sel == 8'b00001000) out = in3;
    else if (sel == 8'b00010000) out = in4;
    else if (sel == 8'b00100000) out = in5;
    else if (sel == 8'b01000000) out = in6;
    else if (sel == 8'b10000000) out = in7;
    else                         out = {WIDTH{1'bx}};
  end
`endif
endmodule

/* verilator lint_on DECLFILENAME */

