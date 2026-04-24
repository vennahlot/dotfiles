-- Highlight, edit, and navigate code
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects", -- Additional textobjects.
    },
    config = function()
        require("nvim-treesitter").setup()

        -- Install parsers for common languages
        require("nvim-treesitter").install({
            "lua", "vim", "vimdoc", "bash", "json", "python", "java", "yaml",
            "markdown", "markdown_inline"
        })

        -- Enable treesitter features via FileType autocommand
        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                local ok = pcall(vim.treesitter.start)
                if not ok then return end
            end,
        })
    end,
}
