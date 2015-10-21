/* Linker script to configure memory regions. */

/* nRF51822 QFAA with 256kB flash and 16kB RAM. */
MEMORY
{
  FLASH (rx) : ORIGIN = 0x0 + 128K, LENGTH = 256K - 128K     /* 128 kB is taken by S310, 128 kB for app.  */
  RAM (rwx)  : ORIGIN = 0x20000000 + 10K, LENGTH = 16K - 10K /* 10 kB is taken by S310, 6 kB for app. */
}
