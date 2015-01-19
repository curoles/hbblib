HDL coding styles and synthesis
===============================

High-level Hardware Description Language (HDL) like Verilog or VHDL allows
RTL designers to operate with high-level concepts and generally gives a lot
of flexibility. The same result or functional behaviour can be achieved
by many different ways (coding styles); a lot of behavioural coding styles
that were not synthesizable in past are synthesizable now days. While the
choice of a particular coding style might not matter much so long as design
works correctly, RTL designers and Physical Design team should be aware
of possible optimizations.

HDL coding style may affect:

* ASIC timing and area as different high-level constructs could be synthesized differently;
* FPGA emulation timing and number of gates used;
* RTL software simulation speed

For big RTL designs it could be worth to consider manually crafted library
of basic blocks optimized for different needs, possibly for
all 3 aforementioned reasons and a switch to select one.

Having the best cell and net layout and area for the basic design blocks
can greatly simplify work of PD team later on and shorten overall design development time.

Of course, all optimizations are specific to the tools: cell library, FPGA emulator or RTL simulator.
