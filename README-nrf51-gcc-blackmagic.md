## nrf51-gcc-blackmagic ##

A simple GCC setup for nRF51 development, intended for use with the
[`blackmagic`](https://github.com/gsmcmullin/blackmagic) debug probe.

## Prerequisites ##

[GNU Make](http://www.gnu.org/software/make/) and the following standard
utilities are required: `cat`, `echo`, `find`, `grep`, `mkdir`, `rm`, `sed` and
`shuf`. If you're running any sensible desktop linux then these will already be
installed.

You will also need to aquire
[GNU Tools for ARM Embedded Processors](https://launchpad.net/gcc-arm-embedded/).

##### On Ubuntu

```
sudo add-apt-repository ppa:terry.guo/gcc-arm-embedded
sudo apt-get update && sudo apt-get install gcc-arm-none-eabi
```

## Usage ##

The [`sdk/`](sdk/) and [`softdevice/`](softdevice/) folders need to be
populated with the downloads from Nordic Semiconductor's website. More
details can be found in the README.md files in each folder.

User Information Configuation Register (UICR) settings for any
softdevice need to be set in `uicr/<softdevice>_softdevice_uicr.c`.

### Project Options ###

[`config.mk`](config.mk) allows configuation for individual
projects. In particular the `PROJECT_NAME` and `USE_SOFTDEVICE`
variables need to be set.

### Compiling ###

`make`

### Download ###

Run `arm-none-eabi-gdb`. If you have set `BLACKMAGIC_PATH` in
[`config.mk`](config.mk) then gdb will attempt to connect to the
blackmagic debugger.

## Emacs ##

A Directory Local Variables File [`.dir-locals.el`](.dir-locals.el)
exists in the root of the project, and this has the following effects
on emacs:

### Fixed default-directory ###

The default directory is fixed as the root of the project wherever you
are within the project. As the makefile needs to be run from the root
of the project, this means that `M+x compile` will always run the
top-level makefile no matter which file you are editing.

### Custom GDB ###

`M+x gdb` is set to use `arm-none-eabi-gdb` rather than the default GDB for your
machine.

## Other notes ##

Wherever possible use
[Function Attributes](http://gcc.gnu.org/onlinedocs/gcc/Function-Attributes.html)
and
[Variable Attrubutes](http://gcc.gnu.org/onlinedocs/gcc/Variable-Attributes.html)
rather than editing the project's linker files.

## Sources & Licensing ##

See [LICENSE.md](LICENSE-nrf51-gcc-blackmagic.md)
