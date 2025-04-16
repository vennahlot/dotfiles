if vim.g.vscode then
  -- VSCode Neovim
  require "ven.vscode.init"
else
  -- Standalone Neovim
  require "ven.standalone.init"
end
