-- JSON language configuration

---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        ---@type plugins.treesitter.opts
        opts = {
            ensure_installed = { "json", "jsonc" },
        },
    },

    {
        "stevearc/conform.nvim",
        ---@type conform.setupOpts
        opts = {
            formatters_by_ft = {
                json = { "prettier" },
                jsonc = { "prettier" },
            },
        },
    },

    {
        "mfussenegger/nvim-lint",
        ---@type plugins.lint.opts
        opts = {
            linters_by_ft = {
                json = { "jsonlint" },
            },
        },
    },
}
