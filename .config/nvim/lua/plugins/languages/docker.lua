-- Docker language configuration

---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        ---@type plugins.treesitter.opts
        opts = {
            ensure_installed = { "dockerfile" },
        },
    },

    {
        "mfussenegger/nvim-lint",
        ---@type plugins.lint.opts
        opts = {
            linters_by_ft = {
                dockerfile = { "hadolint" },
            },
        },
    },
}
