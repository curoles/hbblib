/**@file
 * @brief     One-hot Mux "if" implementatation
 * @author    Igor Lesik
 * @copyright Igor Lesik 2015
 *
 */


module Mux1hot
#(parameter INPUTS = 2,
  parameter WIDTH  = 1)
(
  input  [WIDTH*INPUTS-1:0] in,
  input  [INPUTS-1:0]       sel,
  output reg [WIDTH-1:0]    out
);
  genvar input_id;

  always @(in or sel)
  begin: MUX
    out = {WIDTH{1'bx}};
    for (input_id = 0; input_id < INPUTS; input_id = input_id + 1) begin
      if (sel[input_id] == 1'b1) out = in[input_id*WIDTH +: WIDTH];
    end
  end

endmodule
/* verilator lint_off DECLFILENAME */

module Mux1hot3 #(parameter WIDTH=1)
(
  input  [WIDTH-1:0]   in0,
  input  [WIDTH-1:0]   in1,
  input  [WIDTH-1:0]   in2,
  input  [3-1:0]       sel,
  output [WIDTH-1:0]   out
);

  Mux1hot #(.WIDTH(WIDTH), .INPUTS(3))
    mux1h3(.in({in2,in1,in0}), .sel(sel), .out(out));
endmodule

/* verilator lint_on DECLFILENAME */

