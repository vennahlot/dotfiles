-- init.lua following the garcia5's pattern:
-- https://github.com/garcia5/dotfiles/blob/master/files/nvim/init.lua

-- Disable providers for faster startup
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

require "ven.standalone.options"
require "ven.standalone.keymaps"

-- Cache lua modules (https://github.com/neovim/neovim/pull/22668)
vim.loader.enable()
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("ven.standalone.plugins", {
  change_detection = {
      -- automatically check for config file changes and reload the ui
      enabled = true,
      notify = false,
  },
})
