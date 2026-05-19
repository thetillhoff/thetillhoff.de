# Development

## Quick Start

Requires [temingo](https://github.com/thetillhoff/temingo) installed locally.

```sh
temingo -w -s -v   # build, watch for changes, serve at http://localhost:8080
temingo        # one-shot build to output/
```

## Tech Stack

| Layer | Tool | Version |
|-------|------|---------|
| Static site generator | [Temingo](https://github.com/thetillhoff/temingo) | 2.1.4 |
| Web server | Caddy | 2.11.2 |
| Container | Docker multi-arch | linux/amd64, linux/arm64 |
| Analytics | Self-hosted Umami | — |

No JavaScript frameworks, no CSS preprocessors, no external fonts.

## Project Structure

```
src/                       # All source content (temingo input)
├── index.template.html    # Homepage
├── style.template.css     # Global styles
├── partials/              # Reusable template snippets
│   ├── page.partial.html  # Base HTML structure (head + body)
│   ├── nav.partial.html   # Responsive navigation
│   └── *.partial.css      # Per-component styles
├── blog/
│   ├── index.template.html       # Blog listing
│   ├── index.metatemplate.html   # Per-post page generator
│   └── <slug>/
│       ├── meta.yaml      # title (required)
│       └── content.md     # post body (Markdown)
└── slides/
    ├── index.template.html       # Slides listing
    └── YYYY-MM-DD-<Title>/
        ├── meta.yaml      # date, title (required)
        └── index.template.html   # Reveal.js slide deck
output/                    # Generated HTML — gitignored, not edited manually
```

## Temingo File Conventions

| Extension | Behaviour |
|-----------|-----------|
| `.template.*` | Rendered to a single output file |
| `.metatemplate.*` | Rendered once per child `meta.yaml` entry |
| `.partial.*` | Registered as reusable snippet, no direct output |
| `meta.yaml` | Metadata for that directory; inherited by child templates |
| `content.md` | Markdown auto-converted to HTML, available as `.content` |
| Anything else | Copied as-is |

## Content Workflows

### Add a blog post

```sh
mkdir src/blog/my-post-slug
# create meta.yaml:  title: "Post Title"
# create content.md: Markdown body
```

The post is automatically added to the blog listing via `.childMeta`.

### Add a slide deck

```sh
mkdir src/slides/YYYY-MM-DD-Title
# create meta.yaml:  date: "YYYY-MM-DD", title: "Talk Title"
# create index.template.html with Reveal.js HTML
```

See `src/slides/README.md` for Reveal.js syntax.

## Styling

CSS variables live in `:root` in `src/style.template.css`. Dark/light mode is handled via `prefers-color-scheme` media queries — no JavaScript. Component-scoped styles live in `src/partials/*.partial.css` and are included from the relevant HTML partials.

## Build & Deploy

All deploys go through GitHub Actions:

| Trigger | Action |
|---------|--------|
| Any push | Build Docker image, push `ghcr.io/thetillhoff/thetillhoff.de:<sha>` + `:latest` |
| Version tag `vX.Y.Z` | Validate CHANGELOG entry, build + push `:<tag>` + `:latest` |

**Release process:**
1. Add entry to `CHANGELOG.md` under the new version.
2. `git tag vX.Y.Z && git push origin vX.Y.Z`

## Docker Build

Two-stage build — temingo generates `output/`, Caddy serves it:

```dockerfile
FROM ghcr.io/thetillhoff/temingo:2.1.4 AS builder
COPY src src
RUN temingo

FROM caddy:2.11.2
COPY Caddyfile /etc/caddy/Caddyfile
COPY --from=builder /workspace/output/ /usr/share/caddy/
```

Ports: `80` (website), `8080` (healthcheck: `"I'm healthy!"`).

## Security Headers (Caddyfile)

| Header | Value |
|--------|-------|
| Cache-Control | `public, max-age=3600, must-revalidate` |
| HSTS | `max-age=31536000` |
| X-Frame-Options | `DENY` |
| X-Content-Type-Options | `nosniff` |
| CSP | `default-src 'none'` + self, Cloudflare CDN (Reveal.js), analytics |

`unsafe-inline` in CSP is required for Reveal.js inline styles.

## No Automated Tests

Validation is visual only — run `temingo -wsv` and check `http://localhost:8080`.