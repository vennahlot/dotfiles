-- Highlight, edit, and navigate code
local PARSERS = {
  "lua",
  "vim",
  "vimdoc",
  "bash",
  "json",
  "python",
  "java",
  "yaml",
  "markdown",
  "markdown_inline",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main", -- the rewritten API; `master` is the legacy one
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup()
      require("nvim-treesitter").install(PARSERS)

      -- Enable treesitter features via FileType autocommand
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("ven_treesitter_start", { clear = true }),
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
  {
    -- Syntax-aware text objects: select/move by function, class, parameter.
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")

      -- Select: `vaf` a function, `dif` inner function body, etc.
      local objects = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      }
      for key, query in pairs(objects) do
        vim.keymap.set({ "x", "o" }, key, function()
          select.select_textobject(query, "textobjects")
        end, { desc = "Select " .. query })
      end

      -- Move between functions and classes. `]c`/`[c` are left alone:
      -- those are Vim's diff-mode change motions.
      local moves = {
        { key = "]m", fn = "goto_next_start", query = "@function.outer", desc = "Next function start" },
        { key = "]M", fn = "goto_next_end", query = "@function.outer", desc = "Next function end" },
        { key = "[m", fn = "goto_previous_start", query = "@function.outer", desc = "Previous function start" },
        { key = "[M", fn = "goto_previous_end", query = "@function.outer", desc = "Previous function end" },
        { key = "]]", fn = "goto_next_start", query = "@class.outer", desc = "Next class start" },
        { key = "[[", fn = "goto_previous_start", query = "@class.outer", desc = "Previous class start" },
      }
      for _, m in ipairs(moves) do
        vim.keymap.set({ "n", "x", "o" }, m.key, function()
          move[m.fn](m.query, "textobjects")
        end, { desc = m.desc })
      end
    end,
  },
}
