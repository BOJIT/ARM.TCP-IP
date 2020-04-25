# libopencm3 Makefile: simply passes everything down to the lower makefile

# Note that ROOT_DIR should be exported from the top-level makefile

############################### CONFIGURATION ##################################

LIB_NAME = libopencm3

# Build directory of device-specific objects
BUILD_DIR = $(ROOT_DIR)/build/$(DEVICE-NAME)/lib

LDEPS := -L$(BUILD_DIR) -l$(patsubst lib%.a,%,$(DEVICE-FRAMEWORK))

############################# MAKEFILE GLOBALS #################################

# Include global headers/compiler flags
include $(ROOT_DIR)/global.mk

################################## TARGETS #####################################

# Target will only rebuild if the build directory is cleaned
$(BUILD_DIR)/$(DEVICE-FRAMEWORK):
	mkdir -p $(@D)
	# make libopencm3 (builds for all supported platforms)
	$(MAKE) -C $(LIB_NAME)
	# copy the desired static library to the build folder
	cp $(LIB_NAME)/lib/$(DEVICE-FRAMEWORK) $@
	touch $(BUILD_DIR)/$(LIB_NAME).ldep
	echo "$(LDEPS)" > $(BUILD_DIR)/$(LIB_NAME).ldep

