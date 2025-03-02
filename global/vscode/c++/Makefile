OPT := -std=c++20 -arch arm64
# OPT += -Wl,-rpath,/usr/local/lib

# LIBS  = argparse
# LIBS += sqlitecpp
# LIBS += cpr

OPT += ${shell pkg-config --libs --cflags $(LIBS)}

PROJDIRS := $(HOME)/Developer/you-project
OBJDIR   := $(PROJDIRS)/obj
TIME     := /usr/bin/time -h

# Change these 4 lins according to a project
CC           := /usr/bin/clang++
SRCFILES     := $(wildcard ${PROJDIRS}/src/*.cpp)
OBJFILES     := $(patsubst ${PROJDIRS}/src/%.cpp, ${OBJDIR}/%.o, $(SRCFILES))
DEPFILES     := $(patsubst ${PROJDIRS}/src/%.cpp, ${OBJDIR}/%.d, $(SRCFILES))

PROJNAME     := MyProject
BIN          := ${PROJDIRS}/main.out
LINE         := @printf '%*s\n' $(shell tput cols) ' ' | tr ' ' '-' >&2
OUTPUT_FILE  := ${PROJDIRS}/output.txt
INPUT_FILE   := ${PROJDIRS}/input.txt

WARNINGS := -Wall -Wextra -pedantic -Wshadow -Wpointer-arith -Wcast-align \
			-Wwrite-strings -Wmissing-prototypes -Wmissing-declarations \
			-Wredundant-decls -Wnested-externs -Winline \
			-Wuninitialized -Wconversion -Wstrict-prototypes

OPT += ${WARNINGS}

ifdef DEBUG
	OPT += -g3 -O0
else
	OPT += -O3
endif

.PHONY: all debug d clean c build run r dd see

all: build r

debug: d
clean: c
build: ${BIN}

# Linking step: Link only if any object file has changed
${BIN}: ${OBJFILES}
	@printf "\e[1;32m 󰆼  %s \e[0m \e[41m%s\e[0m\n\n" "Building the project..." "$(OBJFILES)"
	$(TIME) $(CC) $(OPT) $^ -o $(BIN)
	@strip $(BIN)
	${LINE}

# Debug build
d: dd
	lldb -o "command alias rr process launch --stdin $(INPUT_FILE) --stdout $(OUTPUT_FILE)" -o "b main" -o "rr" $(BIN)

dd: ${OBJFILES}
	@$(RM)
	@printf "\e[1;33m   %s \e[0m \e[44m%s\e[0m\n\n" "Debugging" "$<"
	$(CC) $(OPT) $^ -o $(BIN)
	${LINE}

# Run the program
r:
	$(TIME) $(BIN) < $(INPUT_FILE)

run:
	$(TIME) $(BIN) < $(INPUT_FILE) > $(OUTPUT_FILE)

# Clean only relevant files
c:
	$(RM) -r ${PROJDIRS}/*.out ${PROJDIRS}/*.dSYM ${OBJDIR}

see: ${BIN}
	@otool -L ${BIN}

${OBJDIR}:
	@mkdir -p ${OBJDIR}

${OBJDIR}/%.o: ${PROJDIRS}/src/%.cpp | ${OBJDIR}
	@printf "\e[1;34m 󰅒  %s \e[0m \e[45m%s\e[0m\n\n" "Compiling" "$<"
	$(CC) $(OPT) -MMD -MP -c $< -o $@
	${LINE}

-include ${DEPFILES}
