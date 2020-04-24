# Top-Level Makefile: Builds for Multiple Devices

# NOTES:

# - DEVICE-xxxx variables are reserved as variables that are exported when using
#   recursive Make. To avoid confusion, don't use them locally and only declare
#   them when the variable is exported

# RESERVED VARIABLES SO FAR:

# DEVICE-NAME
# DEVICE-FLAGS
# DEVICE-PARAMETERS


############################### CONFIGURATION ##################################

# Project Source Files:
SRC := $(wildcard src/*.c)
INC := $(sort $(dir $(shell find inc -name "*.h")))

############################# MAKEFILE GLOBALS #################################

include global.mk

export ROOT_DIR = $(shell pwd)

# BUILD CONFIG
DEVICES := $(patsubst dev/%.mk,%,$(wildcard dev/*.mk))
clean_DEVICES := $(addprefix clean_,$(DEVICES))
dep_DEVICES := $(addprefix dep_,$(DEVICES))
flash_DEVICES := $(addprefix flash_,$(DEVICES))

# Pretty Terminal Formatting
FORMAT_PURPLE = \033[1m\033[95m
FORMAT_WHITE = \033[1m\033[36m
FORMAT_RED = \033[1m\033[91m
FORMAT_OFF = \033[0m

################################## TARGETS #####################################

.PHONY: all clean flash $(DEVICES) $(dep_DEVICES) $(clean_DEVICES) $(flash_DEVICES)

all: $(DEVICES)

clean: $(clean_DEVICES)

flash: $(flash_DEVICES)

$(DEVICES): % : dep_%
	@echo "$(FORMAT_PURPLE)Building and Linking $@$(FORMAT_OFF)"
	mkdir -p bin/$@
	# Get device-specific files
	$(eval OBJECTS = $(shell find build/$@ -name "*.o"))
	$(eval DEPENDENCIES = $(shell find build/$@ -name "*.dep"))
	$(eval DFLAGS = )
	$(foreach DEP, $(DEPENDENCIES), $(eval DFLAGS += $(shell cat $(DEP))))
	# GCC build and link goes here
	$(CC) $(CFLAGS) $(SRC) $(OBJECTS) $(addprefix -I, $(INC)) \
	-Wl,-Map=bin/$@/$@.map -o bin/$@/$@.elf $(LFLAGS) $(DFLAGS)
	# Copy from ELF to binary format
	$(OBJCOPY) -O binary bin/$@/$@.elf bin/$@/$@.bin

$(dep_DEVICES):
	@echo "$(FORMAT_PURPLE)Building Dependencies for $@$(FORMAT_OFF)"
	# Run makefile for corresponding device
	$(MAKE) -C dev -f $(patsubst dep_%,%.mk,$@)

$(clean_DEVICES):
	# Delete device binary directory
	@echo "$(FORMAT_PURPLE)Cleaning $@$(FORMAT_OFF)"
	rm -rf bin/$(patsubst clean_%,%,$@)
	rm -rf build/$(patsubst clean_%,%,$@)

$(flash_DEVICES): flash_%: %
	# Executes a custom shell script in ./prog: edit preferences there
	./flash/$@.sh
