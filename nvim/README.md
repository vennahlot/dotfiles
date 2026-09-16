# Neovim config

A small, deliberate Neovim setup. It is symlinked to `~/.config/nvim` and
lives in the [dotfiles](..) repo.

## Philosophy

**Use what Vim already has. Add only the missing ergonomics.**

Neovim ships with a lot: the alternate buffer, the jumplist, global marks,
`:b` with substring completion, treesitter folds, an LSP client with sensible
default keys, native completion, `:grep` into the quickfix list. Most of the
pain people solve with plugins is really unfamiliarity with these. So:

1. **Reach for a built-in first.** If a habit covers the need, learn the
   habit. Comments in the config and the start screen exist to keep those
   habits fresh, not to replace them with a plugin.
2. **Fill real gaps with small code.** When a built-in is almost right but
   awkward (`:bd` closing its window, no floating lazygit), write ten to
   thirty lines of Lua in `config/util.lua` rather than pulling in a plugin.
3. **Add a plugin only for a capability, not a convenience.** Fuzzy finding,
   LSP server installation, treesitter, in-buffer markdown rendering. Each
   plugin has one file and a one-line comment saying why it is there.
4. **No persistent UI that competes for attention.** No bufferline, no file
   tree sidebar. Lists appear on demand (Telescope, Oil) and go away.
5. **Learn in manual mode.** Automation that hides state (auto-closing
   buffers, sessions, format on save) is held off until the manual workflow
   is understood and found wanting.

The config is tuned for how Neovim is used now that coding agents write most
code: reading, searching, browsing a repo, understanding structure, reviewing
diffs, and small edits. Debugging, snippets, refactoring helpers and format on
save were removed for that reason.

Every mapping has a `desc`, so which-key documents the config for free and
`:WhichKey` is the reference.

## Layout

```
init.lua                 sets the leader, requires config.*
lua/config/options.lua   only options that differ from defaults, grouped by purpose
lua/config/keymaps.lua   keys for built-ins and for config/util.lua helpers
lua/config/autocmds.lua  yank highlight, formatoptions, reload files changed outside
lua/config/util.lua      layout-safe buffer close, close others, floating terminal
lua/config/lazy.lua      lazy.nvim bootstrap
lua/plugins/*.lua        one plugin per file, self-contained: spec, opts, its own keys
ftplugin/java.lua        starts jdtls per project (see plugins/jdtls.lua)
ftplugin/markdown.lua    soft wrap for reading
.stylua.toml             2 spaces, 120 columns; .editorconfig mirrors it
lazy-lock.json           pinned plugin versions
```

**Where a keymap lives.** Next to what it calls. Built-in behavior and
`config/util.lua` helpers are mapped in `config/keymaps.lua`. Plugin behavior
is mapped in that plugin's spec, under `keys` when it should lazy-load the
plugin. `which-key.lua` defines group names only.

## Plugins

| Area | Plugin | Why |
| --- | --- | --- |
| Plugin manager | lazy.nvim | Lazy loading, lockfile |
| Colors | gruvbox.nvim | Hard contrast; loaded first so nothing paints before it |
| Start screen | alpha-nvim | Recent files, quick links, cheat sheet of habits |
| Statusline | lualine.nvim | Per window; no tabline |
| Keys | which-key.nvim | Group names and hints, `timeoutlen = 0` |
| Finder | telescope.nvim + fzf-native | Files, grep, buffers (MRU), marks, diagnostics, symbols |
| Files | oil.nvim | Edit a directory as a buffer, `-` opens parent |
| Syntax | nvim-treesitter + textobjects | Highlight, folds, `]m` `[[` motions, `af` `ic` objects |
| LSP | nvim-lspconfig + mason + mason-lspconfig | Servers installed by Mason, enabled automatically |
| Java | nvim-jdtls | Per-project workspace, decompiler, started from `ftplugin/java.lua` |
| Git | gitsigns.nvim | Gutter signs, hunk motions, blame, diff |
| Markdown | render-markdown.nvim | Rendered headings, tables, fences in the buffer |
| Markdown | markdown-preview.nvim | Browser preview for diagrams and the full page |
| Lua dev | lazydev.nvim | Neovim API types for editing this config |

Completion is Neovim's native LSP completion with autotrigger (`<C-n>`
`<C-p>` `<C-y>`). Formatting is `vim.lsp.buf.format` on demand. Lazygit runs
in a native floating terminal from `config/util.lua`.

## Keymaps worth knowing

Leader is `<Space>`. Press it and wait for which-key.

| Key | Action |
| --- | --- |
| `<leader><leader>` | Buffers, most recent first. `<C-x>` deletes in the picker |
| `<leader>ff` / `fg` / `fw` | Find files / live grep / grep word under cursor |
| `<leader>fr` / `fc` / `fm` | Recent files / lines in current buffer / marks |
| `<leader>fd` / `fs` / `fh` | Diagnostics / workspace symbols / help |
| `<leader>bd` / `bD` | Delete buffer, keep window layout (force) |
| `<leader>bo` / `ba` | Close other buffers / close all, reopen current |
| `-` | Open parent directory in Oil |
| `gd` / `gO` / `grr` | Definition / document symbols / references (Telescope) |
| `grn` / `gra` / `gri` / `grt` / `K` | Rename / code action / implementation / type def / hover (defaults) |
| `[d` / `]d` / `<C-w>d` | Previous / next diagnostic / show diagnostic (defaults) |
| `<leader>cf` / `co` | Format buffer / organize imports (Java) |
| `]h` / `[h` / `<leader>gp` | Next / previous hunk / preview hunk |
| `<leader>gb` / `gB` / `gd` | Toggle line blame / full blame / diff this file |
| `<leader>gg` | Lazygit in a float |
| `<leader>mr` / `mp` | Toggle markdown rendering / browser preview |
| `]m` `[m` `]]` `[[` | Next / previous function, next / previous class |
| `<C-h/j/k/l>` | Move between windows |

### Built-in habits (no config, just practice)

| Key | Action |
| --- | --- |
| `<C-^>` | Toggle to the alternate buffer |
| `<C-o>` / `<C-i>` | Jumplist back / forward, crosses buffers |
| `:b part<Tab>` | Complete on any substring of a buffer name |
| `mQ` ... `'Q` | Uppercase marks are global and persist: a pinned file set |
| `zM` / `zR` / `za` | Fold a file to its structure / open all / toggle one |
| `:grep foo` then `]q` `[q` | Ripgrep into the quickfix list, walk the results |
| `<C-\><C-n>` | Leave terminal mode inside the lazygit float |

These are also listed on the start screen. Trim lines there as they become
muscle memory.

## Setup

Requires Neovim 0.11 or newer, a Nerd Font, `ripgrep`, `cmake` (for
fzf-native) and `lazygit`. Clone the dotfiles repo, symlink this directory to
`~/.config/nvim`, and start Neovim. lazy.nvim bootstraps itself and installs
everything pinned in `lazy-lock.json`. Language servers are installed by
Mason on first use; run `:Mason` to see them. Format this config with
`stylua .` from this directory.
