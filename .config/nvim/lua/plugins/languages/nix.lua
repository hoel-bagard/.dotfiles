-- Nix language configuration
-- LSP: nixd, nil

---@type LazyPluginSpec[]
return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = { "nix" },
        },
    },

    {
        "neovim/nvim-lspconfig",
        opts = function()
            local capabilities = _G.LspCapabilities and _G.LspCapabilities() or {}
            vim.lsp.config("nixd", {
                capabilities = capabilities,
                settings = {
                    formatting = {
                        command = { "nixfmt" },
                    },
                },
            })
            vim.lsp.enable("nixd")
            vim.lsp.config("nil", { capabilities = capabilities })
            vim.lsp.enable("nil")
        end,
    },

    -- {
    --     "stevearc/conform.nvim",
    --     opts = {
    --         formatters_by_ft = {
    --             nix = { "nixfmt", "alejandra" },
    --         },
    --     },
    -- },
}
