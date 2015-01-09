/**
 * @brief     1-hot Mux TB
 * @author    Igor Lesik 2015
 * @copyright Igor Lesik 2015
 */

module Dve();

    localparam WIDTH = 3;
    localparam INPUTS  = 3;


    wire               clk;
    wire               reset;
    reg   [INPUTS-1:0]   select;
    wire  [WIDTH-1:0]  out;
    reg   [(INPUTS*WIDTH)-1:0] in;

    SimClkGen #(.PERIOD(1), .DEBUG(0)) clk_gen(.clk(clk));
    SimRstGen #(.TIMEOUT(1)) rst_gen(.clk(clk), .reset(reset));

    /*bind Mux*/ Mux_checker #(.WIDTH(WIDTH), .INPUTS(INPUTS)) mux_checker(
        .in(in), .out(out), .select(select), .clk(clk), .reset(reset)
    );
    Mux1hot #(.WIDTH(WIDTH), .INPUTS(INPUTS))
        mux(.in(in), .out(out), .sel(select));

    initial
    begin
        in = 'b111_110_101_100_011_010_001;
        select = 'h1;

        $monitor("%d clk:%h select:%h log2(sel):%h out:%h in:%b", 
            $time, clk, select, $clog2(select), out, in);

        repeat(INPUTS) begin
            @(posedge clk);
            assert(out == in[$clog2(select)*WIDTH +: WIDTH]) else $fatal(1);
            select = select << 1;
        end

        $finish();
    end


endmodule: Dve
