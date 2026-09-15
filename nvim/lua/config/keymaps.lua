-- Keymaps for built-in behavior and for the helpers in config/util.lua.
-- Plugin keymaps live in that plugin's spec under lua/plugins/; which-key
-- only names the groups.
local util = require("config.util")
local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- Leader is <Space> (set in init.lua); stop it from also moving the cursor.
map("", "<Space>", "<Nop>")

-- Windows
map("n", "<C-h>", "<C-w>h", "Go to left window")
map("n", "<C-j>", "<C-w>j", "Go to lower window")
map("n", "<C-k>", "<C-w>k", "Go to upper window")
map("n", "<C-l>", "<C-w>l", "Go to right window")

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", "Clear search highlight")

-- Buffers -------------------------------------------------------------------
--
-- Built-in habits worth keeping (no config needed):
--   <C-^>            toggle to the alternate (previous) buffer
--   <C-o> / <C-i>    walk the jumplist backwards / forwards (crosses buffers)
--   :b part<Tab>     complete on any substring of a buffer name; <CR> jumps
--   mQ mW mE mR      uppercase marks are global across files and persist
--   'Q 'W 'E 'R      ... jump to them (a plugin-free "pinned files" set)
--   <leader><leader> Telescope buffers, MRU sorted; <C-x> deletes in-picker
--
-- Added: a close that keeps the window layout, plus cleanup.
map("n", "<leader>bd", function()
  util.bufremove(false)
end, "Delete buffer (keep window)")
map("n", "<leader>bD", function()
  util.bufremove(true)
end, "Delete buffer (force)")
map("n", "<leader>bo", util.bufremove_others, "Close other buffers")
-- Classic idiom: wipe all buffers, reopen the current one, drop the blank one.
map("n", "<leader>ba", "<cmd>%bd|e#|bd#<cr>", "Close all, reopen current")

-- Git -------------------------------------------------------------------------
-- Hunk navigation, preview and blame keys are in plugins/gitsigns.lua.
-- Inside the float, <C-\><C-n> leaves terminal mode; quitting lazygit closes it.
map("n", "<leader>gg", function()
  util.float_term("lazygit")
end, "Lazygit")

-- Terminal --------------------------------------------------------------------
-- A shell float on the key toggleterm used to own. The same key hides it from
-- inside, so within this one buffer <C-\><C-n> is shadowed (timeoutlen is 0, so
-- there is no window to type the second key). Every other terminal -- the
-- lazygit float above, plain :terminal -- keeps <C-\><C-n> for normal mode.
map("n", "<C-\\>", function()
  util.float_term({ vim.o.shell }, "<C-\\>")
end, "Toggle terminal")
