-include $(BUILD_HOME)/custom.config.makefile
#PATH := /home/igor/tool/icarus/v10_0_20150105/bin:$(PATH)
#export $(PATH)

VERILOG_SOURCES=$(ABS_SOURCE_PATH)/src/Dff/Dff.v 
TOPLEVEL=Dff
MODULE=Dve
include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim
