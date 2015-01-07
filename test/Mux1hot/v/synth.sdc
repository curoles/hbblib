set sdc_version 1.7
set_units -capacitance 1000.0fF
set_units -time 1000.0ps
#################################################################################
#create_clock -name "clk" -add -period 1.0 -waveform {0.0 0.5} [get_ports clk]
set_input_delay 0.1 -max -clock clk [all_inputs]
set_output_delay 0.08 -max -clock clk [all_outputs]
#set_max_fanout 16 [current_design]
#set_max_transition 0.100 [current_design]
#set_input_transition 0.05 [get_ports clk]
#set_driving_cell -lib_cell BUFFD4BWP12T35 -pin Z [remove_from_collection [all_inputs] [get_ports clk] ]
set_load -pin_load 0.015 [all_outputs]
set_load -wire_load 0.015 [all_outputs]

#set_input_delay 0.14 -max -clock clk [get_ports Arb*]
#set_input_delay 0.7 -max -clock clk [get_ports Grant]

#set_output_delay 0.34 -max -clock clk [get_ports Sel*]

