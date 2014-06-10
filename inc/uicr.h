/*
 * Definitions for User Information Configuration Registers (UICR)
 * Copyright (C) 2014  richard
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#ifndef UICR_CONFIG_H
#define UICR_CONFIG_H

/**
 * Generic Macro for defining sectioned constants
 */
#define __SECTION(s)	__attribute__((section(s))) __attribute__((used))

/**
 * Readback Protection
 */
//const uint32_t UICR_RBPCONF   __SECTION(".rbpconf")	= 0xFFFFFFFF;

/**
 * Crystal Frequency. 0xFF = 16MHz, 0x00 = 32MHz
 */
//const uint32_t UICR_XTALFREQ  __SECTION(".xtalfreq")	= 0xFFFFFFFF;


/**
 * Customer Configuation Space
 */
const uint32_t UICR_ADDR_0x80 __SECTION(".custom")	= 0x12345679;
//const uint32_t UICR_ADDR_0x84 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0x88 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0x8C __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0x90 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0x94 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0x98 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0x9C __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xA0 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xA4 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xA8 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xAC __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xB0 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xB4 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xB8 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xBC __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xC0 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xC4 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xC8 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xCC __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xD0 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xD4 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xD8 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xDC __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xE0 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xE4 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xE8 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xEC __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xF0 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xF4 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xF8 __SECTION(".custom")	= 0xFFFFFFFF;
//const uint32_t UICR_ADDR_0xFC __SECTION(".custom")	= 0xFFFFFFFF;

#endif // UICR_CONFIG_H
