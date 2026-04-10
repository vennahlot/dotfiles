-- Toggled terminal
return {
    "akinsho/toggleterm.nvim",
    config = function()
        local Terminal = require("toggleterm.terminal").Terminal

        local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
        local claude = Terminal:new({ cmd = "claude", hidden = true, direction = "float" })

        vim.keymap.set("n", "<leader>gg", function() lazygit:toggle() end, { noremap = true, silent = true, desc = "Toggle lazygit" })
        vim.keymap.set({ "n", "t" }, "<C-,>", function() claude:toggle() end, { noremap = true, silent = true, desc = "Toggle claude" })

        require("toggleterm").setup({
          size = 15,
          open_mapping = [[<c-\>]],
          hide_numbers = true,
          shade_filetypes = {},
          shade_terminals = true,
          shading_factor = 2,
          start_in_insert = true,
          insert_mappings = true,
          persist_size = true,
          direction = "float",
          close_on_exit = true,
          shell = vim.o.shell,
          float_opts = {
            border = "curved",
            winblend = 0,
            highlights = {
              border = "Normal",
              background = "Normal",
            },
          },
        })
    end,
}
