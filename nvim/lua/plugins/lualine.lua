-- Statusline. Per window, so each split names its own file.
return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      component_separators = "",
      section_separators = "",
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { "filename", path = 1 }, { "filetype", icon_only = true } },
      lualine_c = { "branch", "diff" },
      lualine_x = { "diagnostics" },
      lualine_y = {},
      lualine_z = { "progress", "location" },
    },
    inactive_sections = {
      lualine_c = { { "filename", path = 1 }, { "filetype", icon_only = true } },
      lualine_x = { "progress", "location" },
    },
  },
}
