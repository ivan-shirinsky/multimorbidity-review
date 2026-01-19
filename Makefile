# Universal Makefile for Pandoc Markdown → DOCX
# Usage: just run `make`

PANDOC := pandoc
REFDOC := reference.pandoc.docx

# Automatically detect the first .md file (excluding README.md if needed)
SRC := $(filter-out README.md,$(wildcard *.md))
DOC := $(basename $(SRC))

PANDOC_OPTS := \
	--from=markdown \
	--to=docx \
	--reference-doc=$(REFDOC) \
	--standalone

.PHONY: all docx clean open info

all: docx

docx: $(DOC).docx

$(DOC).docx: $(SRC) $(REFDOC)
	$(PANDOC) $(PANDOC_OPTS) -o $@ $<

open: $(DOC).docx
	xdg-open $< >/dev/null 2>&1 || true

info:
	@echo "Source Markdown: $(SRC)"
	@echo "Output DOCX:     $(DOC).docx"
	@echo "Reference DOCX:  $(REFDOC)"

clean:
	rm -f *.docx
