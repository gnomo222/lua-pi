CC = gcc
# I'll be so kind as to include the damnable lua library
# alongside the source code
LUALIB = ./lua54.lib
# Put your own lua src directory here
LUASRCDIR = ../../lua-5.4.6/src

OUTDIR = bin
OBJDIR = obj

CFLAGS = -fomit-frame-pointer -fexpensive-optimizations -std=c17 -Os -I${LUASRCDIR} -c
OFLAGS = -shared -s

OBJwaitFunction = ${OBJDIR}/waitFunction.o
OBJgetPi = ${OBJDIR}/getPi.o
OBJsupportsVTProcessing = ${OBJDIR}/supportsVTProcessing.o

all: ${OUTDIR} ${OBJDIR} ${OUTDIR}/waitFunction.dll ${OUTDIR}/getPi.dll ${OUTDIR}/supportsVTProcessing.dll

${OUTDIR}/waitFunction.dll: ${OBJwaitFunction} ${OUTDIR}
	${CC} ${OFLAGS} $< -o $@ ${LUALIB}

${OUTDIR}/getPi.dll: ${OBJgetPi} ${OUTDIR}
	${CC} ${OFLAGS} $< -o $@ ${LUALIB}

${OUTDIR}/supportsVTProcessing.dll: ${OBJsupportsVTProcessing} ${OUTDIR}
	${CC} ${OFLAGS} $< -o $@ ${LUALIB}

${OBJwaitFunction}: waitFunction.c ${OBJDIR}
	${CC} ${CFLAGS} $< -o $@

${OBJgetPi}: getPi.c ${OBJDIR}
	${CC} ${CFLAGS} $< -o $@

${OBJsupportsVTProcessing}: supportsVTProcessing.c ${OBJDIR}
	${CC} ${CFLAGS} $< -o $@

${OBJDIR}:
	mkdir ${OBJDIR}

${OUTDIR}:
	mkdir ${OUTDIR}

.PHONY: clean
clean:
	rm -f ${OBJDIR}*.o ${OUTDIR}*.dll
