-- Shell language configuration
-- LSP: bashls, nushell

---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "bash" },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = function()
            local capabilities = _G.LspCapabilities and _G.LspCapabilities() or {}

            vim.lsp.config("bashls", {
                capabilities = capabilities,
            })
            vim.lsp.enable("bashls")

            vim.lsp.config("nushell", {
                capabilities = capabilities,
            })
            vim.lsp.enable("nushell")
        end,
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                bash = { "shfmt" },
                sh = { "shfmt" },
                -- nu = { "nufmt" },
            },
        },
    },
}
