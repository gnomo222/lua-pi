CC = gcc

# Put your own lua src directory and lib path here
LUASRCDIR = C:/Users/Redseek/Desktop/c/lua/lua
LIBLUA = ${LUASRCDIR}/liblua.a

MKDIR = mkdir

# RM = rm -f "${OBJDIR}/*.o" "${OUTDIR}/*.dll"
# If you're on Windows, instead use 
# RM = del /q "${OBJDIR}\*.o" "${OUTDIR}\*.dll"

OUTDIR = bin
OBJDIR = obj

CFLAGS = -std=c17 -Wall -Wextra -Os -I${LUASRCDIR} -c
OFLAGS = -shared -s 

OBJwaitFunction = ${OBJDIR}/waitFunction.o
OBJgetPi = ${OBJDIR}/getPi.o
OBJsupportsVTProcessing = ${OBJDIR}/supportsVTProcessing.o

all: ${OUTDIR} ${OBJDIR} ${OUTDIR}/waitFunction.dll ${OUTDIR}/getPi.dll ${OUTDIR}/supportsVTProcessing.dll

${OUTDIR}/waitFunction.dll: ${OBJwaitFunction} ${OUTDIR}
	${CC} ${OFLAGS} $< -o $@ ${LIBLUA}

${OUTDIR}/getPi.dll: ${OBJgetPi} ${OUTDIR}
	${CC} ${OFLAGS} $< -o $@ ${LIBLUA}

${OUTDIR}/supportsVTProcessing.dll: ${OBJsupportsVTProcessing} ${OUTDIR}
	${CC} ${OFLAGS} $< -o $@ ${LIBLUA}

${OBJwaitFunction}: waitFunction.c ${OBJDIR}
	${CC} ${CFLAGS} $< -o $@

${OBJgetPi}: getPi.c ${OBJDIR}
	${CC} ${CFLAGS} $< -o $@

${OBJsupportsVTProcessing}: supportsVTProcessing.c ${OBJDIR}
	${CC} ${CFLAGS} $< -o $@

${OBJDIR}:
	${MKDIR} ${OBJDIR}

${OUTDIR}:
	${MKDIR} ${OUTDIR}

.PHONY: clean
clean:
	${RM}
