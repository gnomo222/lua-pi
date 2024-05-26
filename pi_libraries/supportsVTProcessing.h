#ifndef SUPPORTSVTPROCESSING_H
#define SUPPORTSVTPROCESSING_H
#ifdef _WIN64
    #include <wchar.h>
    #include <windows.h>
#endif
#include "exports.h"

int supportsVTProcessing (lua_State *L)
{
    int ret = 0;
    #if __linux__ || __unix__
    ret = 1;
    #elif _WIN64
    ret = 1;
    HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
    DWORD mode = 0;
    GetConsoleMode(hConsole, &mode);
    SetConsoleMode(hConsole, mode | ENABLE_VIRTUAL_TERMINAL_PROCESSING | ENABLE_PROCESSED_OUTPUT);
    #endif
    lua_pushboolean(L, ret);
    return 1;
}
#endif