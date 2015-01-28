module Mux1hotWithDefault8 #(parameter WIDTH=1)
(
  input  [WIDTH-1:0]     in0,
  input  [WIDTH-1:0]     in1,
  input  [WIDTH-1:0]     in2,
  input  [WIDTH-1:0]     in3,
  input  [WIDTH-1:0]     in4,
  input  [WIDTH-1:0]     in5,
  input  [WIDTH-1:0]     in6,
  input  [WIDTH-1:0]     in7,
  input  [WIDTH-1:0]     dflt,
  input  [8-1:0]         sel,
  output reg [WIDTH-1:0] out
);
  always @(*)
  begin: MUX
    casez(sel)
      8'b???????1: out = in0;
      8'b??????1?: out = in1;
      8'b?????1??: out = in2;
      8'b????1???: out = in3;
      8'b???1????: out = in4;
      8'b??1?????: out = in5;
      8'b?1??????: out = in6;
      8'b1???????: out = in7;
      default: out = dflt;
    endcase
  end

endmodule

