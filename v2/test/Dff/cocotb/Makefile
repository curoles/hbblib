# make -f config.makefile -f ../hbblib/v2/test/Dff/verilator/Makefile

BUILD_DIR:=$(BUILD_HOME)/Dff/cocotb

.PHONY: build
build: $(BUILD_DIR)
	@echo "Test Dff with CocoTB"
	@echo "CocoTB: $(COCOTB)"
	cd $(BUILD_DIR) && make -f $(BUILD_HOME)/config.makefile -f $(ABS_SOURCE_PATH)/test/Dff/cocotb/cocotb.makefile

$(BUILD_DIR):
	mkdir -p $@
