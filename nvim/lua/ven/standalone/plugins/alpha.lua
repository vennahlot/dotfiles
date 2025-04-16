-- alpha.lua is a plugin that displays a start screen when opening Neovim.
return {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = {
        "kyazdani42/nvim-web-devicons",
    },
    config = function()
        require("alpha").setup(require("alpha.themes.theta").config)
    end,
}
