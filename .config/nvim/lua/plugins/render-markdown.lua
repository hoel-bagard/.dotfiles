return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
        file_types = { "markdown" },
        render_modes = { "n", "c", "t", "v", "V", "i" },
        heading = { position = "inline", border = true, border_virtual = true },
        code = { width = "block", min_width = 45 },
    },
}
