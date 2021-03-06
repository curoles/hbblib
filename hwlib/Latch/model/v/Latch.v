/**@file
 * @brief     Latch
 * @author    Igor Lesik
 * @copyright Igor Lesik 2014
 *
 * See paper:
 * Nonblocking Assignments in Verilog Synthesis, Coding Styles That Kill!
 * Clifford E. Cummings
 * http://www.sunburst-design.com/papers/CummingsSNUG2000SJ_NBA_rev1_2.pdf
 *
 * The SystemVerilog standard (section 9.2.2.3 Latched logic always_latch procedure
 * provides the next example:
 *
 *  always_latch
 *  if(ck) q <= d;
 *
 */
module Latch (out, in, enable);
   
  parameter WIDTH = 1;

  input  [WIDTH-1:0] in;
  input              enable;
  output [WIDTH-1:0] out;

  reg  [WIDTH-1:0] out;
  
  always_latch //always @(in or enable)
    if (enable)
      out[WIDTH-1:0] <= in[WIDTH-1:0];

endmodule

