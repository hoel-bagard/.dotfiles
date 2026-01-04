---@type LazyPluginSpec
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = { "echasnovski/mini.icons", "nvim-tree/nvim-web-devicons" },

    ---@class wk.Opts
    opts = {
        preset = "modern",
        keys = {
            scroll_down = "<c-d>", -- binding to scroll down inside the popup
            scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        -- sort = { "order", "alphanum", "mod" },
    },
}
