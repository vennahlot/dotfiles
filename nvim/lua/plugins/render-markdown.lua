-- In-buffer markdown rendering: headings, lists, tables and code fences are
-- readable without leaving the terminal. Browser preview stays in
-- plugins/markdown-preview.lua for diagrams and the full page.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = "markdown",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Toggle rendering" },
  },
  opts = {},
}
