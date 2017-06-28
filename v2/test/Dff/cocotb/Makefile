# make -f config.makefile -f ../hbblib/v2/test/Dff/verilator/Makefile

BUILD_DIR:=$(BUILD_HOME)/Dff/cocotb

.PHONY: build
build: $(BUILD_DIR)
	@echo "Test Dff with CocoTB"
	@echo "CocoTB: $(COCOTB)"
	#make -C $(BUILD_DIR) -f $(BUILD_HOME)/config.makefile -f $(ABS_SOURCE_PATH)/test/Dff/cocotb/cocotb.makefile
	cp $(BUILD_HOME)/config.makefile $(BUILD_DIR)/.
	cp $(BUILD_HOME)/custom.config.makefile $(BUILD_DIR)/.
	cp $(ABS_SOURCE_PATH)/test/Dff/cocotb/cocotb.makefile $(BUILD_DIR)/Makefile
	cp $(ABS_SOURCE_PATH)/test/Dff/cocotb/dve.py $(BUILD_DIR)/.
	make -C $(BUILD_DIR)

$(BUILD_DIR):
	mkdir -p $@
