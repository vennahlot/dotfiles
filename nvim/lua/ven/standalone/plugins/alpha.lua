-- alpha.lua is a plugin that displays a start screen when opening Neovim.
return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local theta = require("alpha.themes.theta")

        -- A small reminder of built-in buffer habits, shown on every start.
        -- Trim lines as they become muscle memory.
        local habits = {
            type = "group",
            val = {
                { type = "text", val = "Buffer habits", opts = { hl = "SpecialComment", position = "center" } },
                { type = "padding", val = 1 },
                {
                    type = "text",
                    val = {
                        "<C-^>          alternate buffer",
                        "<C-o> / <C-i>  jumplist back / forward",
                        ":b part<Tab>   jump by partial name",
                        "mQ .. 'Q       global marks = pinned files",
                        "SPC SPC        buffers (MRU), <C-x> deletes",
                        "SPC b d/o/a    delete / close others / close all",
                    },
                    opts = { hl = "Comment", position = "center" },
                },
            },
            position = "center",
        }
        table.insert(theta.config.layout, { type = "padding", val = 2 })
        table.insert(theta.config.layout, habits)

        require("alpha").setup(theta.config)
    end,
}
