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

CFLAGS = -std=c17 -Wall -Wextra -O2 -I${LUASRCDIR} -c
OFLAGS = -shared -s 

all: ${OUTDIR} ${OBJDIR} ${OUTDIR}/libraries.dll

${OUTDIR}/libraries.dll: ${OBJDIR}/libraries.o ${OUTDIR}
	${CC} ${OFLAGS} $< -o $@ ${LIBLUA}

${OBJDIR}/libraries.o: libraries.c ${OBJDIR}
	${CC} ${CFLAGS} $< -o $@

${OBJDIR}:
	${MKDIR} ${OBJDIR}

${OUTDIR}:
	${MKDIR} ${OUTDIR}

.PHONY: clean
clean:
	${RM}
