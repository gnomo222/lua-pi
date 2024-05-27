#ifndef WAITFUNCTION_H
#define WAITFUNCTION_H
#include <stdlib.h>

#if _WIN32
    #include <windows.h>
#elif __linux__
    #include <time.h>
    int nanosleep(const struct timespec *req, struct timespec *rem);
#else
    #error "Unsupported OS"
#endif
#include "exports.h"

int waitFunction(lua_State *L)
{
    int ms = luaL_checknumber(L, 1);
    #if _WIN32
        Sleep(ms);
    #else
        struct timespec ts;
        ts.tv_sec = ms / 1000;
        ts.tv_nsec = (ms % 1000) * 1000000;
        nanosleep(&ts, NULL);
    #endif
    return 0;
}

int luaopen_waitFunction(lua_State *L)
{
	lua_pushcfunction(L, waitFunction);
	return 1;
}
#endif