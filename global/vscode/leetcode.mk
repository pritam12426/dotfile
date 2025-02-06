OPT  ?= -pedantic -Wall -std=c++20
OPT  += -include"bits/stdc++.hpp"
PDIR ?= ~/Developer/leedcode/cxx
TIME  = /usr/bin/time -h

BIN          = ${PDIR}/main-cpp.out
PROGRAM_FILE = ${PDIR}/main.cpp

all: build r

debug: d
clean: c

build: ${PROGRAM_FILE}
	$(TIME) $(CXX) $(OPT) $(PROGRAM_FILE) -o $(BIN)
	strip $(BIN)

d: ${PROGRAM_FILE}
	$(CXX) $(OPT) -g3 $(PROGRAM_FILE) -o $(BIN)
	lldb -o "command alias rr process launch --stdin $(PDIR)/input.txt" $(BIN)

r:
	$(TIME) $(BIN) < ${PDIR}/input.txt

run:
	$(TIME) $(BIN) < ${PDIR}/input.txt > ${PDIR}/output.txt

c:
	$(RM) -r *.out *.out.dSYM
