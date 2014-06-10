# Compiles firmware written in C and assembler for the nRF51
# Copyright (C) 2014
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#
# The primary targets in this file are:
#
# all				Everything
# softdevice			Generates a softdevice object from .hex
# print-symlinks DEVICE=<dev>	Prints any symlinks to a given device
# clean				Removes generated files
#
# This makefile is intended to be run from the root of the project.
#

# External configuration makefile
#
# Edit the project name, and compilation flags etc. in this makefile
#
-include config.mk

# Directories
#
# These define the locations of the source, nordic sdk and output trees.
#
SDK_PATH	:= sdk/
OUTPUT_PATH	:= out/
SOURCE_TREE	:= src/
INCLUDE_PATH	:= inc/

# Shell Commands
#
# Listed here for portability.
#
CAT		:= cat
ECHO		:= echo
FIND		:= find
GREP		:= grep
MKDIR		:= mkdir -p
RM		:= rm -r
SED		:= sed
SHUF		:= shuf

# ARM GCC Toolchain
#
# These tools are available from https://launchpad.net/gcc-arm-embedded/ and
# should be placed on your path. ALternatively you could compile your own.
#
TOOLCHAIN  	:= arm-none-eabi
AS		:= $(TOOLCHAIN)-as
CC		:= $(TOOLCHAIN)-gcc
CXX		:= $(TOOLCHAIN)-g++
OBJCOPY		:= $(TOOLCHAIN)-objcopy
OBJDUMP		:= $(TOOLCHAIN)-objdump
SIZE		:= $(TOOLCHAIN)-size

# The nRF51 series is based on an ARM Cortex M0 core
#
#
DEVICE		:= NRF51
ARCH_FLAGS 	:= -mthumb -mcpu=cortex-m0 -march=armv6-m -mfloat-abi=soft

# Compilation Flags
#
# Display all warnings. Compile functions and data into their own sections so
# they can be discarded if unused.  The linker performs garbage collection of
# unused input sections.
#
CFLAGS		= $(COMPILATION_FLAGS) -Wall -Wextra $(ACCEPT_WARN) -std=gnu99 \
			-ffunction-sections -fdata-sections $(ARCH_FLAGS)
ASFLAGS		= -Wall $(ARCH_FLAGS) -a=/dev/null
LDFLAGS		= $(COMPILATION_FLAGS) $(LINKER_FLAGS) -Wextra $(ARCH_FLAGS)

# Compilation Defines
#
# These are available for use as macros
#
ifdef DEVICE
CFLAGS		+= -D$(DEVICE)
endif
ifdef BOARD
CFLAGS		+= -D$(BOARD)
endif
ifdef TARGET_CHIP
CFLAGS		+= -D$(TARGET_CHIP)
endif

# SDK Paths
#
#
SDK_INCLUDE_PATH	+= $(SDK_PATH)Include/
SDK_SOURCE_PATH		+= $(SDK_PATH)Source/
CMSIS_INCLUDE_PATH 	+= $(SDK_PATH)Include/gcc/

# Add the relavent bits of the SDK to our paths
#
#
INCLUDE_PATH	+= $(SDK_INCLUDE_PATH)
INCLUDE_PATH	+= $(CMSIS_INCLUDE_PATH)
SOURCE_PATH	+= $(SDK_SOURCE_PATH)
SOURCE_PATH	+= $(wildcard $(SDK_SOURCE_PATH)*/)

# Softdevice
#
#
ifdef USE_SOFTDEVICE
    INCLUDE_PATH	+= $(SDK_INCLUDE_PATH)$(USE_SOFTDEVICE)/
    INCLUDE_PATH	+= $(SDK_INCLUDE_PATH)app_common/
    INCLUDE_PATH	+= $(SDK_INCLUDE_PATH)sd_common/

    SOFTDEVICE		:= $(wildcard softdevice/$(USE_SOFTDEVICE)*_softdevice.hex)
    SOFTD_SOURCES	:= softdevice/uicr/$(basename $(notdir $(SOFTDEVICE)))_uicr.c
else
    USE_SOFTDEVICE = blank
endif

# Parse softdevice name to determine if bluetooth or ant libraries are required
#
#
ifeq ($(USE_SOFTDEVICE), s110)
    USE_BLE = 1
endif
ifeq ($(USE_SOFTDEVICE), s120)
    USE_BLE = 1
endif
ifeq ($(USE_SOFTDEVICE), s210)
    USE_ANT = 1
endif
ifeq ($(USE_SOFTDEVICE), s310)
    USE_BLE = 1
    USE_ANT = 1
endif

# Bluetooth includes
#
#
ifdef USE_BLE
    INCLUDE_PATH	+= $(SDK_INCLUDE_PATH)ble/
    INCLUDE_PATH	+= $(SDK_INCLUDE_PATH)ble/ble_services/
    SOURCE_PATH		+= $(SDK_SOURCE_PATH)ble/ble_services/
    CFLAGS		+= -DBLE_STACK_SUPPORT_REQD
endif

# ANT includes
#
#
ifdef USE_ANT
    CFLAGS	+= -DANT_STACK_SUPPORT_REQD
endif

# Startup and system code
#
#
#
STARTUP		?= chip/startup_nrf51.s
SYSTEMDEF	?= system_nrf51.c

# Linker Scripts
#
#
LINKERS		?= chip/gcc_nrf51_$(USE_SOFTDEVICE).ld chip/gcc_nrf51_common.ld

# Our compilation target
#
#
TARGET		:= $(OUTPUT_PATH)$(addsuffix _$(USE_SOFTDEVICE), $(PROJECT_NAME))

# Build our list of all our sources
#
# The entirety of the source directory are included, along with
# everything in certain directories in the SDK. This has security
# implications: Anything that makes it into your source tree will get
# compiled and linked into your binary.
#
VPATH		= $(SOURCE_PATH)
TREE_SOURCES	= $(shell $(FIND) $(SOURCE_TREE) -name '*.[csS]')
SOURCES 	= $(STARTUP) $(SYSTEMDEF) $(TREE_SOURCES) $(APP_SOURCES) $(SOFTD_SOURCES)

# Translate this list of sources into a list of required objects in
# the output directory.
objects		= $(patsubst %.c,%.o,$(patsubst %.s,%.o,$(patsubst %.S,%.o, \
			$(SOURCES))))
OBJECTS		= $(addprefix $(OUTPUT_PATH),$(objects))

# The softdevice object
#
SOFTD_OBJECT	:= $(addprefix $(OUTPUT_PATH),$(basename $(SOFTDEVICE)))

# Default target
#
#
all: $(TARGET).elf softdevice

# Softdevice target
#
#
ifneq ($(USE_SOFTDEVICE), blank) # If we are using a softdevice
    softdevice: $(SOFTD_OBJECT).elf gdbscript
else
    softdevice:
endif

# Rule for generating object and dependancy files from source files.
#
# Creates a directory in the output tree if nessesary. File is only
# compiled, not linked. Dependancy generation is automatic, but only
# for user header files. Every depandancy in the .d is appended to the
# .d as a target, so that if they stop existing the corresponding
# object file will be re-compiled.
#
$(OUTPUT_PATH)%.o: %.c
	@$(ECHO)
	@$(ECHO) 'Compiling $<...'
	@$(MKDIR) $(OUTPUT_PATH)$(dir $<)
	$(CC) -c -MMD $(CPPFLAGS) $(CFLAGS) $(addprefix -I,$(INCLUDE_PATH)) -o $@ $<
	@$(SED) -e 's/#.*//' -e 's/^[^:]*: *//' -e 's/ *\\$$//' -e '/^$$/ d' \
		-e 's/$$/ :/' < $(OUTPUT_PATH)$*.d >> $(OUTPUT_PATH)$*.d;

# Attempt to include the dependany makefiles for every object in this makefile.
#
# This means that object files depend on the header files they include.
#
-include $(OBJECTS:.o=.d)

# Rule for generating object files from assembler files
#
# Creates a directory in the output tree if nessesary. The file is only
# assembled, not linked.
#
$(OUTPUT_PATH)%.o: %.s
	@$(ECHO)
	@$(ECHO) 'Assembling $<...'
	@$(MKDIR) $(OUTPUT_PATH)$(dir $<)
	$(AS) $(ASFLAGS) -o $@ $<

# Generate the main build artifact.
#
# A .elf containing all the symbols (i.e. debugging information if the compiler
# / linker was run with -g) is created, alongside an intel hex file. A just
# about human-readable .map is also created.
#
$(TARGET).elf: $(OBJECTS) $(LINKERS) gdbscript Makefile config.mk
	@$(ECHO)
	@$(ECHO) 'Linking $@...'
	$(CC) $(LDFLAGS) $(addprefix -T,$(LINKERS)) -Wl,-Map,$(@:.elf=.map) -o $@ $(OBJECTS)
	@$(OBJCOPY) -O ihex $@ $(@:.elf=.hex)
	@$(ECHO)
	$(SIZE) $@
	@$(ECHO)
	@$(SIZE) $@ | tail -1 - \
		| awk '{print "ROM Usage: "int(($$1+$$2)/10.24)/100"K"}'
	@$(SIZE) $@ | tail -1 - \
		| awk '{print "RAM Usage: "int(($$2+$$3)/10.24)/100"K"}'

# Generate softdevice objects
#
#
$(OUTPUT_PATH)%.elf: %.hex
	@$(ECHO)
	@$(ECHO) 'Generating object for $(notdir $(basename $<))...'
	@$(MKDIR) $(dir $@)
	@$(OBJCOPY) -I ihex -B ARM -O elf32-littlearm $< $@
	@$(ECHO)
	$(SIZE) $@
	@$(ECHO)

# Creates debugging command list for gdb
#
# These tell gdb which file to debug and which debugger to use
#
gdbscript: Makefile config.mk
	@$(ECHO) "# Load our .elf file into GDB" > gdbscript
	@$(ECHO) "file $(TARGET).elf" >> gdbscript
ifdef BLACKMAGIC_PATH
	@$(ECHO) "# Connect to a specified blackmagic" >> gdbscript
	@$(ECHO) "target external-remote $(BLACKMAGIC_PATH)" >> gdbscript
endif
ifneq ($(USE_SOFTDEVICE), blank) # If we are using a softdevice
	@$(ECHO) "define load_softdevice" >> gdbscript
	@$(ECHO) "	file $(SOFTD_OBJECT).elf" >> gdbscript
	@$(ECHO) "	load" >> gdbscript
	@$(ECHO) "	file $(TARGET).elf" >> gdbscript
	@$(ECHO) "end" >> gdbscript
endif

# Prints a list of symlinks to a device
#
# Use it like `make print-symlinks DEVICE=/dev/ttyACM0`
#
.PHONY: print-symlinks
print-symlinks:
	@$(ECHO) 'Symlinks to $(DEVICE):'
	@udevadm info --query symlink -n $(DEVICE) | \
		$(SED) -e 's/ /\n/' | $(SED) -e 's/^/\t/'

# Removes everything in the output directory
#
#
#
.PHONY: clean
clean:
	$(RM) $(OUTPUT_PATH)*
	$(RM) gdbscript