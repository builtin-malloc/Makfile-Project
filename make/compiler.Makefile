CC.gcc		= gcc
LD.gcc		= gcc
CC.clang	= clang
LD.clang	= clang


CC := $(CC.$(COMPILER))
LD := $(LD.$(COMPILER))
AR := ar


CFLAGS.base	= -c -MMD -std=c17 -I$(LIBDIR)
CFLAGS.warn	= -Wall
CFLAGS.strict	= -Wextra -Wpedantic -Werror
CFLAGS.debug    = -O0 -g
CFLAGS.release  = -O3 -DNDEBUG
CFLAGS.common   = $(CFLAGS.base) $(CFLAGS.warn) $(CFLAGS.$(STRICT)) $(CFLAGS.$(BUILD))

CFLAGS.bin.dynamic.windows = -D$(C_NAMESPACE)DLL
CFLAGS.lib.dynamic.windows = -D$(C_NAMESPACE)DLL -D$(C_NAMESPACE)BUILD_DLL
CFLAGS.lib.dynamic.unix    = -fPIC


LDFLAGS.common = -L$(OBJDIR)

LDFLAGS.bin.dynamic.windows	= -l$(FULLNAME)
LDFLAGS.bin.static.windows	= -l$(FULLNAME)
LDFLAGS.bin.dynamic.unix	= -l$(FULLNAME)
LDFLAGS.bin.static.unix		= -l$(FULLNAME)
LDFLAGS.lib.dynamic.windows	= -shared
LDFLAGS.lib.dynamic.unix	= -shared


$(BINOBJ): CFLAGS := $(CFLAGS.common) $(CFLAGS.bin.$(LINKING).$(PLATFORM))
$(LIBOBJ): CFLAGS := $(CFLAGS.common) $(CFLAGS.lib.$(LINKING).$(PLATFORM))
$(TESTOBJ): CFLAGS := $(CFLAGS.common) $(CFLAGS.bin.$(LINKING).$(PLATFORM))

$(BINS): LDFLAGS := $(LDFLAGS.common) $(LDFLAGS.bin.$(LINKING).$(PLATFORM))
$(LIB): LDFLAGS := $(LDFLAGS.common) $(LDFLAGS.lib.$(LINKING).$(PLATFORM))
$(TESTS): LDFLAGS := $(LDFLAGS.common) $(LDFLAGS.bin.$(LINKING).$(PLATFORM))


ARFLAGS = rcs
