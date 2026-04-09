-- Code completion
return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",  -- Completion source LSP
        "hrsh7th/cmp-buffer",    -- Completion source: open buffers
        "hrsh7th/cmp-path",      -- Completion source: file paths
        "onsails/lspkind.nvim",  -- Icons for LSP
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")

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
                    symbol_map = {},
                }),
                expandable_indicator = false,
                fields = { 'abbr', 'kind', 'menu' },
            },
            sources = {
                { name = "lazydev",  group_index = 1 },
                { name = "nvim_lsp", group_index = 2 },
                { name = "buffer",   group_index = 3 },
                { name = "path",     group_index = 3 },
            },
        })
    end,
}
