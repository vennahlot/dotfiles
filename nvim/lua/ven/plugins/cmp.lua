-- Code completion
return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp", -- Completion source LSP
        "zbirenbaum/copilot-cmp",  -- Completion source for Copilot
        "onsails/lspkind.nvim", -- Icons for LSP
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")

        require("copilot_cmp").setup()

        cmp.setup({
            mapping = cmp.mapping.preset.insert {
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete({}),
                ['<CR>'] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            },
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol',
                    maxwidth = 50,
                    ellipsis_char = '...',
                    show_labelDetails = true,
                    symbol_map = { Copilot = "" },
                }),
                expandable_indicator = false,
                fields = { 'abbr', 'kind', 'menu' },
            },
            sources = {
                { name = "lazydev", group_index = 1 },
                { name = "copilot", group_index = 2 },
                { name = "nvim_lsp", group_index = 2 },
            },
        })
    end,
}
