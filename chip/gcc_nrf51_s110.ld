/* Linker script to configure memory regions. */
MEMORY
{
  FLASH (rx) : ORIGIN = 0x16000, LENGTH = 0x2A000 /* 88 kB is taken by S110, 168 kB for app. */
  RAM (rwx) : ORIGIN = 0x20002000, LENGTH = 0x2000 /* 8 kB is taken by S110, 8 kB for app. */
}
