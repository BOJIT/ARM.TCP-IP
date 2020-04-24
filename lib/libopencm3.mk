# libopencm3 Makefile: simply passes everything down to the lower makefile

# Note that ROOT_DIR should be exported from the top-level makefile

############################### CONFIGURATION ##################################

LIB_NAME = libopencm3.mk

# Build directory of device-specific objects
BUILD_DIR = $(ROOT_DIR)/build/$(DEVICE-NAME)/lib


DEPENDENCIES := -L$(BUILD_DIR) -l$(patsubst lib%.a,%,$(DEVICE-FRAMEWORK))

############################# MAKEFILE GLOBALS #################################

# Include global headers/compiler flags
include $(ROOT_DIR)/global.mk

LIBS := $(patsubst $(ROOT_DIR)/lib/%.mk,%,$(wildcard $(ROOT_DIR)/lib/*.mk))

CFLAGS += -c # Don't link files yet	

################################## TARGETS #####################################

# Target will only rebuild if the build directory is cleaned
$(BUILD_DIR)/$(DEVICE-FRAMEWORK):
	mkdir -p $(@D)
	# make libopencm3 (builds for all supported platforms)
	$(MAKE) -C libopencm3
	# copy the desired static library to the build folder
	cp libopencm3/lib/$(DEVICE-FRAMEWORK) $@
	touch $(BUILD_DIR)/libopencm3.dep
	echo "$(DEPENDENCIES)" > $(BUILD_DIR)/libopencm3.dep

