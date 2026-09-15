-- Git gutter signs, hunk navigation and blame: the "why is this here" tools.
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(buf)
      local gs = require("gitsigns")
      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
      end
      map("]h", function()
        gs.nav_hunk("next")
      end, "Next hunk")
      map("[h", function()
        gs.nav_hunk("prev")
      end, "Previous hunk")
      map("<leader>gp", gs.preview_hunk, "Preview hunk")
      map("<leader>gb", gs.toggle_current_line_blame, "Toggle line blame")
      map("<leader>gB", function()
        gs.blame_line({ full = true })
      end, "Blame line (full)")
      map("<leader>gd", gs.diffthis, "Diff this file")
    end,
  },
}
