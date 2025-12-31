-- Python language configuration
-- LSP: pyright (type checking), ruff (linting/formatting)

---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "python" },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = function()
            local capabilities = _G.LspCapabilities and _G.LspCapabilities() or {}
            vim.lsp.config("pyright", { capabilities = capabilities })
            vim.lsp.config("ruff", { capabilities = capabilities })
            vim.lsp.enable("pyright")
            vim.lsp.enable("ruff")
        end,
    },

    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
            },
        },
    },
}
