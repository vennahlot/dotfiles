local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

-- remap leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function notify(cmd)
    return string.format("<cmd>call VSCodeNotify('%s')<CR>", cmd)
end

-- local function v_notify(cmd)
--     return string.format("<cmd>call VSCodeNotifyVisual('%s', 1)<CR>", cmd)
-- ends

keymap('n', 'gr', notify 'editor.action.goToReferences', opts)
keymap('n', '<Leader>ff', notify 'workbench.action.quickOpen', opts) -- find files
keymap('n', '<Leader>fg', notify 'workbench.action.findInFiles', opts) -- use ripgrep to search files
keymap('n', ']d', notify 'editor.action.marker.next', opts) -- go to next diagnostic
keymap('n', '[d', notify 'editor.action.marker.prev', opts) -- go to prev diagnostic

-- keymap('n', '<Leader>t', notify 'workbench.action.terminal.toggleTerminal', opts) -- terminal window

-- keymap('n', '<Leader>xr', notify 'references-view.findReferences', opts) -- language references
-- keymap('n', '<Leader>xd', notify 'workbench.actions.view.problems', opts) -- language diagnostics
-- keymap('n', '<Leader>rn', notify 'editor.action.rename', opts)
-- keymap('n', '<Leader>fm', notify 'editor.action.formatDocument', opts)
-- keymap('n', '<Leader>ca', notify 'editor.action.refactor', opts) -- language code actions

-- keymap('n', '<Leader>ts', notify 'workbench.action.toggleSidebarVisibility', opts)
-- keymap('n', '<Leader>th', notify 'workbench.action.toggleAuxiliaryBar', opts) -- toggle docview (help page)
-- keymap('n', '<Leader>tp', notify 'workbench.action.togglePanel', opts)
-- keymap('n', '<Leader>fc', notify 'workbench.action.showCommands', opts) -- find commands

-- keymap('v', '<Leader>fm', v_notify 'editor.action.formatSelection', opts)
-- keymap('v', '<Leader>ca', v_notify 'editor.action.refactor', opts)
-- keymap('v', '<Leader>fc', v_notify 'workbench.action.showCommands', opts)
