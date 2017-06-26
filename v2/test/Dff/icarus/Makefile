# make -f config.makefile -f ../hbblib/v2/test/Dff/verilator/Makefile

BUILD_DIR:=$(BUILD_HOME)/Dff/icarus

.PHONY: test
test: SRCs:=$(SOURCE_PATH)/src/Dff/Dff.v $(SOURCE_PATH)/test/Dff/icarus/Dve.v
test: $(BUILD_DIR)
	@echo "Test Dff with Icarus"
	@echo "iverilog: $(IVERILOG)"
	$(IVERILOG) -g2012 -gassertions -o $(BUILD_DIR)/dve $(SRCs)
	cd $(BUILD_DIR) && $(ICARUS_VVP) dve

$(BUILD_DIR):
	mkdir -p $@
