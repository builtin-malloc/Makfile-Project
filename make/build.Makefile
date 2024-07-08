$(BINS): $(OBJDIR)/%$(BINEXT): $(OBJDIR)/%.o | $(OBJDIR) $(LIB)
	$(LD) -o $@ $^ $(LDFLAGS)

$(TESTS): $(OBJDIR)/%$(BINEXT): $(OBJDIR)/%.o | $(OBJDIR) $(LIB)
	$(LD) -o $@ $^ $(LDFLAGS)

$(OBJDIR)/%$(LIBEXT.dynamic.$(PLATFORM)): $(LIBOBJ) | $(OBJDIR)
	$(LD) -o $@ $^ $(LDFLAGS)

$(OBJDIR)/%$(LIBEXT.static.$(PLATFORM)): $(LIBOBJ) | $(OBJDIR)
	$(AR) $(ARFLAGS) $@ $^


$(BINOBJ): $(OBJDIR)/%.o: $(BINDIR)/%.c | $(OBJDIR)
	$(CC) -o $@ $< $(CFLAGS)

$(LIBOBJ): $(OBJDIR)/%.o: $(LIBDIR)/%.c | $(OBJDIR)
	$(CC) -o $@ $< $(CFLAGS)

$(TESTOBJ): $(OBJDIR)/%.o: $(TESTDIR)/%.c | $(OBJDIR)
	$(CC) -o $@ $< $(CFLAGS)


$(OBJDIR):
	$(MKDIR_P) $@
