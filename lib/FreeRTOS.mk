# libopencm3 Makefile: simply passes everything down to the lower makefile

# Note that ROOT_DIR should be exported from the top-level makefile

############################### CONFIGURATION ##################################

LIB_NAME = FreeRTOS

# Build directory of device-specific objects
BUILD_DIR = $(ROOT_DIR)/build/$(DEVICE-NAME)/lib

LIB_ROOT = $(ROOT_DIR)/lib/$(LIB_NAME)/FreeRTOS/Source

SRC := croutine.c event_groups.c list.c queue.c stream_buffer.c tasks.c timers.c
SRC += portable/MemMang/heap_4.c portable/$(DEVICE-RTOS)/port.c

OBJECTS = $(patsubst %.c,$(BUILD_DIR)/%.o,$(SRC))

INC := -I$(LIB_ROOT)/include -I$(LIB_ROOT)/portable/$(DEVICE-RTOS)/
INC += -I$(ROOT_DIR)/inc

LDEPS := $(INC) -L$(BUILD_DIR) -l$(LIB_NAME)

############################# MAKEFILE GLOBALS #################################

# Include global headers/compiler flags
include $(ROOT_DIR)/global.mk

CFLAGS += -c # Don't link files yet	

################################## TARGETS #####################################

# Archive into static library
$(BUILD_DIR)/lib$(LIB_NAME).a: $(OBJECTS)
	mkdir -p $(@D)
	$(AR) rcs $@ $^
	touch $(BUILD_DIR)/$(LIB_NAME).ldep
	echo "$(LDEPS)" > $(BUILD_DIR)/$(LIB_NAME).ldep


$(OBJECTS): $(BUILD_DIR)/%.o : $(LIB_ROOT)/%.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) $(DEVICE-FLAGS) $(INC) $^ -o $@
	

