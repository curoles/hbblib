/**@file
 * @brief     One-hot Mux "case" implementation 
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

  always @(*)
  begin: MUX
    case(1'b1)
      sel[0]: out = in0;
      sel[1]: out = in1;
      sel[2]: out = in2;
      default: out = {WIDTH{1'bx}};
    endcase
  end
endmodule

/* verilator lint_on DECLFILENAME */

