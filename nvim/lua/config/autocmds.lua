local augroup = function(name)
  return vim.api.nvim_create_augroup("ven_" .. name, { clear = true })
end

-- [[ Highlight on yank ]]
-- See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("yank_highlight"),
  pattern = "*",
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Stop auto-commenting the next line ]]
-- This has to run per-filetype: the built-in ftplugins set formatoptions
-- themselves, so setting it once at startup gets overwritten.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("format_options"),
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- [[ Reload files changed outside Neovim ]]
-- Coding agents edit files while they are open here. Pick the change up as
-- soon as focus returns instead of waiting for a manual :checktime.
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" and vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})
