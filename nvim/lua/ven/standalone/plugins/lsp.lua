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
            nmap('[d', vim.diagnostic.goto_prev, "Goto previous diagnostic")
            nmap(']d', vim.diagnostic.goto_next, "Goto next diagnostic")

            -- See `:help K` for why this keymap
            nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
            nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', vim.lsp.buf.format or vim.lsp.buf.formatting, { desc = 'Format current buffer with LSP' })

            -- Disable inline error messages.
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics, {
                   virtual_text = false
                }
            )

            -- Diagnostic signs
            vim.fn.sign_define("DiagnosticSignError", { texthl = "DiagnosticSignError", text = "", numhl = "" })
            vim.fn.sign_define("DiagnosticSignWarn", { texthl = "DiagnosticSignWarn", text = "", numhl = "" })
            vim.fn.sign_define("DiagnosticSignHint", { texthl = "DiagnosticSignHint", text = "", numhl = "" })
            vim.fn.sign_define("DiagnosticSignInfo", { texthl = "DiagnosticSignInfo", text = "", numhl = "" })
        end

        -- nvim-cmp supports additional completion capabilities
        local capabilities = require('cmp_nvim_lsp').default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )
        -- Enable the following language servers
        for _, lsp in ipairs(LSP_TO_INSTALL) do
            require('lspconfig')[lsp].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end

        require("mason-lspconfig").setup({
            ensure_installed = LSP_TO_INSTALL
        })
    end,
}

-- Sonar Lint specific configs.
local sonarlint = {
    "https://gitlab.com/schrieveslaach/sonarlint.nvim.git", -- Sonarcloud linter
    ft = {"python", "cpp", "java"},
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
        require("sonarlint").setup({
          server = {
            cmd = {
              vim.fn.expand('$MASON/bin/sonarlint-language-server'),
              "-stdio",
              "-analyzers",
              vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
              vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
              vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
            },
          },
          filetypes = {
            "python",
            "cpp",
            "java",
          },
        })
    end,
}

return {
    lsp,
    sonarlint
}
