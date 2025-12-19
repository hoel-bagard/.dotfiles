---@type LazyPluginSpec
return {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    build = ":UpdateRemotePlugins",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-telescope/telescope.nvim",
        "neovim/nvim-lspconfig",
    },
    opts = {
        server = {
            settings = {
                experimental = {
                    classRegex = { 'class\\s*:\\s*"([^"]*)' },
                },
                includeLanguages = { rust = "html" },
                root_dir = require("lspconfig").util.root_pattern("tailwind.css", "tailwind.config.js"),
            },
        },
        extension = {
            patterns = {
                rust = { 'class: ["](.*)["]' },
                javascript = { "className=['\"](.*)['\"]" },
                typescript = { "className=['\"](.*)['\"]" },
            },
        },
    },
}
