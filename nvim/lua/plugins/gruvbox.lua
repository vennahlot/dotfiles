-- Colorscheme. Loaded eagerly and early so no UI plugin paints before it.
return {
  "ellisonleao/gruvbox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local gruvbox = require("gruvbox")
    gruvbox.setup({
      contrast = "hard",
      -- Gutter in the text background color, not a lighter stripe.
      overrides = { SignColumn = { bg = gruvbox.palette.dark0_hard } },
    })
    vim.cmd.colorscheme("gruvbox")
  end,
}
