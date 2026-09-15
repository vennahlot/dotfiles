-- Fuzzy finder: files, grep, buffers, marks, diagnostics, LSP symbols.
-- LSP pickers on default keys (grr, gO) are wired in plugins/lsp.lua.
return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      -- Native fzf sorter, noticeably faster on large repos.
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
    },
  },
  keys = {
    { "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "Buffers (MRU)" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Word under cursor" },
    { "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Current buffer lines" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
    { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
    { "<leader>fs", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace symbols" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
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
    require("telescope").load_extension("fzf")
  end,
}
