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
        local builtin = require("telescope.builtin")
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        map("gd", vim.lsp.buf.definition, "Goto definition")
        map("grr", builtin.lsp_references, "References")
        map("gO", builtin.lsp_document_symbols, "Document symbols")
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
