-- DAP configurations.
return {
    "mfussenegger/nvim-dap",
    keys = { "<F5>", "<F8>", "<F10>", "<F11>", "<F12>", "<leader>b" },
    cmd = { "DapContinue", "DapToggleBreakpoint", "DapNew" },
    dependencies = {
        "jay-babu/mason-nvim-dap.nvim", -- Mason dap connections
        -- Debugger UI
        {
            "rcarriga/nvim-dap-ui",
            dependencies = { "nvim-neotest/nvim-nio" },
        },
        -- Display virtual text for variable values
        {
            "theHamsta/nvim-dap-virtual-text",
            dependencies = { "nvim-treesitter/nvim-treesitter" },
        },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"]=function()
          dapui.close()
        end

        vim.fn.sign_define('DapBreakpoint',{ text = '' })
        vim.fn.sign_define('DapStopped',{ text = '󰜴'})

        vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
        vim.keymap.set('n', '<F8>', dap.terminate, { desc = 'Debug: Terminate' })
        vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'Debug: Step Over' })
        vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'Debug: Step Into' })
        vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'Debug: Step Out' })
        vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Toggle [B]reakpoint' })

        require("nvim-dap-virtual-text").setup({})

        require("mason-nvim-dap").setup({
          ensure_installed = { "python", "javadbg" },
          automatic_installation = true,
          handlers = {},
        })
    end,
}
