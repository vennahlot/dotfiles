-- LSP: servers installed by Mason and enabled by mason-lspconfig.
-- jdtls is installed here but started by nvim-jdtls (see plugins/jdtls.lua),
-- so it is excluded from automatic_enable to avoid two clients per buffer.
local SERVERS = { "lua_ls", "pyright", "jdtls" }

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "mason-org/mason.nvim", cmd = "Mason", opts = { ui = { border = "rounded" } } },
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    vim.diagnostic.config({
      virtual_text = false, -- the gutter sign is enough while reading; <C-w>d shows the message
      severity_sort = true,
      float = { border = "rounded", source = true },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "",
          [vim.diagnostic.severity.INFO] = "",
        },
      },
    })

    -- Neovim 0.11+ already maps these when a server attaches:
    --   grn rename        gra code action     grr references    gri implementation
    --   grt type def      gO document symbols K hover           [d ]d <C-w>d diagnostics
    --   <C-s> signature help (insert)   <C-]> definition (tagfunc)   gq format (formatexpr)
    -- Only what is missing, or upgraded to a Telescope picker, is mapped here.
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("ven_lsp_attach", { clear = true }),
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        -- Native completion, auto-triggered while typing.
        -- <C-n>/<C-p> move, <C-y> accepts, <C-e> dismisses; docs show in a popup.
        if client and client:supports_method("textDocument/completion") then
          vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end

        local builtin = require("telescope.builtin")
        local map = function(mode, keys, func, desc)
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Goto definition")
        map("n", "grr", builtin.lsp_references, "References")
        map("n", "gO", builtin.lsp_document_symbols, "Document symbols")
        map({ "n", "v" }, "<leader>cf", function()
          vim.lsp.buf.format({ async = true })
        end, "Format")
      end,
    })

    require("mason-lspconfig").setup({
      ensure_installed = SERVERS,
      automatic_enable = { exclude = { "jdtls" } },
    })
  end,
}
