#ifndef FORMATDATE_H
#define FORMATDATE_H

#ifdef _WIN32
#define EXPORT __declspec(dllexport)
#else
#define EXPORT
#endif

#include "lua.h"

EXPORT int getPi(lua_State *L);
EXPORT int supportsVTProcessing(lua_State *L);
EXPORT int waitFunction(lua_State *L);

#endif //FORMATDATE_H