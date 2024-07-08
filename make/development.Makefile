$(VENVDIR)/bin/%: $(VENVDIR)
	. $(VENVDIR)/bin/activate && pip install $*

format: $(FORMATTER)
	@for file in $(BINSRC) $(LIBSRC) $(LIBHDR) $(TESTSRC); do \
		echo "$^ -i $${file}" ; \
		$^ -i $${file} ; \
	done

lint: $(FORMATTER)
	@for file in $(BINSRC) $(LIBSRC) $(LIBHDR) $(TESTSRC); do \
		echo "$^ --dry-run -Werror $${file}" ; \
		$^ --dry-run -Werror $${file} ; \
	done


$(VENVDIR):
	python3 -m venv $@


