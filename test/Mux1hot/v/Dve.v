/**@file
 * @brief     Verilog Test Bench for Mux1hot
 * @author    Igor Lesik
 * @copyright Igor Lesik 2015
 *
 */

module Dve();

    reg  [3-1:0] a;
    reg  [3-1:0] b;
    reg  [3-1:0] c;
    //reg  [3-1:0] d;
    wire [3-1:0] out;
    reg  clk;
    //reg  select;
    //reg  [1:0] select2;
    reg  [2:0] select3;

    //reg  reset;
    //
    //wire [(3*8)-1:0] in;
    //assign in = {a,b,c,d,a,b,c,d};

    Mux1hot3 #(.WIDTH(3)) mux1h3(.in0(a), .in1(b), .in2(c), .sel(select3), .out(out));

    integer clock_count = 0;

    initial
    begin
        $display("Mux1hot Verilog TB");
        a = 3'b000;
        b = 3'b001;
        c = 3'b010;
        //d = 3'b011;
        //select = 1'b1;
        //select2 = 2'b10;
        select3 = 3'b001;
    end

    always @(posedge clk) begin
        if (clock_count == 1) begin
            assert (out == a) $display ("OK. out == a");
            else $error("out != a");
            select3 <= 3'b010;
        end else if (clock_count == 2) begin
            assert (out == b);
            select3 <= 3'b100;
        end else if (clock_count == 3) begin
            assert (out == c);
            select3 <= 3'b111;
        end else if (clock_count == 4) begin
            $display("when bad sel, out=%h", out);
//        end else if (clock_count == 6) begin
//            //assert (q != d);
//            //enable <= 1;
        end else if (clock_count > 10) begin
//            assert (out == 3'b011);
            $display("Finish TB");
            $finish();
        end
    end

    export "DPI-C" task set_clock;

    task set_clock;
        input bit in_bool;
        clk = in_bool;
        if (clk) begin
            clock_count += 1;
            $display("Ticking %d", clock_count);
        end
    endtask

    export "DPI-C" task set_reset;

    task set_reset;
        input bit in_bool;
        //reset = in_bool;
    endtask

endmodule: Dve
