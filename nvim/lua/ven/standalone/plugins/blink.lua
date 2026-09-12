-- Code completion
return {
    "saghen/blink.cmp",
    dependencies = {
        "rafamadriz/friendly-snippets", -- Snippet collection for the snippets source
    },
    -- Pinned to v1: v2 is under active development with breaking changes.
    version = "1.*",
    ---@module "blink.cmp"
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "none",
            ["<Tab>"] = { "select_next", "fallback" },
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<CR>"] = { "accept", "fallback" },
            ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },
            ["<C-f>"] = { "scroll_documentation_up", "fallback" },
        },
        appearance = {
            nerd_font_variant = "mono",
        },
        completion = {
            menu = {
                border = "rounded",
                draw = { columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } } },
            },
            documentation = { auto_show = true, auto_show_delay_ms = 200, window = { border = "rounded" } },
        },
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                -- Completion for `require` statements and Neovim API annotations
                lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
            },
        },
        -- Rust matcher, falling back to the Lua one if the binary is unavailable
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
