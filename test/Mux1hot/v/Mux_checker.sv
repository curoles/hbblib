/**@file
 * @brief     1-hot Mux verification
 * @author    Igor Lesik
 * @copyright Igor Lesik 2015
 */
program Mux_checker(in, out, select, clk, reset);

  parameter WIDTH   = 1;
  parameter INPUTS  = 2;

  input  [(INPUTS*WIDTH)-1:0] in;
  input  [WIDTH-1:0] out;
  input  [INPUTS-1:0]  select;
  input              clk;
  input              reset;


ERROR_output_is_not_selected_input:
  assert property (
    @(clk)
    disable iff (reset)
    (out==in[$clog2(select)*WIDTH +: WIDTH])
  );


endprogram

