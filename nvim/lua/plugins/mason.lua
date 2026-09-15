-- Package manager for LSP, DAP, linters and formatters.
return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonLog" },
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    -- Keeps the non-LSP tools installed. LSP servers are handled by
    -- mason-lspconfig (plugins/lsp.lua).
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    event = "VeryLazy",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "stylua", -- lua formatter
        "ruff", -- python formatter + import sorter
        "google-java-format", -- java formatter
        "shfmt", -- shell formatter
        "prettier", -- json / yaml / markdown formatter
      },
      run_on_start = true,
      auto_update = false,
    },
  },
}
