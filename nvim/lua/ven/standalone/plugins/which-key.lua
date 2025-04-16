-- Keymapping
return {
    "folke/which-key.nvim",
    config = function()
        local wk = require("which-key")
        wk.add({
            mode = { "n", "v" },
            { "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "find buffers" },
            { "<leader>b", "<cmd>DapToggleBreakpoint<cr>", desc = "toggle [B]reakpoint" },
            { "<leader>c", group = "[C]opilot" },
            { "<leader>cc", "<cmd>CopilotChat<cr>", desc = "[C]hat" },
            { "<leader>cd", "<cmd>CopilotChatDocs<cr>", desc = "add [D]ocumentation" },
            { "<leader>ce", "<cmd>CopilotChatExplain<cr>", desc = "[E]xplain" },
            { "<leader>cf", "<cmd>CopilotChatFix<cr>", desc = "[F]ix" },
            { "<leader>co", "<cmd>CopilotChatOptimize<cr>", desc = "[O]ptimize" },
            { "<leader>cr", "<cmd>CopilotChatReview<cr>", desc = "[R]eview" },
            { "<leader>ct", "<cmd>CopilotChatTests<cr>", desc = "generate [T]ests" },
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
