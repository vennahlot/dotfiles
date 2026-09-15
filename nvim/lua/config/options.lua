-- Only options that differ from Neovim's defaults, grouped by purpose.
-- Per-project indentation comes from .editorconfig (built-in support);
-- the values here are the fallback.
local o = vim.opt

-- Look
o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes" -- keep the gutter from shifting text
o.colorcolumn = { "80", "120" }
o.list = true -- show tabs, trailing spaces, nbsp
o.showmode = false -- the statusline shows the mode
o.showtabline = 0 -- buffers are reached through the picker, never a tab bar
o.wrap = false
o.scrolloff = 8
o.sidescrolloff = 8
o.splitright = true
o.splitbelow = true

-- Search
o.ignorecase = true
o.smartcase = true
o.grepprg = "rg --vimgrep --smart-case" -- :grep fills the quickfix list; walk it with ]q [q
o.grepformat = "%f:%l:%c:%m"

-- Reading code: fold by syntax, start fully open, show the folded line itself.
-- zM collapses a file to its structure, zR opens everything, za toggles one.
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldlevelstart = 99
o.foldtext = ""
o.fillchars:append({ fold = " " })
o.jumpoptions:append("view") -- <C-o> restores the scroll position, not just the cursor

-- Editing
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.undofile = true
o.swapfile = false -- undofile covers recovery; avoids E325 when two panes open one file
o.clipboard = "unnamedplus"
o.completeopt = { "menu", "menuone", "noselect", "fuzzy", "popup" } -- native LSP completion
o.timeoutlen = 0 -- which-key pops up immediately
