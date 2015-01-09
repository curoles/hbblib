/**@file
 * @brief     One-hot Multiplexer 
 * @author    Igor Lesik
 * @copyright Igor Lesik 2014
 *
 */

/* verilator lint_off UNOPTFLAT */

module Mux1hot
#(parameter INPUTS = 2,
  parameter WIDTH  = 1)
(
  input  [WIDTH*INPUTS-1:0] in,
  input  [INPUTS-1:0]       sel,
  output [WIDTH-1:0]        out
);
  wire [WIDTH-1:0] oarr [0:INPUTS];
  assign oarr[INPUTS] = {WIDTH{1'b0}};
  assign out = oarr[0];

  genvar input_id;
  generate
    for (input_id = 0; input_id < INPUTS; input_id = input_id + 1)
    begin
      assign oarr[input_id] = oarr[input_id+1] | {WIDTH{sel[input_id]}} & in[input_id*WIDTH +: WIDTH];
    end
  endgenerate

endmodule

/* verilator lint_off DECLFILENAME */

//`define MUX1HOT_MANUAL_UNROLL

module Mux1hot3 #(parameter WIDTH=1)
(
  input  [WIDTH-1:0]   in0,
  input  [WIDTH-1:0]   in1,
  input  [WIDTH-1:0]   in2,
  input  [3-1:0]       sel,
  output [WIDTH-1:0]   out
);
`ifdef MUX1HOT_MANUAL_UNROLL
  assign out =  ({WIDTH{sel[0]}} & in0) | ({WIDTH{sel[1]}} & in1) | ({WIDTH{sel[2]}} & in2);
`else
  Mux1hot #(.WIDTH(WIDTH), .INPUTS(3))
    mux1h3(.in({in2,in1,in0}), .sel(sel), .out(out));
`endif
endmodule

module Mux1hot8 #(parameter WIDTH=1)
(
  input  [WIDTH-1:0]   in0,
  input  [WIDTH-1:0]   in1,
  input  [WIDTH-1:0]   in2,
  input  [WIDTH-1:0]   in3,
  input  [WIDTH-1:0]   in4,
  input  [WIDTH-1:0]   in5,
  input  [WIDTH-1:0]   in6,
  input  [WIDTH-1:0]   in7,
  input  [8-1:0]       sel,
  output [WIDTH-1:0]   out
);

  Mux1hot #(.WIDTH(WIDTH), .INPUTS(8))
    mux1h8(.in({in7,in6,in5,in4,in3,in2,in1,in0}), .sel(sel), .out(out));
endmodule

/* verilator lint_on DECLFILENAME */
/* verilator lint_on UNOPTFLAT */

