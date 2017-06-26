/**@file
 * @brief     Verilog Test Bench for DFF
 * @author    Igor Lesik
 * @copyright Igor Lesik 2014
 *
 */

module Dve();

    reg  d;
    wire q;
    reg  clk;

    Dff #(.WIDTH(1)) dff(.clk(clk), .out(q), .in(d));

    integer clock_count = 0;

    initial
    begin
        $display("Dff Verilog TB");
        d = 1'b0;
        clk = 1'b0;

        $monitor("%d  clk:%h Din:%h Qout:%h", 
            $time, clk, d, q);
    end

    always @(posedge clk) begin
        if (clock_count == 1) begin
            //$display("set d=1");
            d <= 1;
        end else if (clock_count == 3) begin
            assert (q == d) $display ("OK. Q equals D");
            else $error("q != d");
        end else if (clock_count == 4) begin
            d <= 0;
        end else if (clock_count == 6) begin
            assert (q == d);
            d <= 1;
        end else if (clock_count > 10) begin
            assert (q == d);
            $display("Finish TB");
            $finish();
        end
    end


    always
    begin
        #1 clk = ~clk;
    end

endmodule: Dve

