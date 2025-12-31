-- Markdown language configuration

---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        ---@type plugins.treesitter.opts
        opts = {
            ensure_installed = { "markdown", "markdown_inline" },
        },
    },

    {
        "stevearc/conform.nvim",
        ---@type conform.setupOpts
        opts = {
            formatters_by_ft = {
                -- TODO: Switch to mdformat
                markdown = { "prettier" },
            },
        },
    },
}
