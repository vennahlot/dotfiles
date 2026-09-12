-- [[ Highlight on yank ]]
-- See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("ven_yank_highlight", { clear = true }),
  pattern = "*",
  callback = function()
    vim.hl.on_yank()
  end,
})
