DRAFT_BASE = draft-cardona-claise-onion-yang-coverage

# Extract version from XML docName attribute
VERSION = $(shell grep 'docName=' $(DRAFT_BASE).xml | head -1 | sed 's/.*docName="[^"]*-\([0-9][0-9]\)".*/\1/')
DRAFT = $(DRAFT_BASE)-$(VERSION)

# Tools
XML2RFC = xml2rfc
RM = rm -f
OPEN = open

# Source files
XML_SRC = $(DRAFT_BASE).xml

# Output formats  
TXT_OUT = $(DRAFT).txt
XML_OUT = $(DRAFT).xml

# Default target - build all common formats
all: xml txt

# Build both XML and TXT
both: xml txt 

# Build versioned XML file
$(XML_OUT): $(XML_SRC)
	cp $< $@

# Build text version
$(TXT_OUT): $(XML_SRC)
	$(XML2RFC) --text $< -o $@

xml: $(XML_OUT)
txt: $(TXT_OUT)

clean:
	$(RM) $(TXT_OUT) $(XML_OUT)

distclean: clean
	$(RM) *~ *.bak *.tmp
	$(RM) .*.swp .*.swo

.PHONY: all txt xml clean version

# Show detected version (for debugging)
version:
	@echo "Detected version: $(VERSION)"
	@echo "Full draft name: $(DRAFT)" 

