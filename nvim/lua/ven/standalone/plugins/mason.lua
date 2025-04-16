-- Package manager for LSP, DAP, Linters and formatters.
return {
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()
    end,
}
