-- Keymapping
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.add({
      mode = { "n", "v" },
      { "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "find buffers (MRU)" },
      { "<leader>b", group = "[B]uffer" },
      { "<leader>c", group = "[C]ode" },
      { "<leader>d", group = "[D]ocument" },
      { "<leader>f", group = "[F]ind" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "[B]uffers" },
      { "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[C]urrent buffer" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "[D]iagnostics" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "[F]iles" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "by [G]rep" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "in [H]elp" },
      { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "[M]arks" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "[R]ecent files" },
      { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "by grep on current [W]ord" },
      { "<leader>g", group = "[G]it" },
      { "<leader>m", group = "[M]arkdown" },
      { "<leader>w", group = "[W]orkspace" },
    })
    -- Describe built-in keys so they show up in :WhichKey and stay in memory.
    wk.add({
      mode = { "n" },
      { "<C-^>", desc = "Alternate buffer" },
      { "<C-o>", desc = "Jumplist back (crosses buffers)" },
      { "<C-i>", desc = "Jumplist forward" },
    })
  end,
}
