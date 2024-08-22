Dependencies: [bash](https://archlinux.org/packages/core/x86_64/bash/), [clang](https://archlinux.org/packages/extra/x86_64/clang/), and [lld](https://archlinux.org/packages/extra/x86_64/lld/)

Usage: `./time_lib_load.sh |& tee mesa_load_timing.log`

Note: This script leverages the ability to create custom bash builtins in order to use cpu pause/yield. This is used in the timing loop as a low-overhead way to slightly reduce cpu usage.
