-- lualine.nvim is a plugin that provides a statusline for Neovim. This plugin is used in the statusline configuration.
return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "AndreM222/copilot-lualine", -- Show copilot status on Lualine.
    },
    config = function()
        local lualine = require("lualine")

        local hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end

        local filetype = {
          "filetype",
          colored = true,   -- Displays filetype icon in color if set to true
          icon_only = true, -- Display only an icon for filetype
        }

        local filename = {
          "filename",
          path = 1,  -- 0 = just filename, 1 = relative path, 2 = absolute path
          file_status = true,  -- displays file status (readonly status, modified status)
        }

        local diff = {
          "diff",
          colored = true,
          symbols = { added = " ", modified = " ", removed = " " },
          cond = hide_in_width
        }

        local diagnostics = {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          sections = { "error", "warn", "info" },
          symbols = { error = " ", warn = " ", info = " "},
          colored = true,
          update_in_insert = false,
          always_visible = true,
        }

        lualine.setup {
          options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = ""},
            section_separators = { left = "", right = ""},
            disabled_filetypes = {
              statusline = {},
              winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
              statusline = 1000,
              tabline = 1000,
              winbar = 1000,
            }
          },
          sections = {
            lualine_a = {"mode"},
            lualine_b = {filename, filetype},
            lualine_c = {"encoding", "branch", diff},
            lualine_x = {"copilot", diagnostics},
            lualine_y = {},
            lualine_z = {"progress", "location"}
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {filename, filetype},
            lualine_x = {"progress", "location"},
            lualine_y = {},
            lualine_z = {}
          },
          tabline = {},
          winbar = {},
          inactive_winbar = {},
          extensions = {}
        }
    end,
}
