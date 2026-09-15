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
