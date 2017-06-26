/**@file
 * @brief     Verilog Test Bench for DFF
 * @author    Igor Lesik
 * @copyright Igor Lesik 2014
 *
 */

module Dve();

    reg  [1:0] d;
    wire [1:0] q;
    reg  clk;

    Dff #(.WIDTH(2)) dff(.clk(clk), .out(q), .in(d));

    integer clock_count = 0;

    initial
    begin
        $display("Dff Verilog TB");
        d = 2'b00;
        clk = 1'b0;

        $monitor("%d  clk:%h Din:%h Qout:%h", 
            $time, clk, d, q);
    end

    always @(posedge clk) begin
        if (clock_count == 1) begin
            //$display("set d=1");
            d <= 1;
        end else if (clock_count == 3) begin
            if (q != d) begin $error("q != d"); $finish_and_return(1); end
        end else if (clock_count == 4) begin
            d <= 3;
        end else if (clock_count == 6) begin
            if (q != d) begin $error("q != d"); $finish_and_return(1); end
            d <= 2;
        end else if (clock_count > 6 && clock_count < 10) begin
            d <= $urandom() % 4;
        end else if (clock_count > 10) begin
            if (q != d) begin $error("q != d"); $finish_and_return(1); end
            $display("Finish TB");
            $finish_and_return(0);
        end
    end


    always
    begin
        #1 clk = ~clk;
        if (clk) clock_count += 1;
    end

endmodule: Dve

