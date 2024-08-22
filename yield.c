// Copyright 2024 - sharkautarch https://github.com/sharkautarch
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.

// SPDX-License-Identifier: MPL-2.0

#include <sched.h>
#if defined (HAVE_UNISTD_H)
#  include <unistd.h>
#endif

#include <bash/builtins.h>

char *yield_doc[] = { "" };

int yield_builtin() {
#ifdef __x86_64__
    __builtin_ia32_pause();
#else
    sched_yield();
#endif
    return 0;
}

struct builtin yield_struct = {
	"yield",		/* builtin name */
	yield_builtin,	/* function implementing the builtin */
	BUILTIN_ENABLED,	/* initial flags for builtin */
	yield_doc,		/* array of long documentation strings. */
	"yield",	/* usage synopsis */
	0			/* reserved for internal use */
};

