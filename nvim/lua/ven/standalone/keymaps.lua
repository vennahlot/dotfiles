-- Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Better window navigation
map("n", "<C-h>", "<C-w>h", "Go to left window")
map("n", "<C-j>", "<C-w>j", "Go to lower window")
map("n", "<C-k>", "<C-w>k", "Go to upper window")
map("n", "<C-l>", "<C-w>l", "Go to right window")

-- Resize with arrows
map("n", "<C-Up>", "<cmd>resize +2<cr>", "Increase window height")
map("n", "<C-Down>", "<cmd>resize -2<cr>", "Decrease window height")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", "Decrease window width")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", "Increase window width")

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", "Clear search highlight")

-- Buffer management -------------------------------------------------------
--
-- Philosophy: use what Vim already has, add only the missing ergonomics.
--
-- Built-in habits worth keeping (no config needed):
--   <C-^>            toggle to the alternate (previous) buffer
--   <C-o> / <C-i>    walk the jumplist backwards / forwards (crosses buffers)
--   :b part<Tab>     complete on any substring of a buffer name; <CR> jumps
--   mQ mW mE mR      uppercase marks are global across files and persist
--   'Q 'W 'E 'R      ... jump to them (a plugin-free "pinned files" set)
--   <leader><leader> Telescope buffers, MRU sorted; <C-x> deletes in-picker
--
-- What is added below: a close that keeps the window layout, plus cleanup.

-- Delete the current buffer without closing the window(s) it is shown in.
-- Each window first moves to the alternate buffer, else the previous one,
-- else a fresh scratch buffer; only then is the buffer deleted.
local function bufremove(force)
  local buf = vim.api.nvim_get_current_buf()
  if not force and vim.bo[buf].modified then
    vim.notify("Buffer is modified, use <leader>bD to force", vim.log.levels.WARN)
    return
  end
  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      local alt = vim.fn.bufnr("#")
      if alt > 0 and alt ~= buf and vim.bo[alt].buflisted then
        vim.cmd.buffer(alt)
      elseif #vim.fn.getbufinfo({ buflisted = 1 }) > 1 then
        vim.cmd("bprevious")
      end
      if vim.api.nvim_get_current_buf() == buf then
        vim.cmd.enew()
      end
    end)
  end
  vim.api.nvim_buf_delete(buf, { force = force })
end

-- Delete every other listed, unmodified buffer.
local function bufremove_others()
  local cur = vim.api.nvim_get_current_buf()
  local n = 0
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if b ~= cur and vim.bo[b].buflisted and not vim.bo[b].modified then
      vim.api.nvim_buf_delete(b, {})
      n = n + 1
    end
  end
  vim.notify(("Closed %d other buffer(s)"):format(n))
end

map("n", "<leader>bd", function() bufremove(false) end, "[D]elete buffer (keep window)")
map("n", "<leader>bD", function() bufremove(true) end, "[D]elete buffer (force)")
map("n", "<leader>bo", bufremove_others, "Close [O]ther buffers")
-- Classic idiom: wipe all buffers, reopen the current one, drop the blank one.
map("n", "<leader>ba", "<cmd>%bd|e#|bd#<cr>", "Close [A]ll, reopen current")
