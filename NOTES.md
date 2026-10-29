# Neovim notes: Java, Micronaut and Gradle

LazyVim configuration for Java projects built with Gradle and tested with Spock, such as Micronaut services backed by PostgreSQL.
Neovim 0.12, jdtls 1.63, JetBrainsMono Nerd Font Mono.

## Layout

| Path | Purpose |
|---|---|
| `lazyvim.json` | Enabled LazyVim extras. Manage with `:LazyExtras`. |
| `lua/plugins/java.lua` | jdtls settings layered on the `lang.java` extra; code lenses. |
| `lua/plugins/sql.lua` | sqlfluff uses the `postgres` dialect. |
| `lua/plugins/treesitter.lua` | Extra parsers; `*.gradle` is Groovy. |
| `lua/plugins/git.lua` | diffview. |
| `lua/java/gradle.lua` | Run, test and debug through `./gradlew`. |
| `lua/java/spock.lua` | Resolve the Spock class, feature and Gradle project path. |
| `lua/overseer/template/gradle.lua` | Gradle tasks as overseer templates. |
| `lua/config/keymaps.lua` | `<leader>j` (Gradle) and `<leader>t` (Gradle tests). |

## Decisions

- Gradle compiles, runs, tests and debugs. jdtls provides language intelligence only, because it does not reliably run Micronaut's annotation processors.
- jdtls runs on `/usr/lib/jvm/java-25-openjdk`, set in `lua/plugins/java.lua`, independent of the shell's `JAVA_HOME` and SDKMAN. Change it for another JDK.
- `lang.java` starts jdtls from its plugin spec. No `ftplugin/java.lua` exists; do not add `vim.lsp.enable("jdtls")`.
- Spotless formats Java (google-java-format, 2-space indent). `java.format.enabled = false`.
- The extra's Lombok agent is removed from `opts.cmd`. Add `--jvm-arg=-javaagent:<lombok.jar>` back for a project that uses Lombok.
- Extras live in `lazyvim.json`. Importing them from `lua/plugins/` triggers LazyVim's import-order warning.
- Gradle keys use `<leader>j`; `<leader>b` is LazyVim's buffer group.
- Diffview uses `<leader>gv` and `<leader>gV`; `<leader>gh` is the hunks group and `<leader>gd` is the picker's git diff.
- jdtls writes Eclipse build output to `bin/` in each project. Add `bin/` to the project's `.git/info/exclude`.
- Not installed because LazyVim covers them: telescope, oil, mini.comment, undotree, neotest, claudecode.

## Run a Spock test

Open a spec in `src/test/groovy`.

| Key | Action |
|---|---|
| `<leader>tn` | Run the feature at or above the cursor. |
| `<leader>tf` | Run the spec class. |
| `<leader>ta` | Run the module's `test` task. |
| `<leader>tN` / `<leader>tF` | Debug the feature or class. |
| `<leader>tl` | Re-run the last Gradle task. |
| `<leader>to` | Open `build/reports/tests/test/index.html`. |

`<leader>tn` runs `./gradlew :test --rerun --tests 'pkg.MySpec.feature name*'`. The trailing `*` also matches `where:` iterations. Test runs pass `--rerun`, so an unchanged test still runs and can stop at a breakpoint. Failures load into the quickfix list.

## Debug

**Gradle launches the JVM and the debugger attaches (default).** `<leader>jd` runs `./gradlew run --debug-jvm`, waits for `Listening for transport dt_socket`, and attaches to port 5005. `<leader>tN` and `<leader>tF` do the same for tests. `<leader>dt` ends the session and stops the Gradle job.

**jdtls launches the JVM.** `<leader>dc` lists the main classes jdtls found. It runs classes jdtls compiled itself, so Micronaut apps can fail when generated beans are missing.

Breakpoints go in Java production code. A breakpoint inside a `.groovy` spec does not stop the debugger.

Step keys: `<leader>di` into, `<leader>dO` over, `<leader>do` out, `<leader>dc` continue.

## Gradle keys

| Key | Task |
|---|---|
| `<leader>jb` | `build` |
| `<leader>jc` | `compileJava compileTestGroovy` |
| `<leader>jr` | `run` |
| `<leader>jt` | `-t run` (continuous) |
| `<leader>jd` | `run --debug-jvm` and attach |
| `<leader>jn` | `nativeCompile` |
| `<leader>js` | `spotlessApply` |
| `<leader>jp` | `dependencies` |
| `<leader>jk` | Pick any Gradle task (overseer) |
| `<leader>jl` | Re-run the last task |

Generated Micronaut classes can show as unresolved in jdtls. Run `<leader>jc` and read the quickfix list.

## Run a Micronaut app

`<leader>jr` runs `./gradlew run` with Neovim's environment. Set the active profile and any placeholder values that have no default in the untracked `.lazy.lua` at the project root:

```lua
vim.env.MICRONAUT_ENVIRONMENTS = "dev"

-- Secrets: KEY=value lines (no quotes) from a file outside every repository.
local env_file = vim.fn.expand("~/.config/<project>-dev.env")
if vim.uv.fs_stat(env_file) then
  for line in io.lines(env_file) do
    local key, value = line:match("^%s*([%w_]+)%s*=%s*(.-)%s*$")
    if key then
      vim.env[key] = value
    end
  end
end

return {}
```

- Create the env file with mode `0600`.
- Add `.lazy.lua` to the project's `.git/info/exclude`.
- Run `:trust` with `.lazy.lua` as the current file after every edit to it.
- Micronaut splits a placeholder default that contains colons, such as `${DB_URL:jdbc:postgresql://localhost:5432/app}`, at the first colon and fails with `Invalid JDBC URL [5432/app]`. Activate a profile that hard-codes the URL.

## Add a database connection

`<leader>D` toggles DBUI. Define connections per project in the same `.lazy.lua`:

```lua
vim.g.dbs = {
  { name = "<project>", url = "postgresql://<user>@localhost:5432/<database>" },
}
```

- Keep passwords out of the URL. Put them in `~/.pgpass` (mode `0600`): `localhost:5432:<database>:<user>:<password>`.
- Start the development database before connecting.
- Query buffers complete table names after a typed letter or `Ctrl+Space`. The sqlfluff linter flags an incomplete statement while you type.

## Limitations

- No Micronaut-aware navigation, such as bean or route views.
- jdtls gives no semantic support in `.groovy` files; Spock specs get treesitter highlighting only.
- jdtls reports `ExpressionEvaluationContextRegistrar` as unresolved in files that use Micronaut Security expressions, and flags the build path as incomplete. The class is in `micronaut-core-processor`, which is on Gradle's annotation-processor path and not on `compileClasspath`. Gradle compiles the project; ignore these two diagnostics.
- DBUI has no ER diagrams or grid editing.

## Health warnings that need no action

Missing `luarocks`, `cargo`, Go, Ruby and Julia; kitty graphics, LaTeX and mermaid tools for snacks image rendering; the optional Python `neovim` provider; filetype names that other languages' LSP configs list. The Snacks dashboard, notifier and `vim.ui.*` messages appear only without a UI.
