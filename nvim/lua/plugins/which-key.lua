-- Keymap hints. Groups only: the mappings themselves live next to what they call.
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    spec = {
      { "<leader>b", group = "buffer" },
      { "<leader>c", group = "code" },
      { "<leader>f", group = "find" },
      { "<leader>g", group = "git" },
      { "<leader>m", group = "markdown" },
      -- Built-ins worth remembering, listed so :WhichKey shows them.
      { "<C-^>", desc = "Alternate buffer" },
      { "<C-o>", desc = "Jumplist back (crosses buffers)" },
      { "<C-i>", desc = "Jumplist forward" },
    },
  },
}
