.PHONY: all render preview clean help

# Default target
all: render

# Render both formats (slides.html + index.html)
render:
	quarto render index.qmd

# Preview with live reload
preview:
	quarto preview index.qmd

# Clean output directories
clean:
	rm -rf _site .quarto

# Help
help:
	@echo "Usage:"
	@echo "  make          - Build slides.html and index.html"
	@echo "  make render   - Same as above"
	@echo "  make preview  - Live preview with auto-reload"
	@echo "  make clean    - Remove output directories"
	@echo "  make help     - Show this help"
	@echo ""
	@echo "Edit _quarto.yml to change title/subtitle/author"
	@echo ""
	@echo "Output files:"
	@echo "  _site/index.html  - HTML page with TOC"
	@echo "  _site/slides.html - Revealjs presentation"
