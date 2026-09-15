-- Start screen: recent files, quick links, and a reminder of built-in habits.
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local theta = require("alpha.themes.theta")

    -- Built-ins worth keeping in muscle memory. Trim lines as they stick.
    local habits = {
      type = "group",
      val = {
        { type = "text", val = "Habits", opts = { hl = "SpecialComment", position = "center" } },
        { type = "padding", val = 1 },
        {
          type = "text",
          val = {
            "<C-^>          alternate buffer",
            "<C-o> / <C-i>  jumplist back / forward",
            ":b part<Tab>   jump by partial buffer name",
            "mQ .. 'Q       global marks = pinned files",
            "zM / zR / za   fold to structure / open all / toggle",
            "gd gO grr      definition / symbols / references",
            ":grep  ]q [q   ripgrep into quickfix, walk it",
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
