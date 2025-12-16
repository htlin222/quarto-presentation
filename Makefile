.PHONY: slides book preview clean help index

METADATA := _metadata.yml

# Default target
all: slides book

# Inject metadata into config (portable sed)
define inject_metadata
	@sed '/METADATA_PLACEHOLDER/r $(METADATA)' $1 | sed '/METADATA_PLACEHOLDER/d' > $2
endef

# Render slides to _site
slides:
	$(call inject_metadata,_quarto.yml,_quarto.tmp.yml)
	@mv _quarto.tmp.yml _quarto.yml.gen
	@cp _quarto.yml _quarto.yml.bak
	@mv _quarto.yml.gen _quarto.yml
	quarto render index.qmd
	@mv _quarto.yml.bak _quarto.yml

# Render to _site/book as multi-page HTML book
book:
	$(call inject_metadata,_quarto-book.yml,_quarto.tmp.yml)
	@cp _quarto.yml _quarto.yml.bak
	@mv _quarto.tmp.yml _quarto.yml
	quarto render
	@mv _quarto.yml.bak _quarto.yml

# Preview with live reload (needs metadata injected)
preview:
	$(call inject_metadata,_quarto.yml,_quarto.tmp.yml)
	@cp _quarto.yml _quarto.yml.bak
	@mv _quarto.tmp.yml _quarto.yml
	quarto preview index.qmd || true
	@mv _quarto.yml.bak _quarto.yml

# Update index.qmd and _quarto-book.yml based on chapters/
index:
	@echo "Updating index.qmd from chapters/..."
	@for f in chapters/*.qmd; do \
		echo "{{< include $$f >}}"; \
	done > index.qmd
	@echo "Updating _quarto-book.yml chapters..."
	@sed -n '1,/^book:/p' _quarto-book.yml > _quarto-book.tmp
	@echo "  chapters:" >> _quarto-book.tmp
	@echo "    - index.qmd" >> _quarto-book.tmp
	@for f in chapters/*.qmd; do \
		echo "    - $$f"; \
	done >> _quarto-book.tmp
	@sed -n '/^format:/,$$p' _quarto-book.yml >> _quarto-book.tmp
	@mv _quarto-book.tmp _quarto-book.yml
	@echo "Updated with $$(ls chapters/*.qmd | wc -l | tr -d ' ') chapters"

# Clean output directories
clean:
	rm -rf _site .quarto _quarto.yml.bak _quarto.tmp.yml _quarto.yml.gen

# Help
help:
	@echo "Usage:"
	@echo "  make          - Build both slides and book"
	@echo "  make slides   - Render slides to _site/"
	@echo "  make book     - Render book to _site/book/"
	@echo "  make preview  - Live preview with auto-reload"
	@echo "  make clean    - Remove output directories"
	@echo "  make index    - Update index.qmd from chapters/"
	@echo "  make help     - Show this help"
	@echo ""
	@echo "Edit _metadata.yml to change title/subtitle/author"
	@echo ""
	@echo "GitHub Pages URLs:"
	@echo "  Slides: <username>.github.io/quarto-presentation/"
	@echo "  Book:   <username>.github.io/quarto-presentation/book/"
