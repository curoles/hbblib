-include config.makefile
-include custom.config.makefile

COMPILE_ARGS=-g2012
VERILOG_SOURCES=$(ABS_SOURCE_PATH)/src/Dff/Dff.v 
TOPLEVEL=Dff
MODULE=dve
include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim
