-- Neovim development helper.
return {
  "folke/lazydev.nvim",
  dependencies = {
      "Bilal2453/luvit-meta", -- optional `vim.uv` typings
  },
  ft = "lua", -- only load on lua files
  opts = {
    library = {
      -- Load luvit types when the `vim.uv` word is found
      { path = "luvit-meta/library", words = { "vim%.uv" } },
    },
  },
}
