-- TOML language configuration
-- LSP: taplo

---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "toml" },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = function()
            local capabilities = _G.LspCapabilities and _G.LspCapabilities() or {}
            vim.lsp.config("taplo", {
                capabilities = capabilities,
            })
            vim.lsp.enable("taplo")
        end,
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                toml = { "taplo" },
            },
        },
    },
}
