---@module 'render-markdown'

---@type LazyPluginSpec
return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },

    ---@type render.md.UserConfig
    opts = {
        completions = { lsp = { enabled = true } },
        file_types = { "markdown" },
        render_modes = { "n", "c", "t", "v", "V", "i" },
        heading = { position = "inline", border = true, border_virtual = true },
        code = { width = "block", min_width = 45 },
    },
}
