Multiplexer: Mux
================

Date: Feb 02, 2015
Synthesis tool: Cadence RTL Compiler 14.10
Cell library: current TSMC

Mux inputs: 8
Width: 8

| style         | area    | gates   | time | Struct                                    |
|---------------|---------|---------|------|-------------------------------------------|
| array select  | 15+48=63| 52(14.8)| 135.5|AN2,32xAOI22,2xIND2,4xINR2,ND2,8xND4,4xNR2 |
| case          | 15+48=63| 52(14.8)| 135.5|as above                                   |
| assign        | 15+48=63| 52(14.8)| 136.9|as above                                   |
