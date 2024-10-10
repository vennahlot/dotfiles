-- Fuzzy Finder (files, lsp, etc)
return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            -- Use ripgrep for faster search.
            'nvim-telescope/telescope-fzf-native.nvim',
            build = [[
                cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release &&
                cmake --build build --config Release &&
                cmake --install build --prefix build
            ]]
        },
    },
    config = function()
        require("telescope").setup {
          defaults = {
            file_ignore_patterns = {
                "node_modules",
                "venv"
            },
            mappings = {
              i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
              },
            },
          },
        }
        -- Enable telescope fzf native
        require("telescope").load_extension("fzf")
    end,
}
