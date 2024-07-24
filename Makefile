CC = gcc -std=c17

# Put your own lua src directory and lib path here
LUASRCDIR = ../lua-5.4.7/src
# Lib is usually called lua for Linux or lua54 for Windows
LIBLUA = lua54


# List of plats: linux windows.
plat = undefined

# If you have Ultimate Packer for eXecutables (UPX), uncomment the following line
# UPX = upx --best --lzma "${OUTDIR}/lib${EXT}"
# Works better on Windows

FILES = getPi supportsVTProcessing waitFunction getUserInput
CNAMES = $(FILES:%=%.c)
ONAMES = $(FILES:%=%.o)

CFLAGS = -std=c17 -fPIC -Wall -Wextra -O2 -I${LUASRCDIR} -c
OFLAGS = -shared -L${LUASRCDIR} -l${LIBLUA} -s

define n


endef

.PHONY: all redo undefined linux windows clean
all: ${plat} ${CNAMES}
	$(foreach name,${CNAMES},${CC} ${CFLAGS} ${name} -o $(name:%.c=%.o)$n)
	${CC} ${OFLAGS} ${ONAMES} -o lib${EXT}
ifdef UPX
	${UPX}
endif

redo: clean all

undefined:
	$(error Please, change the variable 'plat' to 'windows' or 'linux')

linux:
	$(eval EXT = .so)
	$(eval RM = rm -f "${OBJDIR}/*.o" "${OUTDIR}/*${EXT}")
	
windows:
	$(eval EXT := .dll)
	$(eval RM := del /q)
	$(eval CC += -D__USE_MINGW_ANSI_STDIO)


clean: ${plat}
	${RM} "./*.o" "./lib${EXT}"
