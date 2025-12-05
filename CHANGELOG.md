# CHANGELOG

# v1.1.0
- Build with temingo image as builder, so output folder is added to gitignore now.
- Remove reading-notes section, add blog section
- Add first blog post

## v1.0.22
- Update umami id, since the used umami instance changed

## v1.0.21
- Update umami id, since the used umami instance changed

## v1.0.20
- Update dependencies

## v1.0.19
- Add multi-arch build & migrate to docker-actions
- Update caddy version
- Add renovate.json for automatic updates of minor and patch versions

# v1.0.18
- Update dependencies
- Remove unused prerequisites from pipeline
- Change commit pipeline to use commit-hash instead of branch name

# v1.0.17
- Remove docs/recipes section as it was unused
- Upgrade reveal.js to v5

# v1.0.16
- Fix more links
- Add some content

# v1.0.15
- Fix more paths
- Add caching to caddy

# v1.0.14
- Fix some paths regarding `/slides` from last version
- Add WIP slides for 'Infrastructure is cool'

# v1.0.13
- Rename `/presentations` to `/slides`

## v1.0.12
- Add recipes
- Update caddy image
- Split header and footer sections into dedicated partials with no effect to rendered output

## v1.0.11
- Removed `/blog` section (contained just one demo post anyway, and will use `/docs` instead)
- Add `/docs` section with some recipes
- Add `/reading-notes` section with first demo post
- Add breadcrumbs to all pages where they make sense
- Updated readme to reflect current state of website

## v1.0.10
- Add meta-description tag

## v1.0.9
- Fix security header for analytics script
- Move svgs to inline to reduce file contents (only used once per page anyway)

## v1.0.8
- Fix security headers
- Update ubuntu version of Github Action pipeline (doesn't impact application)

## v1.0.7
- Improve accessibility
  - Add aria-label for discernible link text on buttons
- Add more headers to make website safer
- Update umami.js reference

## v1.0.6 on 2023-04-30
- Fix hidden portrait mode navigation on ios

## v1.0.5 on 2023-04-30
- Fix hidden portrait mode navigation

## v1.0.4 on 2023-04-30
- Move custom margin-top of h1 from global to body > div.textcontainer > h1 to prevent impact on centered content
- Increase space between <li> elements for better mobile accessibility

## v1.0.3 on 2023-04-30
- Add portrait mode navigation (with hamburger menu)
- Fix content centering of About page
- Move global transition setting to buttons only (to prevent page flickering on load)
- Change space above footer from <br> to padding
- Change order of tags within <head> to (minimally) improve page rendering speed

## v1.0.2 on 2023-04-16
- Added first blogpost in markdown
- Added presentations, so the website https://p.thetillhoff.de can be deprecated soon
- Added link to presentations to page navigation
- Include `Caddyfile` in docker build
- Added `.dockerignore` for faster build time
- Updated included `temingo` version

## v1.0.1 on 2023-04-04
- Fix occasional bad link coloring
- Move `color-scheme` from inline style/css to html metatag

## v1.0.0 on 2023-04-02
- Updated caddy version
- Rebuild website from scratch with newest temingo version

## v0.1.4 on 2022-10-23
- Updated caddy version
- Updated umami id

## v0.1.3 on 2022-10-03
- Updated svelte version, including filestructure rework and migration to vite
- Updated umami id

## v0.1.2 on 2022-08-13
- Updated caddy version
- Added umami script

## v0.1.1 on 2022-03-12
- Simplified docker image - now using default caddyfile
- Removed link directive

## v0.1.0 on 2022-03-09
- Added first shortened link
- Reverted rearranged order of Dockerfile commands (caching can be dismissed for one single small file)

## v0.0.2 on 2022-03-09
- Fixed and improved formatting of Caddyfile
- Changed order of commands in Dockerfile for better caching

## v0.0.1 on 2022-03-09
- Introduced this changelog file
- Create first docker container for this site
- Added github actions build and push workflow
