# Neovim for Java, Micronaut and Gradle

A [LazyVim](https://github.com/LazyVim/LazyVim) configuration for Gradle-based Java projects tested with Spock, such as Micronaut services backed by PostgreSQL.
Gradle compiles, runs, tests and debugs; jdtls provides language intelligence.

## What it adds to LazyVim

- **Java:** jdtls through the `lang.java` extra, with a JDK 25 runtime, Gradle import with annotation processing, code lenses and import ordering.
- **Gradle:** `<leader>j` builds, runs, debugs and picks any task; output lands in a split and compile errors load into the quickfix list.
- **Spock:** `<leader>t` runs or debugs the feature under the cursor, a spec class, or the module's tests.
- **Debugging:** nvim-dap attaches to the JVM that Gradle launches, for both the app and tests.
- **Database:** DBUI with PostgreSQL completion, plus sqlfluff for the `postgres` dialect.
- **Colours:** the [Heritage Themes](https://github.com/heritage-themes/heritage-themes.nvim) scheme `heritage-holi-night`.
- **Also:** diffview, overseer, aerial, kulala for HTTP files, and treesitter parsers for Groovy, Kotlin and XML.

## Requirements

- Neovim 0.12
- JDK 25 at `/usr/lib/jvm/java-25-openjdk`; set `jdk_home` in `lua/plugins/java.lua` for another path
- `git`, `gcc`, `unzip`, `curl`, `tar`, `node` and `tree-sitter-cli` 0.26.1 or later
- `psql` for DBUI
- [JetBrainsMono Nerd Font Mono](https://www.nerdfonts.com/) selected in the terminal
- A project with a Gradle wrapper (`./gradlew`)

## Install

Back up any existing `~/.config/nvim`, then:

```bash
git clone https://github.com/yendrrek/nvim-config ~/.config/nvim
nvim
```

The first start installs plugins and tools at the versions pinned in `lazy-lock.json`. Run `:checkhealth` afterwards.

## Per-project setup

Project settings stay out of this repository. Put the active Micronaut profile, secrets and database connections in an untracked `.lazy.lua` at the project root, then run `:trust` once. [NOTES.md](NOTES.md) has the template.

## Documentation

- [NOTES.md](NOTES.md): layout, decisions, debugging, Gradle keys, database connections and limitations.
- [KEYMAPS.md](KEYMAPS.md): every leader mapping.
