LIBDIR := lib
.DEFAULT_GOAL := all
TEXT_PAGINATION := true

.PHONY: clean-versioned really-clean fresh-next fresh-idnits

# Before running template idnits, remove stale generated submission artifacts.
idnits:: clean-versioned

clean-versioned:
	rm -rf versioned

-include $(LIBDIR)/main.mk

$(LIBDIR)/main.mk:
ifneq (,$(shell grep "path *= *$(LIBDIR)" .gitmodules 2>/dev/null))
	git submodule sync
	git submodule update --init
else
ifneq (,$(wildcard $(ID_TEMPLATE_HOME)))
	ln -s "$(ID_TEMPLATE_HOME)" $(LIBDIR)
else
	git clone -q --depth 10 -b main \
	    https://github.com/martinthomson/i-d-template $(LIBDIR)
endif
endif

really-clean: clean clean-versioned
	rm -f draft-*.txt draft-*.html draft-*.pdf draft-*.redxml

fresh-next:
	rm -rf versioned
	$(MAKE) next

fresh-idnits:
	rm -rf versioned
	$(MAKE) idnits

