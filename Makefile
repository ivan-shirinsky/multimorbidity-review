PANDOC := pandoc
REFDOC := reference.pandoc.docx

SRC := $(filter-out README.md,$(wildcard *.md))
DOC := $(basename $(SRC))

PANDOC_DOCX := \
	--from=markdown \
	--to=docx \
	--reference-doc=$(REFDOC) \
	--standalone

PANDOC_PDF := \
	--standalone \
	--pdf-engine=xelatex

.PHONY: all docx pdf clean open info

all: docx pdf

docx: $(DOC).docx
pdf: $(DOC).pdf

$(DOC).docx: $(SRC) $(REFDOC)
	$(PANDOC) $(PANDOC_DOCX) -o $@ $<

$(DOC).pdf: $(SRC)
	$(PANDOC) $(PANDOC_PDF) -o $@ $<

open: $(DOC).pdf
	xdg-open $< >/dev/null 2>&1 || true

info:
	@echo "Source Markdown: $(SRC)"
	@echo "DOCX: $(DOC).docx"
	@echo "PDF:  $(DOC).pdf"

clean:
	rm -f *.docx *.pdf
