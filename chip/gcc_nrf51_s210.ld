/* Linker script to configure memory regions. */

/* nRF51822 QFAA with 256kB flash and 16kB RAM. */
MEMORY
{
  FLASH (rx) : ORIGIN = 0x0 + 48K, LENGTH = 256K - 48K                   /* 48 kB is taken by S210, 208 kB for app. */
  RAM (rwx)  : ORIGIN = 0x20000000 + 2K + 256, LENGTH = 16K - (2K + 256) /* 2.25 kB is taken by S210, 13.75 kB for app.  */
}
