-- Servers installed by Mason and enabled automatically by mason-lspconfig.
-- jdtls is installed here but started by nvim-jdtls (see plugins/jdtls.lua),
-- so it is excluded from automatic_enable to avoid two clients per buffer.
local SERVERS = { "lua_ls", "pyright", "jdtls" }

-- LSP configs.
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason-org/mason-lspconfig.nvim", -- Mason LSP integration.
    },
    config = function()
        -- Diagnostic display (global config, set once)
        vim.diagnostic.config({
            virtual_text = false,
            severity_sort = true,
            float = { border = "rounded", source = true },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN]  = "",
                    [vim.diagnostic.severity.HINT]  = "",
                    [vim.diagnostic.severity.INFO]  = "",
                },
            },
        })

        -- Buffer-local keymaps, set once per attached client.
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("ven_lsp_attach", { clear = true }),
            callback = function(event)
                local nmap = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[N]ame")
                nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

                nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
                nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
                nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

                -- Diagnostic keymaps
                nmap("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Goto previous diagnostic")
                nmap("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Goto next diagnostic")
                nmap("<leader>e", vim.diagnostic.open_float, "Show diagnostic [E]rror")

                -- See `:help K` for why this keymap
                nmap("K", vim.lsp.buf.hover, "Hover Documentation")
                -- NOTE: signature help is <C-s> in insert mode (a Neovim 0.11+ default).
                -- It is deliberately NOT mapped to <C-k> here, which is window navigation.
            end,
        })

        -- Completion capabilities are contributed by blink.cmp, which registers
        -- them on vim.lsp.config("*") itself on Neovim 0.11+.
        require("mason-lspconfig").setup({
            ensure_installed = SERVERS,
            automatic_enable = { exclude = { "jdtls" } },
        })
    end,
}
