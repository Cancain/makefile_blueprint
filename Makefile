ifeq ($(OS), Windows_NT)
	EXE_EXT = .exe
else
	EXE_EXT =
endif

OBJ_NAME = main

SRC = src

SRC_EXT = .cpp

OBJS = $(SRC)/$(OBJ_NAME)$(SRC_EXT)

BIN = bin

CC = g++

LINKER_FILES = -lSDL2

COMPILER_FLAGS = -w

prepare-src:
	@mkdir -p $(SRC)

prepare-bin:
	@mkdir -p $(BIN)

prepare-main: prepare-src
	$(if $(wildcard $(OBJS)),, \
	echo -e \
	'#include <iostream>\n\nint main() {\n\tstd::cout << "Hello World!" << std::endl;\n\treturn 0;\n}'\
	> $(OBJS))

prepare-git: 
	$(if $(wildcard .gitignore),, @echo -e \
		"$(BIN)/*" > ".gitignore")

setup: prepare-main prepare-bin prepare-git

all: prepare-main prepare-bin $(OBJS)
			$(CC) $(OBJS) $(COMPILER_FLAGS) $(LINKER_FILES) -o $(BIN)/$(OBJ_NAME)$(EXE_EXT)

run: $(OBJS) 
		./$(BIN)/$(OBJ_NAME)

ra: $(OBJS)
			make all
			make run
