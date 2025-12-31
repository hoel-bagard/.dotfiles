-- TypeScript/JavaScript language configuration
-- LSP: ts_ls

---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "javascript", "typescript" },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = function()
            local capabilities = _G.LspCapabilities and _G.LspCapabilities() or {}
            vim.lsp.config("ts_ls", { capabilities = capabilities })
            vim.lsp.enable("ts_ls")
        end,
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
            },
        },
    },
}
