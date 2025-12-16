# Quarto revealjs presentation template

A modular Quarto presentation template with reveal.js plugins. Builds slides and HTML book.

## Features

- `reveal-auto-agenda` - Generates agenda slides
- **code-fullscreen** - Fullscreen button for code blocks
- **codeFocus** - Progressive code line highlighting with explanations
- **simplemenu** - Navigation menu bar for sections

## Project structure

```
.
├── _metadata.yml        # Shared metadata (title, author) - edit this
├── _quarto.yml          # Slides configuration
├── _quarto-book.yml     # Book configuration
├── index.qmd            # Main entry (generated includes)
├── chapters/            # Modular slide content
│   └── *.qmd
├── custom.scss          # Custom theme styles
├── Makefile             # Build automation
└── .github/workflows/   # GitHub Actions (auto-deploy)
```

## Quick start

```bash
# Build both slides and book
make

# Build slides only → _site/
make slides

# Build book only → _site/book/
make book

# Live preview with auto-reload
make preview

# Update index after adding/removing sections
make index

# Clean output directories
make clean
```

## Customization

### Change title or author

Edit `_metadata.yml`:

```yaml
title: "Your Presentation Title"
subtitle: "Your Subtitle"
author: "Your Name"
```

### Add a section

1. Create file in `chapters/` (for example, `chapters/06-newchapter.qmd`)
2. Run `make index` to update includes
3. Run `make` to build

### Section format

Each section should start with a level-1 heading with `data-stack-name` for simplemenu:

```markdown
# Section Title {data-stack-name="MenuName"}

## Slide title

Content here...
```

### Codefocus usage

````markdown
## Slide with CodeFocus

\```python
import requests
response = requests.get(url)
data = response.json()
\```

::: {.fragment .current-only data-code-focus="1"}
Import the requests library.
:::

::: {.fragment .current-only data-code-focus="2-3"}
Make request and parse JSON.
:::
````

## Output

| Command       | Output                  | Address (GitHub Pages)          |
| ------------- | ----------------------- | ------------------------------- |
| `make slides` | `_site/index.html`      | `username.github.io/repo/`      |
| `make book`   | `_site/book/index.html` | `username.github.io/repo/book/` |

## Deploy

Automated via GitHub Actions. On push to `main`:

1. Builds slides → `_site/`
2. Builds book → `_site/book/`
3. Deploys to GitHub Pages

Setup:

1. Go to repo Settings → Pages
2. Set Source to "GitHub Actions"
3. Push to `main` branch

## Requirements

- [Quarto](https://quarto.org/) ≥ 1.3

## License

MIT
