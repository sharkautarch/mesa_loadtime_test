#!/bin/bash

# Copyright 2024 - sharkautarch https://github.com/sharkautarch
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# SPDX-License-Identifier: MPL-2.0

# from https://stackoverflow.com/a/246128  :
SOURCE=${BASH_SOURCE[0]}
while [ -L "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
  SOURCE=$(readlink "$SOURCE")
  [[ $SOURCE != /* ]] && SOURCE=$DIR/$SOURCE # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR=$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )
#### end of stackoverflow-based snippet ####
############################################

cd "$DIR"
unset DIR

if [[ -n "yield" ]]; then
	clang -I /usr/include/bash/include/ -s -Ofast -DSHELL -shared -fno-plt -fuse-ld=lld -Wl,-Bsymbolic,--gc-sections,--relax,--discard-all,--ignore-data-address-equality,--ignore-function-address-equality,--icf=all -flto -Wl,-soname,yield yield.c -o yield
fi
enable -f ./yield yield

t=$(echo $EPOCHREALTIME)

time_start=$(echo $EPOCHREALTIME)
declare -i time_start_seconds time_start_ms multiplied us t2_seconds
time_start_seconds=${t::10}
time_start_microseconds=${time_start:11:6}
unset time_start
unset t

mkdir -vp /tmp/time_lib_load/
if [ -e /tmp/time_lib_load/done ]; then
	rm /tmp/time_lib_load/done
fi

env LD_DEBUG=all vkcube && touch /tmp/time_lib_load/done &

while [[ ! -e /tmp/time_lib_load/done ]]
do
	t2_microseconds=${EPOCHREALTIME:11:6}
	t2_seconds=${EPOCHREALTIME::10}
  multiplied=$(($(($t2_seconds-$time_start_seconds))*1000000))
  us=$((10#$t2_microseconds-time_start_microseconds))
	echo -e "\nelapsed time since start: $(( us + multiplied )) us\n"
	yield
done
