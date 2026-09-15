# Neovim config

A small, deliberate Neovim setup. It is symlinked to `~/.config/nvim` and
lives in the [dotfiles](..) repo.

## Philosophy

**Use what Vim already has. Add only the missing ergonomics.**

Neovim ships with a lot: the alternate buffer, the jumplist, global marks,
`:b` with substring completion, an LSP client, treesitter. Most of the pain
people solve with plugins is really unfamiliarity with these. So the rule
here is:

1. **Reach for a built-in first.** If a habit covers the need, learn the
   habit. Comments in the config and the start screen exist to keep those
   habits fresh, not to replace them with a plugin.
2. **Fill real gaps with small code.** When a built-in is almost right but
   awkward (for example `:bd` closing the window it is in), write ten to
   twenty lines of Lua rather than pulling in a plugin.
3. **Add a plugin only for a capability, not a convenience.** Fuzzy finding,
   LSP/DAP installation, completion, formatting, treesitter. Each plugin has
   one file and a one-line comment saying why it is there.
4. **No persistent UI that competes for attention.** No bufferline, no file
   tree sidebar. Lists appear on demand (Telescope, Oil) and go away.
5. **Learn in manual mode.** Automation that hides state (auto-closing
   buffers, auto-sessions) is held off until the manual workflow is
   understood and found wanting.

Every mapping has a `desc`, so `which-key` documents the config for free and
`:WhichKey` is the reference.

## Layout

```
init.lua                       picks standalone or VSCode mode
lua/ven/standalone/
  init.lua                     bootstraps lazy.nvim, disables unused providers
  options.lua                  vim.opt settings
  keymaps.lua                  non-plugin keymaps and small Lua helpers
  autocmds.lua                 yank highlight, formatoptions
  plugins/*.lua                one plugin spec per file, loaded by lazy.nvim
lua/ven/vscode/                minimal options/keymaps when run inside VSCode
ftplugin/java.lua              starts jdtls per project (see plugins/jdtls.lua)
lazy-lock.json                 pinned plugin versions
```

`init.lua` checks `vim.g.vscode`. Inside the VSCode Neovim extension only
keymaps and options load; standalone gets the full plugin set.

## Plugins

| Area | Plugin | Why |
| --- | --- | --- |
| Plugin manager | lazy.nvim | Lazy loading, lockfile |
| Colors | gruvbox.nvim | Loaded first so nothing paints before it |
| Start screen | alpha-nvim | MRU list plus a cheat sheet of habits to keep |
| Statusline | lualine.nvim | Per-window status; no tabline |
| Keys | which-key.nvim | Discoverable keymaps, `timeoutlen = 0` |
| Finder | telescope.nvim + fzf-native | Files, grep, buffers (MRU), marks, LSP |
| Files | oil.nvim | Edit a directory as a buffer, `-` opens parent |
| Syntax | nvim-treesitter | Highlight and text objects |
| LSP | nvim-lspconfig + mason | Servers installed by Mason, enabled automatically |
| Java | nvim-jdtls | Per-project workspace, started from `ftplugin/java.lua` |
| Completion | blink.cmp | Fast completion with LSP source |
| Formatting | conform.nvim | Formatters from Mason, LSP fallback |
| Debugging | nvim-dap | Debug adapter client |
| Git | gitsigns.nvim | Gutter signs and hunk actions |
| Terminal | toggleterm.nvim | Floating lazygit and Claude Code |
| Markdown | markdown-preview.nvim | Live preview in the browser |
| Lua dev | lazydev.nvim | Neovim API types for this config |

## Keymaps worth knowing

Leader is `<Space>`. Press it and wait for which-key.

| Key | Action |
| --- | --- |
| `<leader><leader>` | Buffers, most recent first. `<C-x>` deletes in the picker |
| `<leader>ff` / `fg` / `fr` | Find files / live grep / recent files |
| `<leader>fc` / `fw` / `fm` | Grep current buffer / grep word / marks |
| `<leader>bd` / `bD` | Delete buffer, keep window layout (force) |
| `<leader>bo` / `ba` | Close other buffers / close all, reopen current |
| `-` | Open parent directory in Oil |
| `gd` / `gr` / `gi` / `K` | LSP definition / references / implementation / hover |
| `<leader>rn` / `ca` | Rename / code action |
| `<leader>ds` / `ws` | Document / workspace symbols |
| `[d` / `]d` / `<leader>e` | Previous / next diagnostic / show diagnostic |
| `<leader>gg` | Toggle lazygit |
| `<C-,>` | Toggle Claude Code terminal |
| `<C-\>` | Toggle a plain terminal |
| `<leader>mp` | Markdown preview |
| `<C-h/j/k/l>` | Move between windows |

### Built-in habits (no config, just practice)

| Key | Action |
| --- | --- |
| `<C-^>` | Toggle to the alternate buffer |
| `<C-o>` / `<C-i>` | Jumplist back / forward, crosses buffers |
| `:b part<Tab>` | Complete on any substring of a buffer name |
| `mQ` ... `'Q` | Uppercase marks are global and persist: a pinned file set |

These are also listed on the start screen. Trim lines there as they become
muscle memory.

## Setup

Requires Neovim 0.11 or newer, a Nerd Font, `ripgrep`, `cmake` (for
fzf-native) and `lazygit`. Clone the dotfiles repo, symlink this directory to
`~/.config/nvim`, and start Neovim. lazy.nvim bootstraps itself and installs
everything pinned in `lazy-lock.json`. Language servers and formatters are
installed by Mason on first use; run `:Mason` to see them.
