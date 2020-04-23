# Note that ROOT_DIR should be exported from the top-level makefile

############################### CONFIGURATION ##################################

DEVICE-NAME := stm32f407xx

DEVICE-FLAGS := -mcpu=cortex-m4 -mthumb
DEVICE-FLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16

DEVICE-FRAMEWORK := libopencm3_stm32f4.a

# Build directory of device-specific objects
BUILD_DIR := $(ROOT_DIR)/build/$(DEVICE-NAME)/dev

OBJECTS := $(BUILD_DIR)/device_functions.o

DEPENDENCIES := -I$(ROOT_DIR)/dev/$(DEVICE-NAME) -DSTM32F4

############################# MAKEFILE GLOBALS #################################

# Include global headers/compiler flags
include $(ROOT_DIR)/global.mk

# Export device-specific headers for use by libraries
export DEVICE-NAME
export DEVICE-FLAGS
export DEVICE-FRAMEWORK

LIBS := $(patsubst $(ROOT_DIR)/lib/%.mk,%,$(wildcard $(ROOT_DIR)/lib/*.mk))

CFLAGS += -c # Don't link files yet	

################################## TARGETS #####################################

default: $(OBJECTS)
	# Build all libraries for each device with appropriate flags
	$(foreach LIB,$(LIBS),$(MAKE) -C$(ROOT_DIR)/lib -f$(patsubst %,%.mk,$(LIB));)
	touch $(BUILD_DIR)/dev.dep
	echo "$(DEPENDENCIES)" > $(BUILD_DIR)/dev.dep


$(BUILD_DIR)/%.o: $(DEVICE-NAME)/%.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) $(DEVICE-FLAGS) $< -o $@

$(BUILD_DIR)/%.o: $(DEVICE-NAME)/%.S
	mkdir -p $(@D)
	$(CC) $(CFLAGS) $(DEVICE-FLAGS) $< -o $@
