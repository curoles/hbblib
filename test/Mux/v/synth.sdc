set sdc_version 1.7
set_units -capacitance 1000.0fF
set_units -time 1.0ps
#################################################################################
create_clock -name "clk" -add -period 1000.0 -waveform {0.0 0.5}
set_input_delay 0.0 -max -clock clk [all_inputs]
set_output_delay 800.0 -max -clock clk [all_outputs]
set_load -pin_load 0.015 [all_outputs]
set_load -wire_load 0.015 [all_outputs]

