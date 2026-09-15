-- Fuzzy Finder (files, lsp, etc)
return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      -- Use ripgrep for faster search.
      "nvim-telescope/telescope-fzf-native.nvim",
      build = [[
                cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release &&
                cmake --build build --config Release &&
                cmake --install build --prefix build
            ]],
    },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "venv",
        },
        mappings = {
          i = {
            ["<C-u>"] = false,
            ["<C-d>"] = false,
          },
        },
      },
      pickers = {
        buffers = {
          -- Most recently used first, so <leader><leader><CR> is "go back".
          sort_mru = true,
          ignore_current_buffer = true,
          mappings = {
            -- Delete the highlighted buffer without leaving the picker.
            i = { ["<C-x>"] = actions.delete_buffer },
            n = { ["dd"] = actions.delete_buffer },
          },
        },
      },
    })
    -- Enable telescope fzf native
    require("telescope").load_extension("fzf")
  end,
}
