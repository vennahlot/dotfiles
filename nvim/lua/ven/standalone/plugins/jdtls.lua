-- Java language server. jdtls needs a per-project workspace and manual start,
-- which plain lspconfig does not do; the launch lives in ftplugin/java.lua.
return {
    "mfussenegger/nvim-jdtls",
    ft = "java",
}
