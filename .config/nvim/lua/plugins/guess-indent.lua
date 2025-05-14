-- Automatic indentation style detection for Neovim

---@module "guess-indent"

---@type LazyPluginSpec
return {
    "NMAC427/guess-indent.nvim",
    event = "VeryLazy",

    ---@type GuessIndentConfig
    opts = {},
}
