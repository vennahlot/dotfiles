-- File explorer that edits a directory as a normal buffer.
return {
  "stevearc/oil.nvim",
  lazy = false, -- so `nvim <dir>` opens oil instead of netrw
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "-",
      function()
        require("oil").open()
      end,
      desc = "Open parent directory",
    },
    {
      function()
        require("oil").toggle_float()
      end,
      desc = "Open parent directory (float)",
    },
  },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
    },
    float = { border = "rounded" },
    keymaps = {
      ["q"] = { "actions.close", mode = "n" },
    },
  },
}
