/* Linker script to configure memory regions. */

/* nRF51822 QFAA with 256kB flash and 16kB RAM. */
MEMORY
{
  FLASH (rx) : ORIGIN = 0x0 + 96K, LENGTH = 256K - 96K       /* 96 kB is taken by S120, 160 kB for app. */
  RAM (rwx)  : ORIGIN = 0x20000000 + 10K, LENGTH = 16K - 10K /* 10 kB is taken by S120, 6 kB for app. */
}
