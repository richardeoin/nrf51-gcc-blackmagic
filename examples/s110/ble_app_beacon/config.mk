# Configuration makefile
# Copyright (C) 2014  Richard Meadows
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

# Project Name
#
# This is used to define the name of the build artifact
#
PROJECT_NAME		:= ble_app_proximity

# The exact chip being built for.
#
# This should be the top two lines printed on the chip itself,
# separated by an underscore. See nWP-018_v1.2.pdf for more information
#
TARGET_CHIP		:= NRF51822_QFAAGO

# Compiliation Flags
#
# Use this to set the debug level
#
COMPILATION_FLAGS	:= -g3 -ggdb

# Acceptable Warnings
#
#
#
ACCEPT_WARN		:= -Wno-unused-parameter -Wno-old-style-declaration \
				-Wno-unused-local-typedefs

# Linker Flags
#
#
LINKER_FLAGS		:= -Wl,--gc-sections

# The softdevice to be used for this project. Optional
#
# Can be s110, s120, s210 or s310. Leave blank if no softdevice is
# being used.
#
USE_SOFTDEVICE		:= s110

# The path to a specific blackmagic debugger to use. Optional
#
# You can use `make print-symlinks DEVICE=<debugger name>` to find a
# path to the debugger that will be constant for a given device or
# port. When this field is specified GDB will attempt to connect to
# this debugger on startup.
#
BLACKMAGIC_PATH		:=

# The board being used in this project. Optional
#
# The Nordic SDK defines some macros for development kit boards. See
# Include/boards in the SDK for more info.
#
BOARD			:= BOARD_PCA10001

# INCLUDEPATHS
#
# Folders from the SDK Include Directory. Copy this from the example
# makefiles in the SDK
#
INCLUDEPATHS	+= s110
INCLUDEPATHS	+= ble
INCLUDEPATHS	+= ble/ble_services
INCLUDEPATHS	+= app_common
INCLUDEPATHS	+= sd_common

# C_SOURCE_FILES
#
# Add source files from the SDK here. You can copy this directly from
# example makefiles in the SDK.
#
C_SOURCE_FILES += softdevice_handler.c
C_SOURCE_FILES += ble_advdata.c
C_SOURCE_FILES += ble_debug_assert_handler.c
C_SOURCE_FILES += ble_srv_common.c

#
# Directories in the SDK Source Directory where the above
# C_SOURCE_FILES can be found. Copy this from the example makefiles in
# the SDK.
#
C_SOURCE_PATHS	+= ble
C_SOURCE_PATHS	+= app_common
C_SOURCE_PATHS	+= sd_common
