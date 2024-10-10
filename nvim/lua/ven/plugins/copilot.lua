-- GitHub Copilot in Neovim.
local copilot = {
    "zbirenbaum/copilot.lua",
    dependencies = {
        "nvim-lua/plenary.nvim", -- for curl, log wrapper
    },
    config = function()
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
        })
    end
}

-- Copilot Chat in Neovim.
local copilot_chat = {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
        { "zbirenbaum/copilot.lua" },
        { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
        debug = true, -- Enable debugging
    },
    -- See Commands section for default commands if you want to lazy load on them
    config = function()
        require("CopilotChat").setup({
          window = {
            layout = "float", -- 'vertical', 'horizontal', 'float', 'replace'
            relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
            width = 0.9, -- fractional width of parent, or absolute width in columns when > 1
            height = 0.8, -- fractional height of parent, or absolute height in rows when > 1
          },
        })
    end,
}

return {
    copilot,
    copilot_chat,
}
