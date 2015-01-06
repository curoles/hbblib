/**@file
 * @brief     Verilog Test Bench for Mux
 * @author    Igor Lesik
 * @copyright Igor Lesik 2014
 *
 */

module Dve();

    reg  [3-1:0] a;
    reg  [3-1:0] b;
    reg  [3-1:0] c;
    reg  [3-1:0] d;
    wire [3-1:0] out;
    wire [3-1:0] out2;
    wire [3-1:0] out3;
    reg  clk;
    reg  select;
    reg  [1:0] select2;
    reg  [2:0] select3;
    //reg  reset;
    //
    wire [(3*8)-1:0] in;
    assign in = {d,c,b,a,d,c,b,a};

    Mux2 #(.WIDTH(3)) mux2(.in0(a), .in1(b), .out(out2), .sel(select));
    Mux3 #(.WIDTH(3)) mux3(.in0(a), .in1(b), .in2(c), .out(out3), .sel(select2));
    Mux  #(.WIDTH(3), .SIZE(3)) mux8(.in(in), .out(out), .sel(select3));

    integer clock_count = 0;

    initial
    begin
        $display("Mux Verilog TB");
        a = 3'b000;
        b = 3'b001;
        c = 3'b010;
        d = 3'b011;
        select = 1'b1;
        select2 = 2'b10;
        select3 = 3'b011;
    end

    always @(posedge clk) begin
        if (clock_count == 1) begin
            //d <= 1;
        end else if (clock_count == 3) begin
            //assert (q == d) $display ("OK. Q equals D");
            //else $error("q != d");
        end else if (clock_count == 4) begin
            //enable <= 0;
        end else if (clock_count == 5) begin
            //d <= 0;
        end else if (clock_count == 6) begin
            //assert (q != d);
            //enable <= 1;
        end else if (clock_count > 10) begin
            assert (out == d) $display("Ok. out is d");
            else $error("out=%h, sel=%h", out, select3);
            assert(out2 == b);
            assert(out3 == c);
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
