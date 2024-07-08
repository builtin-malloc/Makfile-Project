LINKING ?= dynamic

ifeq ($(OS), Windows_NT)
PLATFORM := windows
else
PLATFORM := unix
endif


LIB.static.windows  := foo.lib
LIB.static.unix     := libfoo.a
LIB.dynamic.windows := foo.dll
LIB.dynamic.unix    := libfoo.so

BIN    := bar
BINSRC := bin.c
BINOBJ := bin.o
LIB    := $(LIB.$(LINKING).$(PLATFORM))
LIBSRC := lib.c
LIBOBJ := lib.o


LD := clang
CC := clang
AR := ar


CFLAGS.bin.dynamic.windows      := -DDYNAMIC_LIB
CFLAGS.lib.dynamic.windows	:= -DDYNAMIC_LIB -DBUILD_DLL
CFLAGS.lib.dynamic.unix		:= -fPIC
LDFLAGS.lib.dynamic.unix	:= -shared
LDFLAGS.lib.dynamic.windows	:= -shared
LDFLAGS.bin			:= -lfoo -L.

$(BIN): LDFLAGS := $(LDFLAGS.bin)
$(LIB): LDFLAGS := $(LDFLAGS.lib.$(LINKING).$(PLATFORM))

$(BIN): CFLAGS  := -c $(CFLAGS.bin.$(LINKING).$(PLATFORM))
$(LIB): CFLAGS  := -c $(CFLAGS.lib.$(LINKING).$(PLATFORM))

ARFLAGS := rcs


RM_RF := rm -rf


.PHONY: all clean

all: $(BIN) $(LIB)

clean:
	$(RM_RF) $(LIB) $(LIBOBJ)
	$(RM_RF) $(BIN) $(BINOBJ)

$(LIB): $(LIBOBJ)
ifeq ($(LINKING), static)
	$(AR) $(ARFLAGS) $@ $^
endif
ifeq ($(LINKING), dynamic)
	$(LD) $^ $(LDFLAGS) -o $@
endif


$(BIN): $(BINOBJ) | $(LIB)
	$(LD) $^ $(LDFLAGS) -o $@

lib.o: lib.c
	$(CC) $(CFLAGS) -o $@ $<

bin.o: bin.c
	$(CC) $(CFLAGS) -o $@ $<

