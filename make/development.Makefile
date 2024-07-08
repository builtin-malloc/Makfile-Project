.PHONY: lint-format lint-code
.PHONY: $(COMPILE_COMMANDS)

LINTFLAGS := -I$(LIBDIR)

ifeq ($(PLATFORM), unix)
ifeq ($(shell uname -s), Darwin)

LINTFLAGS += -I$(shell xcrun --show-sdk-path)/usr/include

endif
endif


$(VENVDIR)/bin/%: $(VENVDIR)
	. $(VENVDIR)/bin/activate && pip install $*


format: $(FORMATTER)
	@for file in $(BINSRC) $(LIBSRC) $(LIBHDR) $(TESTSRC); do \
		echo "$^ -i $${file}" ; \
		$^ -i $${file} ; \
	done

lint-format: $(FORMATTER) | $(COMPILE_COMMANDS)
	@for file in $(BINSRC) $(LIBSRC) $(LIBHDR) $(TESTSRC); do \
		echo "$^ --dry-run -Werror $${file}" ; \
		$^ --dry-run -Werror $${file} ; \
	done

lint-code: $(LINTER) | $(COMPILE_COMMANDS)
	@for file in $(BINSRC) $(LIBSRC) $(LIBHDR) $(TESTSRC); do \
		echo "$^ $${file}" ; \
		$^ $${file} -- $(LINTFLAGS); \
	done


$(COMPILE_COMMANDS): $(COMPILEDB)
	$^ -n make


lint: lint-format lint-code
compiledb: $(COMPILE_COMMANDS)


$(VENVDIR):
	python3 -m venv $@


