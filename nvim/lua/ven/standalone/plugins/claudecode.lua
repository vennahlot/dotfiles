-- Claude Code integration via claudecode.nvim
local toggle_key = "<C-,>"
return {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    keys = {
        { toggle_key, "<cmd>ClaudeCodeFocus<cr>", desc = "Claude Code", mode = { "n", "x" } },
    },
    opts = {
        auto_start = true,
        terminal = {
            provider = "snacks",
            auto_close = true,
            snacks_win_opts = {
                position = "float",
                width = 0.85,
                height = 0.85,
                keys = {
                    claude_hide = {
                        toggle_key,
                        function(self)
                            self:hide()
                        end,
                        mode = "t",
                        desc = "Hide",
                    },
                },
            },
        },
        diff_opts = {
            layout = "vertical",
            open_in_new_tab = false,
            keep_terminal_focus = false,
        },
    },
}
