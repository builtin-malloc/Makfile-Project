ifeq ($(OS), Windows_NT)
PLATFORM := windows
else
PLATFORM := unix
endif

PREFIX.windows = "C://Program Files//$(PROJECT)//$(COMPONENT)"
PREFIX.unix    = "/usr/local"

LIBNAME.windows		= $(FULLNAME)
LIBNAME.unix		= lib$(FULLNAME)
LIBEXT.static.windows	= .lib
LIBEXT.dynamic.windows	= .dll
LIBEXT.static.unix	= .a
LIBEXT.dynamic.unix	= .so
BINEXT.windows          = .exe
BINEXT.unix             =

