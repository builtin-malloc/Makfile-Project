.PHONY: clean mrproper

clean:
	$(RM_RF) $(BINS)
	$(RM_RF) $(LIB)
	$(RM_RF) $(TESTS)
	$(RM_RF) $(BINDEP)
	$(RM_RF) $(LIBDEP)
	$(RM_RF) $(TESTDEP)
	$(RM_RF) $(BINOBJ)
	$(RM_RF) $(LIBOBJ)
	$(RM_RF) $(TESTOBJ)

mrproper:
	$(RM_RF) $(OBJDIR)
	$(RM_RF) $(VENVDIR)
	$(RM_RF) $(COMPILE_COMMANDS)
