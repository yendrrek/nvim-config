# Keymap cheat sheet

Leader is `Space`. Press `<leader>` and wait for which-key for the live list, or `<leader>?` for the current buffer's keymaps.
Generated from the live normal and visual mode mappings in a Java buffer with jdtls attached.

## Top level

| Key | Mode | Action |
|---|---|---|
| `<leader><leader>` | n | Find Files (Root Dir) |
| `<leader>,` | n | Buffers |
| `<leader>-` | n | Split Window Below |
| `<leader>.` | n | Toggle Scratch Buffer |
| `<leader>/` | n | Grep (Root Dir) |
| `<leader>:` | n | Command History |
| `<leader><Tab><Tab>` | n | New Tab |
| `<leader><Tab>[` | n | Previous Tab |
| `<leader><Tab>]` | n | Next Tab |
| `<leader><Tab>d` | n | Close Tab |
| `<leader><Tab>f` | n | First Tab |
| `<leader><Tab>l` | n | Last Tab |
| `<leader><Tab>o` | n | Close Other Tabs |
| `<leader>?` | n | Buffer Keymaps (which-key) |
| `` <leader>` `` | n | Switch to Other Buffer |
| `<leader>K` | n | Keywordprg |
| `<leader>n` | n | Notification History |
| `<leader>S` | n | Select Scratch Buffer |
| `<leader>\|` | n | Split Window Right |

## Buffers

| Key | Mode | Action |
|---|---|---|
| `<leader>bb` | n | Switch to Other Buffer |
| `<leader>bD` | n | Delete Buffer and Window |
| `<leader>bd` | n | Delete Buffer |
| `<leader>bi` | n | Delete Invisible Buffers |
| `<leader>bj` | n | Pick Buffer |
| `<leader>bl` | n | Delete Buffers to the Left |
| `<leader>bo` | n | Delete Other Buffers |
| `<leader>bp` | n | Toggle Pin |
| `<leader>bP` | n | Delete Non-Pinned Buffers |
| `<leader>br` | n | Delete Buffers to the Right |

## Code

| Key | Mode | Action |
|---|---|---|
| `<leader>ca` | n, x | Code Action |
| `<leader>cA` | n | Source Action |
| `<leader>cc` | n, x | Run Codelens |
| `<leader>cC` | n | Refresh & Display Codelens |
| `<leader>cd` | n | Line Diagnostics |
| `<leader>cf` | n, x | Format |
| `<leader>cF` | n, x | Format Injected Langs |
| `<leader>cl` | n | Lsp Info |
| `<leader>cm` | n | Mason |
| `<leader>co` | n | Organize Imports |
| `<leader>cr` | n | Rename |
| `<leader>cS` | n | LSP references/definitions/... (Trouble) |
| `<leader>cs` | n | Aerial (Symbols) |

## Debug

| Key | Mode | Action |
|---|---|---|
| `<leader>da` | n | Run with Args |
| `<leader>db` | n | Toggle Breakpoint |
| `<leader>dB` | n | Breakpoint Condition |
| `<leader>dC` | n | Run to Cursor |
| `<leader>dc` | n | Run/Continue |
| `<leader>de` | n, x | Eval |
| `<leader>dg` | n | Go to Line (No Execute) |
| `<leader>di` | n | Step Into |
| `<leader>dj` | n | Down |
| `<leader>dk` | n | Up |
| `<leader>dl` | n | Run Last |
| `<leader>dO` | n | Step Over |
| `<leader>do` | n | Step Out |
| `<leader>dP` | n | Pause |
| `<leader>dph` | n | Toggle Profiler Highlights |
| `<leader>dpp` | n | Toggle Profiler |
| `<leader>dps` | n | Profiler Scratch Buffer |
| `<leader>dr` | n | Toggle REPL |
| `<leader>ds` | n | Session |
| `<leader>dt` | n | Terminate |
| `<leader>du` | n | Dap UI |
| `<leader>dw` | n | Widgets |

## Database

| Key | Mode | Action |
|---|---|---|
| `<leader>D` | n | Toggle DBUI |

## Explorer

| Key | Mode | Action |
|---|---|---|
| `<leader>E` | n | Explorer Snacks (cwd) |
| `<leader>e` | n | Explorer Snacks (root dir) |

## Files

| Key | Mode | Action |
|---|---|---|
| `<leader>fB` | n | Buffers (all) |
| `<leader>fb` | n | Buffers |
| `<leader>fc` | n | Find Config File |
| `<leader>fE` | n | Explorer Snacks (cwd) |
| `<leader>fe` | n | Explorer Snacks (root dir) |
| `<leader>fF` | n | Find Files (cwd) |
| `<leader>ff` | n | Find Files (Root Dir) |
| `<leader>fg` | n | Find Files (git-files) |
| `<leader>fn` | n | New File |
| `<leader>fp` | n | Projects |
| `<leader>fR` | n | Recent (cwd) |
| `<leader>fr` | n | Recent |
| `<leader>ft` | n | Terminal (Root Dir) |
| `<leader>fT` | n | Terminal (cwd) |

## Git

| Key | Mode | Action |
|---|---|---|
| `<leader>gB` | n, x | Git Browse (open) |
| `<leader>gb` | n | Git Blame Line |
| `<leader>gD` | n | Git Diff (origin) |
| `<leader>gd` | n | Git Diff (hunks) |
| `<leader>gf` | n | Git Current File History |
| `<leader>gG` | n | Lazygit (cwd) |
| `<leader>gg` | n | Lazygit (Root Dir) |
| `<leader>ghB` | n | Blame Buffer |
| `<leader>ghb` | n | Blame Line |
| `<leader>ghD` | n | Diff This ~ |
| `<leader>ghd` | n | Diff This |
| `<leader>ghp` | n | Preview Hunk Inline |
| `<leader>ghR` | n | Reset Buffer |
| `<leader>ghr` | n, x | Reset Hunk |
| `<leader>ghS` | n | Stage Buffer |
| `<leader>ghs` | n, x | Stage Hunk |
| `<leader>ghu` | n | Undo Stage Hunk |
| `<leader>gI` | n | GitHub Issues (all) |
| `<leader>gi` | n | GitHub Issues (open) |
| `<leader>gl` | n | Git Log |
| `<leader>gL` | n | Git Log (cwd) |
| `<leader>gP` | n | GitHub Pull Requests (all) |
| `<leader>gp` | n | GitHub Pull Requests (open) |
| `<leader>gS` | n | Git Stash |
| `<leader>gs` | n | Git Status |
| `<leader>gV` | n | Branch History (Diffview) |
| `<leader>gv` | n | Diffview |
| `<leader>gY` | n, x | Git Browse (copy) |

## Gradle

| Key | Mode | Action |
|---|---|---|
| `<leader>jb` | n | Build |
| `<leader>jc` | n | Compile (fast check) |
| `<leader>jd` | n | Run with debugger |
| `<leader>jk` | n | Pick task |
| `<leader>jl` | n | Re-run last task |
| `<leader>jn` | n | Native compile |
| `<leader>jp` | n | Dependencies |
| `<leader>jr` | n | Run |
| `<leader>js` | n | Spotless apply |
| `<leader>jt` | n | Run (continuous) |

## Plugins

| Key | Mode | Action |
|---|---|---|
| `<leader>L` | n | LazyVim Changelog |
| `<leader>l` | n | Lazy |

## Overseer

| Key | Mode | Action |
|---|---|---|
| `<leader>oo` | n | Run task |
| `<leader>ot` | n | Task action |
| `<leader>ow` | n | Task list |

## Session and quit

| Key | Mode | Action |
|---|---|---|
| `<leader>qd` | n | Don't Save Current Session |
| `<leader>ql` | n | Restore Last Session |
| `<leader>qq` | n | Quit All |
| `<leader>qS` | n | Select Session |
| `<leader>qs` | n | Restore Session |

## REST client

| Key | Mode | Action |
|---|---|---|
| `<leader>R` | n | +Rest |
| `<leader>Rb` | n | Open scratchpad |
| `<leader>Rr` | n | Replay the last request |

## Search

| Key | Mode | Action |
|---|---|---|
| `<leader>s"` | n | Registers |
| `<leader>s/` | n | Search History |
| `<leader>sa` | n | Autocmds |
| `<leader>sB` | n | Grep Open Buffers |
| `<leader>sb` | n | Buffer Lines |
| `<leader>sC` | n | Commands |
| `<leader>sc` | n | Command History |
| `<leader>sD` | n | Buffer Diagnostics |
| `<leader>sd` | n | Diagnostics |
| `<leader>sG` | n | Grep (cwd) |
| `<leader>sg` | n | Grep (Root Dir) |
| `<leader>sH` | n | Highlights |
| `<leader>sh` | n | Help Pages |
| `<leader>si` | n | Icons |
| `<leader>sj` | n | Jumps |
| `<leader>sk` | n | Keymaps |
| `<leader>sl` | n | Location List |
| `<leader>sm` | n | Marks |
| `<leader>sM` | n | Man Pages |
| `<leader>sn` | n | +noice |
| `<leader>sna` | n | Noice All |
| `<leader>snd` | n | Dismiss All |
| `<leader>snh` | n | Noice History |
| `<leader>snl` | n | Noice Last Message |
| `<leader>snt` | n | Noice Picker (Telescope/FzfLua) |
| `<leader>sp` | n | Search for Plugin Spec |
| `<leader>sq` | n | Quickfix List |
| `<leader>sR` | n | Resume |
| `<leader>sr` | n, x | Search and Replace |
| `<leader>ss` | n | LSP Symbols |
| `<leader>sS` | n | LSP Workspace Symbols |
| `<leader>sT` | n | Todo/Fix/Fixme |
| `<leader>st` | n | Todo |
| `<leader>su` | n | Undotree |
| `<leader>sW` | n, x | Visual selection or word (cwd) |
| `<leader>sw` | n, x | Visual selection or word (Root Dir) |

## Test

| Key | Mode | Action |
|---|---|---|
| `<leader>ta` | n | Test module (Gradle) |
| `<leader>tF` | n | Debug test file (Gradle) |
| `<leader>tf` | n | Test file (Gradle) |
| `<leader>tl` | n | Re-run last (Gradle) |
| `<leader>tN` | n | Debug nearest test (Gradle) |
| `<leader>tn` | n | Test nearest (Gradle) |
| `<leader>to` | n | Open test report |

## UI toggles

| Key | Mode | Action |
|---|---|---|
| `<leader>ua` | n | Toggle Animations |
| `<leader>uA` | n | Toggle Tabline |
| `<leader>ub` | n | Toggle Dark Background |
| `<leader>uc` | n | Toggle Conceal Level |
| `<leader>uC` | n | Colorschemes |
| `<leader>uD` | n | Toggle Dimming |
| `<leader>ud` | n | Toggle Diagnostics |
| `<leader>uF` | n | Toggle Auto Format (Buffer) |
| `<leader>uf` | n | Toggle Auto Format (Global) |
| `<leader>ug` | n | Toggle Indent Guides |
| `<leader>uG` | n | Toggle Git Signs |
| `<leader>uh` | n | Toggle Inlay Hints |
| `<leader>uI` | n | Inspect Tree |
| `<leader>ui` | n | Inspect Pos |
| `<leader>ul` | n | Toggle Line Numbers |
| `<leader>uL` | n | Toggle Relative Number |
| `<leader>un` | n | Dismiss All Notifications |
| `<leader>up` | n | Toggle Mini Pairs |
| `<leader>ur` | n | Redraw / Clear hlsearch / Diff Update |
| `<leader>uS` | n | Toggle Smooth Scroll |
| `<leader>us` | n | Toggle Spelling |
| `<leader>uT` | n | Toggle Treesitter Highlight |
| `<leader>ut` | n | Toggle Treesitter Context |
| `<leader>uw` | n | Toggle Wrap |
| `<leader>uz` | n | Toggle Zen Mode |
| `<leader>uZ` | n | Toggle Zoom Mode |

## Windows

| Key | Mode | Action |
|---|---|---|
| `<leader>wd` | n | Delete Window |
| `<leader>wm` | n | Toggle Zoom Mode |

## Diagnostics and quickfix

| Key | Mode | Action |
|---|---|---|
| `<leader>xl` | n | Location List |
| `<leader>xL` | n | Location List (Trouble) |
| `<leader>xq` | n | Quickfix List |
| `<leader>xQ` | n | Quickfix List (Trouble) |
| `<leader>xT` | n | Todo/Fix/Fixme (Trouble) |
| `<leader>xt` | n | Todo (Trouble) |
| `<leader>xx` | n | Diagnostics (Trouble) |
| `<leader>xX` | n | Buffer Diagnostics (Trouble) |

## Java buffers (jdtls)

Set when jdtls attaches. Test keys need the debug and test bundles.

| Key | Mode | Action |
|---|---|---|
| `<leader>co` | n | Organise imports |
| `<leader>cxv` | n, x | Extract variable |
| `<leader>cxc` | n, x | Extract constant |
| `<leader>cxm` | x | Extract method |
| `<leader>cgs` | n | Go to super implementation |
| `<leader>cgS` | n | Go to test subjects |
| `<leader>tt` | n | Run all tests in the class (JUnit) |
| `<leader>tr` | n | Run the nearest test (JUnit) |
| `<leader>tT` | n | Pick a test to run (JUnit) |
