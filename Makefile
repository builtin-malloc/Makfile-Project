################################################################################
## SETUP #######################################################################
################################################################################

PROJECT		= footgun
COMPONENT	= example
VERSION		= $(shell git describe --tags --abbrev=0)
FULLNAME	= $(PROJECT)-$(COMPONENT)-$(VERSION)
C_NAMESPACE	= FG_

BUILD		?= debug
LINKING		?= dynamic
COMPILER	?= clang
STRICT		?= strict

include make/platform.Makefile

PREFIX		?= PREFIX.$(PLATFORM)

################################################################################
## FILES AND FOLDERS ###########################################################
################################################################################

BINDIR	:= bin
LIBDIR	:= lib
OBJDIR	:= obj
TESTDIR := test

BINSRC  = $(wildcard $(BINDIR)/*.c)
LIBSRC  = $(wildcard $(LIBDIR)/*.c)
LIBHDR  = $(wildcard $(LIBDIR)/*.h)
TESTSRC = $(wildcard $(TESTDIR)/*.c)

BINOBJ  = $(BINSRC:$(BINDIR)/%.c=$(OBJDIR)/%.o)
LIBOBJ  = $(LIBSRC:$(LIBDIR)/%.c=$(OBJDIR)/%.o)
TESTOBJ = $(TESTSRC:$(TESTDIR)/%.c=$(OBJDIR)/%.o)

BINDEP  = $(BINOBJ:%.o=%.d)
LIBDEP  = $(LIBOBJ:%.o=%.d)
TESTDEP = $(TESTOBJ:%.o=%.d)

LIBNAME = $(LIBNAME.$(PLATFORM))
LIBEXT  = $(LIBEXT.$(LINKING).$(PLATFORM))
LIB	= $(OBJDIR)/$(LIBNAME)$(LIBEXT)
BINEXT  = $(BINEXT.$(PLATFORM))
BINS    = $(BINSRC:$(BINDIR)/%.c=$(OBJDIR)/%$(BINEXT))
TESTS   = $(TESTSRC:$(TESTDIR)/%.c=$(OBJDIR)/%$(BINEXT))

################################################################################
## PROGRAMS ####################################################################
################################################################################

include make/compiler.Makefile

MKDIR_P ?= mkdir -p
RM_RF   ?= rm -rf

################################################################################
## TARGETS #####################################################################
################################################################################


.PHONY: all clean test

all: $(BINS) $(LIB)
test: $(TESTS)

include make/build.Makefile
include make/clean.Makefile

-include $(BINDEP)
-include $(LIBDEP)
-include $(TESTDEP)
