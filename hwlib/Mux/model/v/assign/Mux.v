/**@file
 * @brief     Mux (in & sel) implementation
 * @author    Igor Lesik
 * @copyright Igor Lesik 2015
 *
 */

/* verilator lint_off UNOPTFLAT */

module Mux
#(
  parameter WIDTH     = 1,
  parameter SIZE      = 1,
  parameter INPUTS    = 2**SIZE
)
(
  input  [WIDTH*INPUTS-1:0] in,
  input  [SIZE-1:0]           sel,
  output [WIDTH-1:0]          out
);

  wire [WIDTH-1:0] oarr [0:INPUTS];
  assign oarr[INPUTS] = {WIDTH{1'b0}};
  assign out = oarr[0];

  genvar input_id;
  generate
    for (input_id = 0; input_id < INPUTS; input_id = input_id + 1)
    begin
      assign oarr[input_id] = oarr[input_id+1] | ({WIDTH{sel==input_id}} & in[input_id*WIDTH +: WIDTH]);
    end
  endgenerate

endmodule

/* verilator lint_off DECLFILENAME */


module Mux8 #(parameter WIDTH=1)
(
  input  [WIDTH-1:0]   in0,
  input  [WIDTH-1:0]   in1,
  input  [WIDTH-1:0]   in2,
  input  [WIDTH-1:0]   in3,
  input  [WIDTH-1:0]   in4,
  input  [WIDTH-1:0]   in5,
  input  [WIDTH-1:0]   in6,
  input  [WIDTH-1:0]   in7,
  input  [3-1:0]       sel,
  output [WIDTH-1:0]   out
);

  Mux #(.WIDTH(WIDTH), .SIZE(3))
    mux8(.in({in7,in6,in5,in4,in3,in2,in1,in0}), .sel(sel), .out(out));
endmodule

/* verilator lint_on DECLFILENAME */
/* verilator lint_on UNOPTFLAT */

