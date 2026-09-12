-- Formatting. Formatters themselves are installed by plugins/mason.lua's
-- tool installer; anything missing falls back to the LSP formatter.
return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo", "Format" },
    keys = {
        {
            "<leader>cf",
            function() require("conform").format({ async = true, lsp_format = "fallback" }) end,
            mode = { "n", "v" },
            desc = "[C]ode [F]ormat",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_format", "ruff_organize_imports" },
            java = { "google-java-format" },
            sh = { "shfmt" },
            bash = { "shfmt" },
            json = { "prettier" },
            yaml = { "prettier" },
            markdown = { "prettier" },
        },
        default_format_opts = { lsp_format = "fallback" },
        format_on_save = function(bufnr)
            -- Opt out per buffer with `:let b:disable_autoformat = 1`,
            -- or globally with `:let g:disable_autoformat = 1`.
            if vim.b[bufnr].disable_autoformat or vim.g.disable_autoformat then
                return
            end
            return { timeout_ms = 1000, lsp_format = "fallback" }
        end,
    },
    init = function()
        -- Use conform for gq
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

        vim.api.nvim_create_user_command("Format", function(args)
            require("conform").format({ async = true, lsp_format = "fallback" })
        end, { desc = "Format current buffer" })

        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
        end, { bang = true, desc = "Disable format-on-save (! for this buffer only)" })

        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
        end, { desc = "Re-enable format-on-save" })
    end,
}
