return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    dependencies = { "echasnovski/mini.icons", "nvim-tree/nvim-web-devicons" },

    ---@class wk.Opts
    opts = {},
}
