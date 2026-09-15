-- Live markdown preview in the browser
return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  ft = { "markdown" },
  -- Downloads the prebuilt preview server, so no yarn/npm install needed.
  -- The plugin is lazy-loaded, so load it before calling its autoload function.
  build = function()
    vim.cmd("Lazy load markdown-preview.nvim")
    vim.fn["mkdp#util#install"]()
  end,
  keys = {
    { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Markdown [P]review toggle" },
  },
  init = function()
    vim.g.mkdp_auto_close = 0 -- Keep the preview tab open when switching buffers
    vim.g.mkdp_theme = "dark"
  end,
}
