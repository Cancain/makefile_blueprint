ifeq ($(OS), Windows_NT)
	EXE_EXT = .exe
else
	EXE_EXT =
endif

OBJ_NAME = main
SRC_DIR = src

SRC = $(wildcard $(SRC_DIR)/*.cpp)

SRC_EXT = .cpp

OBJS = $(patsubst $(SRC_DIR)/%.cpp,$(BIN)/%.o,$(SRC))

BIN = bin

CC = g++

LINKER_FILES = -lSDL2

COMPILER_FLAGS = -w

prepare-src:
	mkdir -p $(SRC_DIR)

prepare-bin:
	mkdir -p $(BIN)

prepare-git: 
	$(if $(wildcard .gitignore),, @echo -e \
		"$(BIN)/*" > ".gitignore")

setup: prepare-bin prepare-src prepare-git

$(BIN)/%.o: $(SRC_DIR)/%.cpp
	$(CC) $(COMPILER_FLAGS) -c $< -o $@

all: $(OBJS) prepare-bin
	$(CC) $(OBJS) $(COMPILER_FLAGS) $(LINKER_FILES) -o $(BIN)/$(OBJ_NAME)$(EXE_EXT)

run: $(BIN)/$(OBJ_NAME)$(EXE_EXT)
	./$(BIN)/$(OBJ_NAME)$(EXE_EXT)

ra: all run
