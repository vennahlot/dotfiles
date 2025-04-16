-- Highlight, edit, and navigate code
return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects", -- Additional textobjects.
    },
    config = function()
        require("nvim-treesitter.configs").setup({
          ensure_installed = {
            "lua", "vim", "vimdoc", "bash", "json", "python", "java", "yaml",
            "markdown", "markdown_inline"
          },
          ignore_install = { "" }, -- List of parsers to ignore installing
          highlight = {
            enable = true, -- false will disable the whole extension
            disable = { "css" }, -- list of language that will be disabled
          },
          autopairs = {
            enable = true,
          },
          indent = { enable = true, disable = { "python", "css" } },
          modules = {},
          auto_install = true,
          sync_install = true,
        })
    end,
}
