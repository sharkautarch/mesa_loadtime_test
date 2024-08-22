Dependencies: [bash](https://archlinux.org/packages/core/x86_64/bash/), [clang](https://archlinux.org/packages/extra/x86_64/clang/), [lld](https://archlinux.org/packages/extra/x86_64/lld/), and [vkcube](https://archlinux.org/packages/extra/x86_64/vulkan-tools/)

Usage: `./time_lib_load.sh |& tee mesa_load_timing.log`

Runs `LD_DEBUG=all vkcube &` in the background, while repeatedly printing out the elapsed time, in microseconds. 

Note: This script leverages the ability to create custom bash builtins in order to use cpu pause/yield. This is used in the timing loop as a low-overhead way to slightly reduce cpu usage.
