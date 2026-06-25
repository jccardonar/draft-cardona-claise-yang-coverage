LIBDIR := lib
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

.PHONY: clean-versioned really-clean fresh-idnits

clean-versioned:
	rm -rf versioned

really-clean: clean clean-versioned
	rm -f draft-*.txt draft-*.html draft-*.pdf draft-*.redxml

fresh-idnits: clean-versioned
	$(MAKE) next
	$(MAKE) idnits
