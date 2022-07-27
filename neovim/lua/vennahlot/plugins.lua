local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd "packadd packer.nvim"
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  command = 'source <afile> | PackerCompile',
  group = packer_group,
  pattern = vim.fn.expand '$MYVIMRC',
})

-- Use a protected call so we don't error out on first use.
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window.
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded"}
    end,
  },
}

-- Install your plugins here.
return packer.startup(function(use)
  if is_bootstrap then
    require('packer').sync()
  end

 -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself.
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim.
  use "nvim-lua/plenary.nvim" -- Useful lua functions used by lots of plugins

  -- Colorschemes
  use "morhetz/gruvbox"

  -- cmp plugins
  use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp' } }               -- Autocompletion
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } }           -- Snippet Engine and Snippet Expansion

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Fuzzy Finder (files, lsp, etc)
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }

  -- Git
  use 'tpope/vim-fugitive'                                                        -- Git commands in nvim
  use 'tpope/vim-rhubarb'                                                         -- Fugitive-companion to interact with github
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }       -- Add git related info in the signs columns and popups

  -- Treesitter
  use 'nvim-treesitter/nvim-treesitter'                                           -- Highlight, edit, and navigate code
  use 'nvim-treesitter/nvim-treesitter-textobjects'                               -- Additional textobjects for treesitter

  -- Others
  use 'numToStr/Comment.nvim'                                                     -- "gc" to comment visual regions/lines
  use 'nvim-lualine/lualine.nvim'                                                 -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim'                                       -- Add indentation guides even on blank lines
  use 'tpope/vim-sleuth'                                                          -- Detect tabstop and shiftwidth automatically

  -- Automatically set up your configuration after cloning packer.nvim.
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
