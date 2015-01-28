One-hot Multiplexer with Default Input: Mux1hotWithDefault
=========================================================

Date: Jan 27, 2015
Synthesis tool: Cadence RTL Compiler 14.10
Cell library: current TSMC

Mux inputs: 8
Width: 8

| style         | area    | gates   | time | Struct                                    |
|---------------|---------|---------|------|-------------------------------------------|
| (in&sel)+mux  | 15+30=45| 51(14.6)| 116  | 32xAOI22,8xMUX2,ND2,8xND4,2xNR4           |
| case          | 18+65=83| 65(18.0)| 200  | 8xAO21,32xAOI22,2xIINR,IND2,4xINR4,2xINR4,8xND4,2xNR2,4xOR2,2xOR4|
| casez         | 17+52=70| 58(17.4)| 178  | AN2,8xAO22,8xAOI211,8xAOI222,8xAOI22,2xIINR3,IINR4,INR2,2xINR3,INR4,8xIOAI21,ND2,8xND2,NR3|

