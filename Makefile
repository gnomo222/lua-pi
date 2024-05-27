CC = gcc

# Put your own lua src directory and lib path here
LUASRCDIR = C:/Users/Redseek/Desktop/c/lua/lua
LIBLUA = lua54

MKDIR = mkdir

# If you're on \\Linux\\, use 
# RM = rm -f "${OBJDIR}/*.o" "${OUTDIR}/*.dll"

# If you're on \\Windows\\ instead, use the following defintion
define RM
del /q "${OBJDIR}\*.o"
del /q "${OUTDIR}\*.dll"
endef

# If you have Ultimate Packer for eXecutables (UPX), uncomment the following line
UPX = upx --best --lzma "${OUTDIR}/lib.dll"

OUTDIR = .
OBJDIR = obj

CFLAGS = -std=c17 -Wall -Wextra -O2 -I${LUASRCDIR} -c
OFLAGS = -shared -L${LUASRCDIR} -l${LIBLUA} -s 

all: ${OUTDIR} ${OUTDIR}/lib.dll compress
redo: clean all

${OUTDIR}/lib.dll: ${OBJDIR}/getPi.o ${OBJDIR}/supportsVTProcessing.o ${OBJDIR}/waitFunction.o
	${CC} ${OFLAGS} $^ -o $@

${OBJDIR}/getPi.o: getPi.c ${OBJDIR}
	${CC} ${CFLAGS} $< -o $@
${OBJDIR}/supportsVTProcessing.o: supportsVTProcessing.c ${OBJDIR}
	${CC} ${CFLAGS} $< -o $@
${OBJDIR}/waitFunction.o: waitFunction.c ${OBJDIR}
	${CC} ${CFLAGS} $< -o $@

${OBJDIR}:
	${MKDIR} ${OBJDIR}

${OUTDIR}:
	${MKDIR} ${OUTDIR}

compress:
	${UPX}

.PHONY: clean
clean:
	${RM}
