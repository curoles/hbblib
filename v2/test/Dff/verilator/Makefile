# make -f config.makefile -f ../hbblib/v2/test/Dff/verilator/Makefile build

BUILD_DIR:=$(BUILD_HOME)/Dff/verilator

.PHONY: build
build: SRCs:=$(ABS_SOURCE_PATH)/test/Dff/verilator/Dve.v $(ABS_SOURCE_PATH)/src/Dff/Dff.v
build: TB_MAIN:=$(ABS_SOURCE_PATH)/test/Dff/verilator/main.cpp
build: VLOG_OPTS:=--assert -Wall -cc --exe --stats $(SRCs) $(TB_MAIN)

build: $(BUILD_DIR)
	@echo "Test Dff with Verilator"
	@echo "Verilator: $(VERILATOR)"
	cd $(BUILD_DIR) && $(VERILATOR) $(VLOG_OPTS)
	cd $(BUILD_DIR)/obj_dir && make -f VDve.mk VDve
	cd $(BUILD_DIR) && ./obj_dir/VDve

$(BUILD_DIR):
	mkdir -p $@
