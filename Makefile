CC=gcc
SYS := $(shell uname -s)
CFLAGS := -c -Wall -g -ansi -pedantic -std=gnu11 -Werror -I/usr/local/include
LDFLAGS := -L/usr/local/lib
LIBS := -lpcre

P=60
R=100
C=70

EXE=glife
SRC=config.c game.c main.c mem.c
OBJ=$(patsubst %.c,%.o,$(SRC))

$(EXE): $(OBJ)
	$(CC) -o $@ $^ $(LDFLAGS) $(LIBS)

# pull in dependency info for *existing* .o files
-include $(OBJS:.o=.d)

# This is the default rule, so it is commented
%.o: %.c
	gcc -MM $(CFLAGS) $*.c > $*.d
	$(CC) $(CFLAGS) $<

.PHONY: board
board:
	python3 board.py $(P) $(R) $(C)

.PHONY: clean
clean:
	rm -f $(EXE) $(OBJ) *.d
