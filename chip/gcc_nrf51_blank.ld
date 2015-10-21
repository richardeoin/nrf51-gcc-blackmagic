/* Linker script to configure memory regions. */

/* nRF51822 QFAA with 256kB flash and 16kB RAM. */
MEMORY
{
  FLASH (rx) : ORIGIN = 0x0, LENGTH = 256K       /* 256k */
  RAM (rwx)  : ORIGIN = 0x20000000, LENGTH = 16K /* 16k */
}
