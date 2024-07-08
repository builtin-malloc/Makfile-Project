BIN    := bar
BINSRC := bin.c
BINOBJ := bin.o
LIB    := libfoo.a
LIBSRC := lib.c
LIBOBJ := lib.o


LD := clang
CC := clang
AR := ar

LDFLAGS := -lfoo -L. -o
CFLAGS  := -c -o
ARFLAGS := rcs


RM_RF := rm -rf


.PHONY: all clean

all: $(BIN) $(LIB)

clean:
	$(RM_RF) $(LIB) $(LIBOBJ)
	$(RM_RF) $(BIN) $(BINOBJ)

$(LIB): $(LIBOBJ)
	$(AR) $(ARFLAGS) $@ $^

$(BIN): $(BINOBJ) | $(LIB)
	$(LD) $^ $(LDFLAGS) $@

lib.o: lib.c
	$(CC) $(CFLAGS) $@ $<

bin.o: bin.c
	$(CC) $(CFLAGS) $@ $<

