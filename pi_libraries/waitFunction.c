#include <stdlib.h>
#include "lauxlib.h"
#include "lapi.h"

#ifdef _WIN32
    #include <windows.h>
#else
    #include <time.h>
#endif

static int wait(lua_State *L)
{
    int ms = luaL_checknumber(L, 1);
    #ifdef _WIN32
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
    lua_pushcfunction(L, wait);
    return 1;
}
