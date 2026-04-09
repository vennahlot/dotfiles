-- Highlight, edit, and navigate code
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects", -- Additional textobjects.
    },
    config = function()
        require("nvim-treesitter").setup({
          ensure_installed = {
            "lua", "vim", "vimdoc", "bash", "json", "python", "java", "yaml",
            "markdown", "markdown_inline"
          },
          auto_install = true,
        })
    end,
}
