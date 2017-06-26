# make -f config.makefile -f ../hbblib/v2/test/Dff/verilator/Makefile build

BUILD_DIR:=$(BUILD_HOME)/Dff/verilator

.PHONY: build
build: SRCs:=$(SOURCE_PATH)/src/Dff/Dff.v
build: $(BUILD_DIR)
	@echo "Test Dff with Verilator"
	@echo "Verilator: $(VERILATOR)"
	#$(IVERILOG) -g2005-sv -o $(BUILD_DIR)/dve $(SRCs)
	#cd $(BUILD_DIR) && $(ICARUS_VVP) dve

$(BUILD_DIR):
	#@echo "Test directory: $@"
	mkdir -p $@
