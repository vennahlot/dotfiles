local LSP_TO_INSTALL = {
    "lua_ls", "pyright", "jdtls",
}

-- LSP configs.
local lsp = {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason-lspconfig.nvim", -- Mason LSP integration.
    },
    config = function()
        -- Diagnostic display (global config, set once)
        vim.diagnostic.config({
            virtual_text = false,
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN]  = "",
                    [vim.diagnostic.severity.HINT]  = "",
                    [vim.diagnostic.severity.INFO]  = "",
                },
            },
        })

        local on_attach = function(_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end
                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[N]ame')
            nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

            nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
            nmap('gr', require('telescope.builtin').lsp_references, '[G]oto, [R]eferences')
            nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
            nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            -- Diagnostic keymaps
            nmap('[d', function() vim.diagnostic.jump({ count = -1 }) end, "Goto previous diagnostic")
            nmap(']d', function() vim.diagnostic.jump({ count = 1 }) end, "Goto next diagnostic")

            -- See `:help K` for why this keymap
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', vim.lsp.buf.format, { desc = 'Format current buffer with LSP' })
        end

        -- nvim-cmp supports additional completion capabilities
        local capabilities = require('cmp_nvim_lsp').default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )
        -- Enable the following language servers
        for _, server in ipairs(LSP_TO_INSTALL) do
            vim.lsp.config(server, {
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end
        vim.lsp.enable(LSP_TO_INSTALL)

        require("mason-lspconfig").setup({
            ensure_installed = LSP_TO_INSTALL
        })
    end,
}

return {
    lsp,
}