-- Python language configuration
-- LSP: basedpyright/ty (type checking), ruff (linting/formatting)

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
            -- It's fine to have both pyright and basedpyright, so long as only one is installed in the venv. (and they aren't installed system wide)
            -- Have only one means potentially lacking a LSP depending on the project.
            vim.lsp.config("pyright", { capabilities = capabilities })
            vim.lsp.enable("pyright")
            vim.lsp.config("basedpyright", { capabilities = capabilities })
            vim.lsp.enable("basedpyright")
            vim.lsp.config("ruff", { capabilities = capabilities })
            vim.lsp.enable("ruff")
            -- vim.lsp.config("ty", { capabilities = capabilities })
            -- vim.lsp.enable("ty")
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
