/* Linker script to configure memory regions. */

/* nRF51822 QFAA with 256kB flash and 16kB RAM. */
MEMORY
{
  /* Use SD110 v7. Takes 88kB flash and 8kB ram by default. */
  FLASH (rx) : ORIGIN = 0x0 + 88K, LENGTH = 256K - 88K     /* 88 kB is taken by S110, 168 kB for app. */
  RAM (rwx)  : ORIGIN = 0x20000000 + 8K, LENGTH = 16K - 8K /* 8 kB is taken by S110, 8 kB for app. */
}
