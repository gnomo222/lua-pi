CC = gcc

# Put your own lua src directory here
LUASRCDIR = ../../lua-5.4.6/src

MKDIR = mkdir

define RM
rm -f ${OBJDIR}*.o ${OUTDIR}*.dll
# If you're on Windows, instead use
# del /q ${OBJDIR}\*.o
# del /q ${OUTDIR}\*.dll
endef

OUTDIR = bin
OBJDIR = obj

CFLAGS = -std=c17 -Wall -Wextra -Os -I${LUASRCDIR} -c
OFLAGS = -shared -s

OBJwaitFunction = ${OBJDIR}/waitFunction.o
OBJgetPi = ${OBJDIR}/getPi.o
OBJsupportsVTProcessing = ${OBJDIR}/supportsVTProcessing.o

all: ${OUTDIR} ${OBJDIR} ${OUTDIR}/waitFunction.dll ${OUTDIR}/getPi.dll ${OUTDIR}/supportsVTProcessing.dll

${OUTDIR}/waitFunction.dll: ${OBJwaitFunction} ${OUTDIR}
	${CC} ${OFLAGS} $< -o $@

${OUTDIR}/getPi.dll: ${OBJgetPi} ${OUTDIR}
	${CC} ${OFLAGS} $< -o $@ 

${OUTDIR}/supportsVTProcessing.dll: ${OBJsupportsVTProcessing} ${OUTDIR}
	${CC} ${OFLAGS} $< -o $@ 

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
