/**@file
 * @brief     Rising edge triggered D Flip Flop.
 * @author    Igor Lesik
 * @copyright Igor Lesik 2014-2017
 *
 */


/** Rising edge triggered D Flip Flop.
 *
 */
module Dff #(parameter WIDTH=1)
(
    input  wire clk,
    output reg  [WIDTH-1:0] out,
    input  wire [WIDTH-1:0] in
);

    always @(posedge clk)
    begin
        out[WIDTH-1:0] <= in[WIDTH-1:0];
    end

`ifdef DFF_RANDOMIZE_INITIAL_VALUE
    initial begin
        out = $urandom_range(2**WIDTH - 1, 0);
    end
`endif

endmodule: Dff
