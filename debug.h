#ifndef DEBUG_H
#define DEBUG_H

#include <stdio.h>
#include <stdbool.h>

#define DBG_PAT "%s: %s: %d: %s(): "
#define DBG_MAC __TIME__, __FILE__, __LINE__, __func__

#define dbg_fmt(msg) _Generic((msg),    \
        int: "%d",                      \
        float: "%f",                    \
        double: "%f",                   \
        long: "%ld",                    \
        unsigned long: "%lu",           \
        char: "%c",                     \
        char *: "%s",                   \
        void *: "%p",                   \
        const char *: "%s",             \
        bool: "%d",                     \
        unsigned short: "%hu",          \
        unsigned int: "%u")

#if DBG_ON
#define dbg(msg) do {                           \
        fprintf(stderr, DBG_PAT, DBG_MAC);      \
        fprintf(stderr, dbg_fmt(msg), msg);     \
        puts("");                               \
        } while (0)
#else
#define dbg(msg) ((void)0)
#endif

#endif
