One-hot Multiplexer: Mux1hot
============================

Date: Jan 8, 2015
Synthesis tool: Cadence RTL Compiler 14.10
Cell library: current TSMC

Mux inputs: 3
Width: 8

One-hot multiplexer normal operation assumes that only one bit of select is active (hot).
Defensive one-hot mux coding can set output to some predefined value like <code>{WIDTH{1'1x}}</code>
when more than one select bit is 1 to indicate incorrect operation (in simulation).

Allowed time (constrain): NONE

Results:

| style         | area    | gates   | notes                                                  |
|---------------|---------|---------|--------------------------------------------------------|
| T \|(in&sel)  | 5+7 =12 | 16 (5)  |<code>o[i] = o[i+1] \| {W{sel[i]}} & in[i*W +: W]<code> |
| T w/o gen     | 5+7 =12 | 16 (5)  |like prev. but manually unrolled instead "generate"     |
| U case        | 5+14=20 | 18 (5.4)|<code>case(sel) 3'b001: out = in0;</code>               |
| T case        | 5+7 =12 | 16 (5)  |<code>case(1'b1) sel[0]: out = in0;</code>              |
| U assign      | 6+19=25 | 19 (5.8)|<code>assign out = (sel == 3'b001) ? in0:(sel == 3'b010) ? in1:</code>|
| T assign      | 5+14=20 | 18 (5.4)|<code>assign out = (sel[0]) ? in0:(sel[1]) ? in1:</code>|
| U if          | 6+19=25 | 19 (5.8)|<code>if (sel == 3'b001) out = in0;</code>              |
| T if          | 5+14=20 | 18 (5.4)|<code>if (sel[0]) out = in0;</code>                     |
| T ifelse      | 5+7 =12 | 16 (5)  |<code>if (sel[0]) out = in0; else if (sel[1]) out = in1;</code>|
| U ifelse      | 5+14=20 | 18 (5.4)|<code>if (sel == 3'b001) out = in0;else if (sel == 3'b010) out = in1;</code>|

Sorted results:

|Place|Style                                      |Area |gates
|-----|-------------------------------------------|-----|---------
|1    | TRUSTED (in&sel),case,ifelse              | 12  | 16
|2    | UNTRUSTED case, ifelse; TRUSTED assign,if | 20  | 18
|3    | UNTRUSTED assign,if                       | 25  | 19

Conclusions:

* RC treats "generate" nicely and generates the same code as done manually;
* "trusted" one-hot versions are smaller; perhaps it makes sense to have assertions
  during simulations to catch bugs, but productions chip should use faster "trusted" version;
* code using "assign" and "if" synthesises to bigger # of gates and area;
* (in&sel), case and ifelse synthesise to the same # gates, but (in&sel) allows
  for very generic code;



Jan 16

Time constraints DO make difference, 1-10ps => 16->26 gates, 100ps still trying hard, 200ps relaxed
Allowed time (constrain): 200ps

Results:

| style         | area    | gates   | time | Struct                                    |
|---------------|---------|---------|------|-------------------------------------------|
| T \|(in&sel)  | 5+7 =12 | 16 (5)  | 120  |8xAOI22,8xIOA21                            |
| T w/o gen     | 5+7 =12 | 16 (5)  | 120  |8xAOI22,8xIOA21                            |
| U case        | 5+7 =12 | 16 (5)  | 119  |8xAOI22,8xIOA21                            |
| T case        | 7+14=21 | 18 (6.7)| 145  |8xAO21,8xAO22,INR2,NR2                     |
| U assign      | 7+19=26 | 19 (7.2)| 200  |8xAO21,8xAO22,INR3,INR3,NR2                |
| T assign      | 7+14=21 | 18 (6.7)| 151  |8xAO21,8xAO22,INR2,NR2                     |
| U if          | 7+19=26 | 19 (7.2)| 200  |8xAO21,8xAO22,INR3,INR3,NR2                |
| T if          | 7+14=20 | 18 (6.7)| 151  |8xAO21,8xAO22,INR2,NR2                     |
| U ifelse      | 5+7 =12 | 16 (5)  | 119  |8xAOI22,8xIOA21                            |
| T ifelse      | 7+14=21 | 18 (6.7)| 151  |8xAO21,8xAO22,INR2,NR2                     |

8 inputs

| style         | area    | gates   | time | Struct                                    |
|---------------|---------|---------|------|-------------------------------------------|
| T \|(in&sel)  | 14+27=41| 40(14.1)| 139  |32xAOI22,8xND4                             |
| U case        | 14+27=41| 40(14.1)| 139  |32xAOI22,8xND4                             |
| T case        | 19+58=77| 50(18.6)| 198  |2xAN2,8xAOI221,8xAOI222,8xAOI22,1IIND3,2xIINR3,INR3,8xIOA21,8xND2,NR2,NR3|
| U assign      | 14+27=41| 40(14.1)| 139  |32xAOI22,8xND4
| T assign      | 19+58=77| 50(18.6)| 198  | see T case
| U if          | =?? | .. (?.?)| ???  |
