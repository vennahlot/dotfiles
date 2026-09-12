-- Neovim development helper.
return {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
        library = {
            -- Load the luv types shipped with lua-language-server when `vim.uv`
            -- is found (replaces the separate luvit-meta plugin).
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
}
