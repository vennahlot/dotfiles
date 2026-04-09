-- Keymapping
return {
    "folke/which-key.nvim",
    config = function()
        local wk = require("which-key")
        wk.add({
            mode = { "n", "v" },
            { "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "find buffers" },
            { "<leader>a", group = "[A]I (Claude)" },
            { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle [C]laude" },
            { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "[F]ocus Claude" },
            { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "[R]esume Claude" },
            { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "[C]ontinue Claude" },
            { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select [M]odel" },
            { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add [B]uffer" },
            { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "[S]end selection" },
            { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "[A]ccept diff" },
            { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "[D]eny diff" },
            { "<leader>f", group = "[F]ind" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "[B]uffers" },
            { "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[C]urrent buffer" },
            { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "[D]iagnostics" },
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "[F]iles" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "by [G]rep" },
            { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "in [H]elp" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "[R]ecent files" },
            { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "by grep on current [W]ord" },
        })
    end,
}
